import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_lib/student_design_system/student_design_system.dart';

import '../../auth/providers/auth_providers.dart';

/// Temporary landing screen
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    return AppScaffold(
      appBar: AppBar(title: const Text('Student Housing')),
      padded: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 64,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text("You're signed in", style: text.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Room browsing and bookings are coming next.',
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppSecondaryButton(
              label: 'Log out',
              icon: Icons.logout,
              onPressed: () =>
                  ref.read(authControllerProvider.notifier).logout(),
            ),
          ],
        ),
      ),
    );
  }
}
