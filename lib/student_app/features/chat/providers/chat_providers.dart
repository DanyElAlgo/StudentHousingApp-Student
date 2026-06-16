import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/jwt.dart';
import '../../auth/providers/auth_providers.dart'
    show databaseProvider, dioProvider;
import '../repository/chat_local_store.dart';
import '../repository/chat_realtime_service.dart';
import '../repository/chat_repository.dart';
import '../repository/chat_thread_service.dart';
import '../repository/models/chat_message.dart';
import '../repository/models/chat_summary.dart';

final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => ChatRepository(ref.watch(dioProvider)),
);

final chatLocalStoreProvider = Provider<ChatLocalStore>(
  (ref) => ChatLocalStore(ref.watch(databaseProvider)),
);

final currentUserIdProvider = FutureProvider<String?>((ref) async {
  final session = await ref.watch(databaseProvider).readSession();
  return decodeJwtSub(session?.access);
});

final chatRealtimeProvider = Provider.autoDispose<ChatRealtimeService>((ref) {
  final db = ref.watch(databaseProvider);
  final service = ChatRealtimeService(
    tokenProvider: () async => (await db.readSession())?.access,
  );
  ref.onDispose(service.dispose);
  return service;
});

final chatThreadServiceProvider = Provider.autoDispose<ChatThreadService>((ref) {
  return ChatThreadService(
    repository: ref.watch(chatRepositoryProvider),
    store: ref.watch(chatLocalStoreProvider),
    realtime: ref.watch(chatRealtimeProvider),
  );
});

final activeChatIdProvider = NotifierProvider<ActiveChatIdNotifier, int?>(
  ActiveChatIdNotifier.new,
);

class ActiveChatIdNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? chatId) => state = chatId;
}

final chatSessionProvider = Provider.autoDispose<ChatCoordinator>((ref) {
  final coordinator = ChatCoordinator(
    realtime: ref.watch(chatRealtimeProvider),
    store: ref.watch(chatLocalStoreProvider),
    repository: ref.watch(chatRepositoryProvider),
    activeChatId: () => ref.read(activeChatIdProvider),
    resolveUserId: () => ref.read(currentUserIdProvider.future),
  );
  coordinator.start();
  ref.onDispose(coordinator.dispose);
  return coordinator;
});

class ChatCoordinator {
  ChatCoordinator({
    required this.realtime,
    required this.store,
    required this.repository,
    required this.activeChatId,
    required this.resolveUserId,
  });

  final ChatRealtimeService realtime;
  final ChatLocalStore store;
  final ChatRepository repository;
  final int? Function() activeChatId;
  final Future<String?> Function() resolveUserId;

  StreamSubscription<ChatMessage>? _sub;
  String? _userId;

  Future<void> start() async {
    _userId = await resolveUserId();
    _sub = realtime.messages.listen(_onMessage);
    await realtime.start();
  }

  Future<void> _onMessage(ChatMessage message) async {
    await store.saveMessages([message]);

    final convo = await store.getConversation(message.chatId);
    if (convo == null) {
      await _refreshConversations();
      return;
    }

    final isMine = _userId != null && message.senderId == _userId;
    final isActive = activeChatId() == message.chatId;
    await store.upsertConversation(
      convo.copyWith(
        lastMessage: message.message,
        lastMessageAt: message.createdAt,
        unreadCount: (isMine || isActive)
            ? convo.unreadCount
            : convo.unreadCount + 1,
      ),
    );
  }

  Future<void> _refreshConversations() async {
    try {
      final chats = await repository.listChats();
      await store.saveConversations(chats);
    } catch (_) {}
  }

  void dispose() {
    _sub?.cancel();
  }
}

final chatConnectionProvider = StreamProvider.autoDispose<bool>((ref) {
  return ref.watch(chatRealtimeProvider).connectionState;
});

final conversationsProvider = StreamProvider.autoDispose<List<ChatSummary>>((
  ref,
) {
  ref.watch(chatSessionProvider);
  final store = ref.watch(chatLocalStoreProvider);
  final repository = ref.watch(chatRepositoryProvider);
  unawaited(() async {
    try {
      await store.saveConversations(await repository.listChats());
    } catch (_) {}
  }());
  return store.watchConversations();
});

final threadMessagesProvider = StreamProvider.autoDispose
    .family<List<ChatMessage>, int>((ref, chatId) {
      ref.watch(chatSessionProvider);
      return ref.watch(chatLocalStoreProvider).watchMessages(chatId);
    });

final chatActionProvider =
    NotifierProvider.autoDispose<ChatActionController, bool>(
      ChatActionController.new,
    );

class ChatActionController extends Notifier<bool> {
  @override
  bool build() => false;

  Future<ChatActionResult> startChatForRoom(int roomId) async {
    state = true;
    try {
      final chat = await ref.read(chatRepositoryProvider).startChat(
        roomId: roomId,
      );
      await ref.read(chatRealtimeProvider).joinChat(chat.chatId);
      return ChatActionResult.success(chat.chatId);
    } on ChatException catch (e) {
      return ChatActionResult.failure(e.message);
    } catch (_) {
      return ChatActionResult.failure('Could not start the chat.');
    } finally {
      state = false;
    }
  }
}

class ChatActionResult {
  const ChatActionResult.success(this.chatId) : error = null;
  const ChatActionResult.failure(this.error) : chatId = null;

  final int? chatId;
  final String? error;

  bool get isSuccess => chatId != null;
}
