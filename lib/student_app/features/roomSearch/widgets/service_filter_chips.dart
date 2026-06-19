import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../rooms/constants/room_services.dart';

class ServiceFilterChips extends StatelessWidget {
  const ServiceFilterChips({
    super.key,
    required this.selectedIds,
    required this.onToggle,
    required this.onClear,
  });

  final Set<int> selectedIds;
  final ValueChanged<int> onToggle;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: l10n.servicesTitle,
          actionLabel: selectedIds.isEmpty ? null : l10n.commonClear,
          onActionPressed: selectedIds.isEmpty ? null : onClear,
        ),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final option in kRoomServiceOptions)
              AppChip(
                label: localizedServiceOptionLabel(l10n, option),
                icon: selectedIds.contains(option.id)
                    ? Icons.check
                    : option.icon,
                onTap: () => onToggle(option.id),
                color: selectedIds.contains(option.id) ? colors.primary : null,
                foregroundColor:
                    selectedIds.contains(option.id) ? colors.onPrimary : null,
              ),
          ],
        ),
      ],
    );
  }
}
