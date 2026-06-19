import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../rooms/providers/room_providers.dart';
import '../../rooms/repository/models/room.dart';
import '../../rooms/widgets/room_card.dart';
import '../widgets/home_header.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Room>> rooms = ref.watch(featuredRoomsProvider);

    return AppScaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(featuredRoomsProvider.future),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxxl,
          ),
          children: [
            const HomeHeader(),
            const SizedBox(height: AppSpacing.xl),
            AppSectionHeader(
              title: l10n.homeFeaturedRooms,
              actionLabel: l10n.homeShowMore,
              onActionPressed: () => context.go('/rooms'),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...rooms.when(
              loading: () => const [
                Padding(
                  padding: EdgeInsets.only(top: AppSpacing.xxl),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
              error: (err, _) => [
                _HomeMessage(
                  icon: Icons.cloud_off_outlined,
                  message: '$err',
                  onRetry: () => ref.invalidate(featuredRoomsProvider),
                ),
              ],
              data: (list) {
                if (list.isEmpty) {
                  return [
                    _HomeMessage(
                      icon: Icons.meeting_room_outlined,
                      message: l10n.homeNoRooms,
                    ),
                  ];
                }
                return [
                  for (final room in list) ...[
                    RoomCard(room: room),
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

class _HomeMessage extends StatelessWidget {
  const _HomeMessage({required this.icon, required this.message, this.onRetry});

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
