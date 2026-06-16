import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';

import '../../rooms/constants/room_policies.dart';
import '../../rooms/repository/models/room_policy.dart';

class RoomPoliciesSection extends StatelessWidget {
  const RoomPoliciesSection({super.key, required this.policies});

  final List<RoomPolicy> policies;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(title: 'Policies'),
        const SizedBox(height: AppSpacing.sm),
        if (policies.isEmpty)
          Text(
            'No policies listed.',
            style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
          )
        else
          for (final policy in policies)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(iconForPolicy(policy.code), size: 20, color: colors.primary),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(policy.description, style: text.bodyMedium),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
