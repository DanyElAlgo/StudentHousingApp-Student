import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../../core/utils/formatters.dart';
import '../chat_formatters.dart';
import '../chat_thread_args.dart';
import '../providers/chat_providers.dart';
import '../repository/models/chat_summary.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<ChatSummary>> chats = ref.watch(conversationsProvider);

    return AppScaffold(
      appBar: AppBar(title: Text(l10n.chatsTitle)),
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
              return _ChatListMessage(
                icon: Icons.forum_outlined,
                message: l10n.chatEmpty,
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
                  timeLabel: formatConversationTimestamp(
                    l10n,
                    chat.lastMessageAt,
                  ),
                  unreadCount: chat.unreadCount,
                  avatar: chat.otherParticipantImageUrl.isEmpty
                      ? null
                      : NetworkImage(
                          resolveImageUrl(chat.otherParticipantImageUrl),
                        ),
                  onTap: () => context.push(
                    '/chat/${chat.chatId}',
                    extra: ChatThreadArgs(
                      name: chat.otherParticipantName,
                      imageUrl: chat.otherParticipantImageUrl,
                    ),
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
                    label: AppLocalizations.of(context).commonRetry,
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
