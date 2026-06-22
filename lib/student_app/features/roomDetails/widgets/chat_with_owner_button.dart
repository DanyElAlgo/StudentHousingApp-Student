import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../chat/chat_thread_args.dart';
import '../../chat/providers/chat_providers.dart';

class ChatWithOwnerButton extends ConsumerWidget {
  const ChatWithOwnerButton({
    super.key,
    required this.roomId,
    this.ownerName,
    this.ownerImageUrl,
  });

  final int roomId;
  final String? ownerName;
  final String? ownerImageUrl;

  Future<void> _start(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final router = GoRouter.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final result = await ref
        .read(chatActionProvider.notifier)
        .startChatForRoom(roomId);

    if (result.isSuccess) {
      router.push(
        '/chat/${result.chatId}',
        extra: ChatThreadArgs(name: ownerName ?? '', imageUrl: ownerImageUrl),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(content: Text(result.error ?? l10n.chatCouldNotStart)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool busy = ref.watch(chatActionProvider);

    if (busy) {
      return const OutlinedButton(
        onPressed: null,
        child: SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return AppSecondaryButton(
      label: AppLocalizations.of(context).detailsChatButton,
      icon: Icons.chat_bubble_outline,
      onPressed: () => _start(context, ref),
    );
  }
}
