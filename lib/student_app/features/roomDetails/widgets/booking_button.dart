import 'package:flutter/material.dart';
import 'package:student_lib/student_design_system/student_design_system.dart';

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
              : const Text('Cancel request'),
        ),
      );
    }

    if (!available) {
      return const AppPrimaryButton(
        label: 'Booking unavailable',
        expanded: true,
        onPressed: null,
      );
    }

    return AppPrimaryButton(
      label: 'Book room',
      icon: Icons.event_available,
      expanded: true,
      isLoading: isSubmitting,
      onPressed: onBook,
    );
  }
}
