import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../rooms/constants/room_services.dart';

class RoomServicesSection extends StatelessWidget {
  const RoomServicesSection({super.key, required this.services});

  final List<String> services;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: l10n.servicesTitle),
        const SizedBox(height: AppSpacing.sm),
        if (services.isEmpty)
          Text(
            l10n.detailsNoServices,
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
                  label: localizedLabelForService(l10n, service),
                ),
            ],
          ),
      ],
    );
  }
}
