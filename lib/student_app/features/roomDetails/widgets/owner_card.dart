import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';

import '../../../core/utils/formatters.dart';
import '../../rooms/repository/models/room.dart';

class OwnerCard extends StatelessWidget {
  const OwnerCard({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool hasAvatar = room.imageUrl.trim().isNotEmpty;

    return AppCard(
      color: colors.surfaceContainerLow,
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: colors.surfaceContainerHigh,
            backgroundImage:
                hasAvatar ? NetworkImage(resolveImageUrl(room.imageUrl)) : null,
            child: hasAvatar
                ? null
                : Icon(Icons.person, color: colors.onSurfaceVariant),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Property owner',
                  style:
                      text.labelMedium?.copyWith(color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  room.ownerFullName.isEmpty ? 'Unknown' : room.ownerFullName,
                  style: text.titleSmall,
                ),
                if (room.email.isNotEmpty)
                  Text(
                    room.email,
                    style: text.bodySmall
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                if (room.phoneNumber.isNotEmpty)
                  Text(
                    room.phoneNumber,
                    style: text.bodySmall
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
