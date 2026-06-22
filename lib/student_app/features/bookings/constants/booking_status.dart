import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

class BookingStatusStyle {
  const BookingStatusStyle({
    required this.foreground,
    required this.background,
    required this.icon,
  });

  final Color foreground;
  final Color background;
  final IconData icon;
}

abstract final class BookingStatus {
  BookingStatus._();

  static const String pending = 'Pending';
  static const String approved = 'Approved';
  static const String rejected = 'Rejected';

  static String label(BuildContext context, String status) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    switch (status.trim().toLowerCase()) {
      case 'approved':
        return l10n.bookingStatusApproved;
      case 'rejected':
        return l10n.bookingStatusRejected;
      case 'pending':
        return l10n.bookingStatusPending;
      default:
        return status;
    }
  }

  static BookingStatusStyle styleFor(BuildContext context, String status) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final AppSemanticColors semantic =
        Theme.of(context).extension<AppSemanticColors>()!;

    switch (status.trim().toLowerCase()) {
      case 'approved':
        return BookingStatusStyle(
          foreground: semantic.success,
          background: semantic.successContainer,
          icon: Icons.check_circle_outline,
        );
      case 'rejected':
        return BookingStatusStyle(
          foreground: colors.error,
          background: colors.errorContainer,
          icon: Icons.cancel_outlined,
        );
      default:
        return BookingStatusStyle(
          foreground: colors.onSurfaceVariant,
          background: colors.surfaceContainerHigh,
          icon: Icons.schedule_outlined,
        );
    }
  }
}
