import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../../core/utils/formatters.dart';
import '../chat_formatters.dart';
import '../chat_thread_args.dart';
import '../providers/chat_providers.dart';
import '../repository/models/chat_message.dart';

class ChatThreadScreen extends ConsumerStatefulWidget {
  const ChatThreadScreen({super.key, required this.chatId, this.args});

  final int chatId;
  final ChatThreadArgs? args;

  @override
  ConsumerState<ChatThreadScreen> createState() => _ChatThreadScreenState();
}

class _ChatThreadScreenState extends ConsumerState<ChatThreadScreen> {
  final TextEditingController _input = TextEditingController();
  final ScrollController _scroll = ScrollController();

  bool _sending = false;
  bool _loadingMore = false;
  bool _hasMore = true;
  int? _lastMarkedId;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(activeChatIdProvider.notifier).set(widget.chatId);
      ref.read(chatThreadServiceProvider).openChat(widget.chatId);
    });
  }

  @override
  void dispose() {
    try {
      ref.read(activeChatIdProvider.notifier).set(null);
    } catch (_) {}
    _scroll.dispose();
    _input.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_hasMore || _loadingMore) return;
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      _loadOlder();
    }
  }

  Future<void> _loadOlder() async {
    final messages = ref.read(threadMessagesProvider(widget.chatId)).value;
    if (messages == null || messages.isEmpty) return;

    setState(() => _loadingMore = true);
    try {
      final fetched = await ref
          .read(chatThreadServiceProvider)
          .loadOlder(widget.chatId, messages.last.id);
      if (fetched < 30 && mounted) _hasMore = false;
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  Future<void> _send(String text) async {
    if (text.isEmpty || _sending) return;

    setState(() => _sending = true);
    try {
      await ref.read(chatThreadServiceProvider).send(widget.chatId, text);
      _input.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  void _markReadUpTo(List<ChatMessage> messages) {
    if (messages.isEmpty) return;
    final newestId = messages.first.id;
    if (_lastMarkedId != null && newestId <= _lastMarkedId!) return;
    _lastMarkedId = newestId;
    ref.read(chatThreadServiceProvider).markRead(widget.chatId, newestId);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final messagesAsync = ref.watch(threadMessagesProvider(widget.chatId));
    final String? currentUserId = ref
        .watch(currentUserIdProvider)
        .value;
    final bool connected =
        ref.watch(chatConnectionProvider).value ??
        ref.read(chatRealtimeProvider).isConnected;

    ref.listen(threadMessagesProvider(widget.chatId), (_, next) {
      final list = next.value;
      if (list != null) _markReadUpTo(list);
    });

    final ChatThreadArgs? args = widget.args;
    final String headerName = (args?.name.isNotEmpty ?? false)
        ? args!.name
        : l10n.chatThreadTitle;
    final String headerImageUrl = args?.imageUrl ?? '';

    return AppScaffold(
      appBar: AppBar(
        title: Row(
          children: [
            AppAvatar(
              radius: 16,
              name: args?.name,
              image: headerImageUrl.isEmpty
                  ? null
                  : NetworkImage(resolveImageUrl(headerImageUrl)),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(headerName, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
      body: Column(
        children: [
          if (!connected) const _ConnectionBanner(),
          Expanded(
            child: messagesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Text('$err', textAlign: TextAlign.center),
                ),
              ),
              data: (messages) => _MessageList(
                messages: messages,
                currentUserId: currentUserId,
                controller: _scroll,
                loadingMore: _loadingMore,
              ),
            ),
          ),
          AppMessageComposer(
            controller: _input,
            onSend: _send,
            hintText: l10n.chatMessageHint,
            enabled: connected && !_sending,
          ),
        ],
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({
    required this.messages,
    required this.currentUserId,
    required this.controller,
    required this.loadingMore,
  });

  final List<ChatMessage> messages;
  final String? currentUserId;
  final ScrollController controller;
  final bool loadingMore;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      final text = Theme.of(context).textTheme;
      return Center(
        child: Text(
          AppLocalizations.of(context).chatNoMessages,
          textAlign: TextAlign.center,
          style: text.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
        ),
      );
    }

    return ListView.builder(
      controller: controller,
      reverse: true,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      itemCount: messages.length + (loadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= messages.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Center(
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }
        final message = messages[index];
        return AppChatBubble(
          message: message.message,
          isMine: currentUserId != null && message.senderId == currentUserId,
          timeLabel: formatThreadTime(message.createdAt),
        );
      },
    );
  }
}

class _ConnectionBanner extends StatelessWidget {
  const _ConnectionBanner();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    return Material(
      color: colors.errorContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 18,
              color: colors.onErrorContainer,
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                AppLocalizations.of(context).chatReconnecting,
                textAlign: TextAlign.center,
                style: text.labelMedium?.copyWith(
                  color: colors.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
