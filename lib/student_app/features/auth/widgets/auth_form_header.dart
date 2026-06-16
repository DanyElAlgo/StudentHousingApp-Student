import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';

class AuthFormHeader extends StatelessWidget {
  const AuthFormHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: const BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: AppRadii.lg,
          ),
          child: const Icon(
            Icons.home_work_outlined,
            color: AppColors.onPrimaryContainer,
            size: 28,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(title, style: text.headlineMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(
          subtitle,
          style: text.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }
}
