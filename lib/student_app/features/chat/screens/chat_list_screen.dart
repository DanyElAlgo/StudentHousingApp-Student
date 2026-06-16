import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:housing_design_system/housing_design_system.dart';

import '../chat_formatters.dart';
import '../providers/chat_providers.dart';
import '../repository/models/chat_summary.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ChatSummary>> chats = ref.watch(conversationsProvider);

    return AppScaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(conversationsProvider),
        child: chats.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => _ChatListMessage(
            icon: Icons.cloud_off_outlined,
            message: '$err',
            onRetry: () => ref.invalidate(conversationsProvider),
          ),
          data: (list) {
            if (list.isEmpty) {
              return const _ChatListMessage(
                icon: Icons.forum_outlined,
                message:
                    'No chats yet.\nStart one from a room to contact its owner.',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              itemCount: list.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, indent: AppSpacing.xxxl),
              itemBuilder: (_, index) {
                final chat = list[index];
                return AppChatListTile(
                  title: chat.otherParticipantName,
                  subtitle: chat.lastMessage,
                  timeLabel: formatConversationTimestamp(chat.lastMessageAt),
                  unreadCount: chat.unreadCount,
                  onTap: () => context.push(
                    '/chat/${chat.chatId}',
                    extra: chat.otherParticipantName,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ChatListMessage extends StatelessWidget {
  const _ChatListMessage({
    required this.icon,
    required this.message,
    this.onRetry,
  });

  final IconData icon;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xxxl),
          child: Column(
            children: [
              Icon(icon, size: 48, color: AppColors.onSurfaceVariant),
              const SizedBox(height: AppSpacing.md),
              Text(
                message,
                textAlign: TextAlign.center,
                style: text.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Center(
                  child: AppSecondaryButton(
                    label: 'Retry',
                    icon: Icons.refresh,
                    onPressed: onRetry,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
