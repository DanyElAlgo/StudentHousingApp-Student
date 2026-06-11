import 'package:flutter/material.dart';
import 'package:student_lib/student_design_system/student_design_system.dart';

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
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: 'Services',
          actionLabel: selectedIds.isEmpty ? null : 'Clear',
          onActionPressed: selectedIds.isEmpty ? null : onClear,
        ),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final option in kRoomServiceOptions)
              AppChip(
                label: option.label,
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
