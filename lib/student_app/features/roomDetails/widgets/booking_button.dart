import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

class BookingButton extends StatelessWidget {
  const BookingButton({
    super.key,
    required this.available,
    required this.hasBooking,
    required this.isSubmitting,
    required this.onBook,
    required this.onCancel,
  });

  final bool available;
  final bool hasBooking;
  final bool isSubmitting;
  final VoidCallback onBook;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    if (hasBooking) {
      return SizedBox(
        width: double.infinity,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: colors.error,
            foregroundColor: colors.onError,
          ),
          onPressed: isSubmitting ? null : onCancel,
          child: isSubmitting
              ? SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.onError,
                  ),
                )
              : Text(l10n.detailsCancelRequest),
        ),
      );
    }

    if (!available) {
      return AppPrimaryButton(
        label: l10n.detailsBookingUnavailable,
        expanded: true,
        onPressed: null,
      );
    }

    return AppPrimaryButton(
      label: l10n.detailsBookRoom,
      icon: Icons.event_available,
      expanded: true,
      isLoading: isSubmitting,
      onPressed: onBook,
    );
  }
}
