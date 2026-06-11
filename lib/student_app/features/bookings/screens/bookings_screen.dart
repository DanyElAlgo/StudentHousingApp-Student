import 'package:flutter/material.dart';
import 'package:student_lib/student_design_system/student_design_system.dart';

/// Placeholder
class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return AppScaffold(
      appBar: AppBar(title: const Text('My bookings')),
      padded: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.event_note_outlined,
              size: 64,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Coming soon', style: text.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your room bookings will show up here.',
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
