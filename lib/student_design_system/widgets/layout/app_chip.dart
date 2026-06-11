import 'package:flutter/material.dart';

import '../../tokens/app_radii.dart';
import '../../tokens/app_spacing.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.color,
    this.foregroundColor,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? color;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    final Color fg = foregroundColor ?? colors.onSurfaceVariant;

    return Material(
      color: color ?? colors.surfaceContainerHigh,
      borderRadius: AppRadii.sm,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: fg),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(label, style: text.labelLarge?.copyWith(color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}
