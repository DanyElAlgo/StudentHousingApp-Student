import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_feedback.dart';
import '../../../core/widgets/responsive_layout.dart';
import '../../rooms/constants/room_status.dart';
import '../../rooms/repository/models/room.dart';
import '../providers/room_details_providers.dart';
import '../widgets/booking_button.dart';
import '../widgets/chat_with_owner_button.dart';
import '../widgets/owner_card.dart';
import '../widgets/room_image_carousel.dart';
import '../widgets/room_location_map.dart';
import '../widgets/room_policies_section.dart';
import '../widgets/room_services_section.dart';
import '../widgets/share_room_button.dart';

class RoomDetailsScreen extends ConsumerWidget {
  const RoomDetailsScreen({super.key, required this.roomId});

  final int roomId;

  Future<void> _book(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final error = await ref.read(bookingActionProvider.notifier).book(roomId);
    if (error != null) {
      messenger.showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    if (!context.mounted) return;
    await showAppFeedback(
      context,
      kind: FeedbackKind.success,
      title: l10n.detailsBookingSuccessTitle,
      message: l10n.detailsBookingSuccess,
      actionLabel: l10n.commonOk,
    );
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final error = await ref.read(bookingActionProvider.notifier).cancel(roomId);
    messenger.showSnackBar(
      SnackBar(content: Text(error ?? l10n.detailsRequestCancelled)),
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
                label: AppLocalizations.of(context).commonRetry,
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
    final AppLocalizations l10n = AppLocalizations.of(context);
    final Room room = data.room;
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool available = RoomStatus.isAvailable(room.roomStatus);

    final Widget header = Column(
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
          l10n.detailsPerMonth,
          style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
        ),
        if (!available) ...[
          const SizedBox(height: AppSpacing.sm),
          AppChip(
            label: RoomStatus.label(context, room.roomStatus),
            icon: Icons.do_not_disturb_on_outlined,
          ),
        ],
      ],
    );

    final Widget actions = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: ChatWithOwnerButton(
                roomId: room.id,
                ownerName: room.ownerFullName,
                ownerImageUrl: room.imageUrl,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: ShareRoomButton(room: room)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        BookingButton(
          available: available,
          hasBooking: data.hasBooking,
          isSubmitting: isSubmitting,
          onBook: onBook,
          onCancel: onCancel,
        ),
      ],
    );

    final List<Widget> sections = [
      _Section(
        title: l10n.detailsDescription,
        child: Text(
          room.description.isEmpty
              ? l10n.detailsNoDescription
              : room.description,
          style: text.bodyMedium,
        ),
      ),
      const SizedBox(height: AppSpacing.lg),
      RoomServicesSection(services: room.services),
      const SizedBox(height: AppSpacing.lg),
      RoomPoliciesSection(policies: room.policies),
      const SizedBox(height: AppSpacing.lg),
      AppSectionHeader(title: l10n.detailsLocation),
      const SizedBox(height: AppSpacing.sm),
      RoomLocationMap(latitude: room.latitude, longitude: room.longitude),
      const SizedBox(height: AppSpacing.lg),
      OwnerCard(room: room),
    ];

    if (!Breakpoints.isCompact(context)) {
      return AppScaffold(
        appBar: AppBar(title: Text(room.name)),
        body: CenteredMaxWidth(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 360,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoomImageCarousel(imageUrls: room.imageRoomUrls),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            header,
                            const SizedBox(height: AppSpacing.lg),
                            actions,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  children: sections,
                ),
              ),
            ],
          ),
        ),
      );
    }

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
                header,
                const SizedBox(height: AppSpacing.lg),
                ...sections,
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.lg),
        child: actions,
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
