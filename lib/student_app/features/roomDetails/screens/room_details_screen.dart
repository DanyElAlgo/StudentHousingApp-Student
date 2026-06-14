import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housing_design_system/housing_design_system.dart';

import '../../../core/utils/formatters.dart';
import '../../rooms/constants/room_status.dart';
import '../../rooms/repository/models/room.dart';
import '../providers/room_details_providers.dart';
import '../widgets/booking_button.dart';
import '../widgets/owner_card.dart';
import '../widgets/room_image_carousel.dart';
import '../widgets/room_location_map.dart';
import '../widgets/room_policies_section.dart';
import '../widgets/room_services_section.dart';

class RoomDetailsScreen extends ConsumerWidget {
  const RoomDetailsScreen({super.key, required this.roomId});

  final int roomId;

  Future<void> _book(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final error = await ref.read(bookingActionProvider.notifier).book(roomId);
    messenger.showSnackBar(
      SnackBar(content: Text(error ?? 'Booking made successfully.')),
    );
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final error = await ref.read(bookingActionProvider.notifier).cancel(roomId);
    messenger.showSnackBar(
      SnackBar(content: Text(error ?? 'Request cancelled.')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(roomDetailsProvider(roomId));
    final bool isSubmitting = ref.watch(bookingActionProvider);

    return details.when(
      loading: () => AppScaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => AppScaffold(
        appBar: AppBar(),
        padded: true,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_off_outlined,
                size: 48,
                color: AppColors.onSurfaceVariant,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('$err', textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.lg),
              AppSecondaryButton(
                label: 'Retry',
                icon: Icons.refresh,
                onPressed: () => ref.invalidate(roomDetailsProvider(roomId)),
              ),
            ],
          ),
        ),
      ),
      data: (data) => _DetailsContent(
        data: data,
        isSubmitting: isSubmitting,
        onBook: () => _book(context, ref),
        onCancel: () => _cancel(context, ref),
      ),
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({
    required this.data,
    required this.isSubmitting,
    required this.onBook,
    required this.onCancel,
  });

  final RoomDetailsData data;
  final bool isSubmitting;
  final VoidCallback onBook;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final Room room = data.room;
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool available = RoomStatus.isAvailable(room.roomStatus);

    return AppScaffold(
      appBar: AppBar(title: Text(room.name)),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          RoomImageCarousel(imageUrls: room.imageRoomUrls),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(room.name, style: text.titleLarge)),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      formatPrice(room.price),
                      style: text.titleMedium?.copyWith(color: colors.primary),
                    ),
                  ],
                ),
                Text(
                  '/ month',
                  style:
                      text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                ),
                if (!available) ...[
                  const SizedBox(height: AppSpacing.sm),
                  AppChip(
                    label: room.roomStatus,
                    icon: Icons.do_not_disturb_on_outlined,
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                _Section(
                  title: 'Description',
                  child: Text(
                    room.description.isEmpty
                        ? 'No description provided.'
                        : room.description,
                    style: text.bodyMedium,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                RoomServicesSection(services: room.services),
                const SizedBox(height: AppSpacing.lg),
                RoomPoliciesSection(policies: room.policies),
                const SizedBox(height: AppSpacing.lg),
                const AppSectionHeader(title: 'Location'),
                const SizedBox(height: AppSpacing.sm),
                RoomLocationMap(
                  latitude: room.latitude,
                  longitude: room.longitude,
                ),
                const SizedBox(height: AppSpacing.lg),
                OwnerCard(room: room),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.lg),
        child: BookingButton(
          available: available,
          hasBooking: data.hasBooking,
          isSubmitting: isSubmitting,
          onBook: onBook,
          onCancel: onCancel,
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: title),
        const SizedBox(height: AppSpacing.sm),
        child,
      ],
    );
  }
}
