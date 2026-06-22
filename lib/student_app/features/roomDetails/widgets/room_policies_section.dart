import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../rooms/constants/room_policies.dart';
import '../../rooms/repository/models/room_policy.dart';

class RoomPoliciesSection extends StatelessWidget {
  const RoomPoliciesSection({super.key, required this.policies});

  final List<RoomPolicy> policies;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: l10n.detailsPolicies),
        const SizedBox(height: AppSpacing.sm),
        if (policies.isEmpty)
          Text(
            l10n.detailsNoPolicies,
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
