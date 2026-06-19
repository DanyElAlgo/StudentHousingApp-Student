import 'package:flutter/widgets.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

abstract final class RoomStatus {
  RoomStatus._();

  static const String available = 'Available';
  static const String booked = 'Booked';
  static const String unavailable = 'Unavailable';

  static bool isAvailable(String status) =>
      status.trim().toLowerCase() == available.toLowerCase();

  static String label(BuildContext context, String status) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    switch (status.trim().toLowerCase()) {
      case 'available':
        return l10n.roomStatusAvailable;
      case 'booked':
        return l10n.roomStatusBooked;
      case 'unavailable':
        return l10n.roomStatusUnavailable;
      default:
        return status;
    }
  }
}
