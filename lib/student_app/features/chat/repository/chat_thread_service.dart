import 'chat_local_store.dart';
import 'chat_realtime_service.dart';
import 'chat_repository.dart';
import 'models/chat_message.dart';

class ChatThreadService {
  ChatThreadService({
    required this.repository,
    required this.store,
    required this.realtime,
  });

  final ChatRepository repository;
  final ChatLocalStore store;
  final ChatRealtimeService realtime;

  Future<void> openChat(int chatId) async {
    await realtime.joinChat(chatId);
    try {
      final page = await repository.fetchMessages(chatId, pageSize: 30);
      await store.saveMessages(page);
      final newestId = _newestId(page);
      if (newestId != null) await markRead(chatId, newestId);
    } catch (_) {}
  }

  Future<int> loadOlder(int chatId, int beforeId) async {
    final page = await repository.fetchMessages(
      chatId,
      beforeMessageId: beforeId,
      pageSize: 30,
    );
    await store.saveMessages(page);
    return page.length;
  }

  Future<void> send(int chatId, String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    await realtime.sendMessage(chatId, trimmed);
  }

  Future<void> markRead(int chatId, int lastMessageId) async {
    try {
      await repository.markRead(chatId, lastMessageId);
    } catch (_) {}
    final convo = await store.getConversation(chatId);
    if (convo != null && convo.unreadCount != 0) {
      await store.upsertConversation(convo.copyWith(unreadCount: 0));
    }
  }

  int? _newestId(List<ChatMessage> page) {
    if (page.isEmpty) return null;
    return page.map((m) => m.id).reduce((a, b) => a > b ? a : b);
  }
}
