import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';

enum FeedbackKind { success, failure }

Future<void> showAppFeedback(
  BuildContext context, {
  required FeedbackKind kind,
  required String title,
  required String message,
  required String actionLabel,
}) {
  final bool isCompact = Breakpoints.isCompact(context);

  final Widget content = _FeedbackView(
    kind: kind,
    title: title,
    message: message,
    actionLabel: actionLabel,
    onAction: () => Navigator.of(context).pop(),
  );

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      if (isCompact) {
        return Dialog.fullscreen(child: Center(child: content));
      }
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: content,
        ),
      );
    },
  );
}

class _FeedbackView extends StatelessWidget {
  const _FeedbackView({
    required this.kind,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final FeedbackKind kind;
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final AppSemanticColors? semantics =
        Theme.of(context).extension<AppSemanticColors>();

    final bool isSuccess = kind == FeedbackKind.success;
    final Color accent = isSuccess
        ? (semantics?.success ?? colors.primary)
        : colors.error;
    final IconData icon =
        isSuccess ? Icons.check_circle_outline : Icons.error_outline;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(icon, size: 72, color: accent),
          const SizedBox(height: AppSpacing.lg),
          Text(title, style: text.titleLarge, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            style: text.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          AppPrimaryButton(
            label: actionLabel,
            expanded: true,
            onPressed: onAction,
          ),
        ],
      ),
    );
  }
}
