import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:housing_design_system/housing_design_system.dart';

import '../../../core/utils/formatters.dart';
import '../constants/room_status.dart';
import '../repository/models/room.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    final String? firstImage =
        room.imageRoomUrls.isNotEmpty ? room.imageRoomUrls.first : null;
    final bool available = RoomStatus.isAvailable(room.roomStatus);

    final String description = room.description.length > 120
        ? '${room.description.substring(0, 120).trimRight()}…'
        : room.description;

    return AppImageCard(
      onTap: () => context.push('/room/${room.id}'),
      image: firstImage == null
          ? null
          : NetworkImage(resolveImageUrl(firstImage)),
      overlay: available
          ? null
          : AppChip(
              label: RoomStatus.label(context, room.roomStatus),
              color: colors.inverseSurface.withValues(alpha: 0.85),
              foregroundColor: colors.onInverseSurface,
            ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  room.name,
                  style: text.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                formatPrice(room.price),
                style: text.titleSmall?.copyWith(color: colors.primary),
              ),
            ],
          ),
          if (description.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              description,
              style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
