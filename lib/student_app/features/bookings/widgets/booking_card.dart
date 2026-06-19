import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:housing_design_system/housing_design_system.dart';

import '../constants/booking_status.dart';
import '../repository/models/booking_student.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key, required this.booking});

  final BookingStudent booking;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final BookingStatusStyle style =
        BookingStatus.styleFor(context, booking.bookingStatus);

    return AppCard(
      onTap: () => context.push('/room/${booking.roomId}'),
      child: Row(
        children: [
          Expanded(
            child: Text(
              booking.bookingRoomName,
              style: text.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          AppStatusBadge(
            label: BookingStatus.label(context, booking.bookingStatus),
            icon: style.icon,
            foregroundColor: style.foreground,
            backgroundColor: style.background,
          ),
        ],
      ),
    );
  }
}
