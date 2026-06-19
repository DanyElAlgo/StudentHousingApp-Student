import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../providers/booking_providers.dart';
import '../repository/models/booking_student.dart';
import '../widgets/booking_card.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<BookingStudent>> bookings =
        ref.watch(studentBookingsProvider);

    return AppScaffold(
      appBar: AppBar(title: Text(l10n.bookingsTitle)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(studentBookingsProvider.future),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxxl,
          ),
          children: [
            ...bookings.when(
              loading: () => const [
                Padding(
                  padding: EdgeInsets.only(top: AppSpacing.xxl),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
              error: (err, _) => [
                _BookingsMessage(
                  icon: Icons.cloud_off_outlined,
                  message: '$err',
                  onRetry: () => ref.invalidate(studentBookingsProvider),
                ),
              ],
              data: (list) {
                if (list.isEmpty) {
                  return [
                    _BookingsMessage(
                      icon: Icons.event_note_outlined,
                      message: l10n.bookingsEmpty,
                    ),
                  ];
                }
                final sorted = [...list]
                  ..sort((a, b) => a.bookingStatus.compareTo(b.bookingStatus));
                return [
                  for (final booking in sorted) ...[
                    BookingCard(booking: booking),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingsMessage extends StatelessWidget {
  const _BookingsMessage({
    required this.icon,
    required this.message,
    this.onRetry,
  });

  final IconData icon;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl),
      child: Column(
        children: [
          Icon(icon, size: 48, color: AppColors.onSurfaceVariant),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            textAlign: TextAlign.center,
            style: text.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacing.lg),
            AppSecondaryButton(
              label: AppLocalizations.of(context).commonRetry,
              icon: Icons.refresh,
              onPressed: onRetry,
            ),
          ],
        ],
      ),
    );
  }
}
