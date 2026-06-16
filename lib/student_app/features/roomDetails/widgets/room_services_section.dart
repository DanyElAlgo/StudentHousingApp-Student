import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';

import '../../rooms/constants/room_services.dart';

class RoomServicesSection extends StatelessWidget {
  const RoomServicesSection({super.key, required this.services});

  final List<String> services;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(title: 'Services'),
        const SizedBox(height: AppSpacing.sm),
        if (services.isEmpty)
          Text(
            'No services listed.',
            style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
          )
        else
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final service in services)
                AppChip(
                  icon: iconForService(service),
                  label: labelForService(service),
                ),
            ],
          ),
      ],
    );
  }
}
