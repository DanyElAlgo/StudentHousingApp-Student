import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../../core/widgets/responsive_layout.dart';
import '../../rooms/repository/models/room.dart';
import '../../rooms/widgets/room_card.dart';
import '../providers/room_search_providers.dart';
import '../widgets/price_range_filter.dart';
import '../widgets/service_filter_chips.dart';
import '../widgets/sort_dropdown.dart';

class RoomSearchScreen extends ConsumerStatefulWidget {
  const RoomSearchScreen({super.key});

  @override
  ConsumerState<RoomSearchScreen> createState() => _RoomSearchScreenState();
}

class _RoomSearchScreenState extends ConsumerState<RoomSearchScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _min = TextEditingController();
  final TextEditingController _max = TextEditingController();
  String? _appliedQuery;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final params = GoRouterState.of(context).uri.queryParameters;
    final name = params['name'] ?? '';
    final min = params['minPrice'] ?? '';
    final max = params['maxPrice'] ?? '';
    final signature = '$name|$min|$max';
    if (signature == _appliedQuery) return;
    _appliedQuery = signature;
    _name.text = name;
    _min.text = min;
    _max.text = max;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref
          .read(roomSearchControllerProvider.notifier)
          .applyFilters(name: name, minPrice: min, maxPrice: max);
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _min.dispose();
    _max.dispose();
    super.dispose();
  }

  void _runSearch() {
    FocusScope.of(context).unfocus();
    final controller = ref.read(roomSearchControllerProvider.notifier);
    controller.setName(_name.text);
    controller.setPriceRange(min: _min.text, max: _max.text);
    controller.search();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final state = ref.watch(roomSearchControllerProvider);
    final controller = ref.read(roomSearchControllerProvider.notifier);

    return AppScaffold(
      appBar: AppBar(title: Text(l10n.searchTitle)),
      body: CenteredMaxWidth(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxxl,
          ),
          children: [
            AppSearchBar(
              controller: _name,
              hintText: l10n.homeSearchHint,
              onSubmitted: (_) => _runSearch(),
            ),
            const SizedBox(height: AppSpacing.lg),
            PriceRangeFilter(minController: _min, maxController: _max),
            const SizedBox(height: AppSpacing.lg),
            ServiceFilterChips(
              selectedIds: state.serviceIds,
              onToggle: controller.toggleService,
              onClear: controller.clearServices,
            ),
            const SizedBox(height: AppSpacing.lg),
            SortDropdown(value: state.sort, onChanged: controller.setSort),
            const SizedBox(height: AppSpacing.lg),
            AppPrimaryButton(
              label: l10n.searchButton,
              icon: Icons.search,
              expanded: true,
              onPressed: _runSearch,
            ),
            const SizedBox(height: AppSpacing.xl),
            _Results(results: state.results),
          ],
        ),
      ),
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({required this.results});

  final AsyncValue<List<Room>> results;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return results.when(
      loading: () => const Padding(
        padding: EdgeInsets.only(top: AppSpacing.xxl),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xxl),
        child: Column(
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 48,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '$err',
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
      data: (rooms) {
        if (rooms.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xxl),
            child: Column(
              children: [
                Icon(
                  Icons.search_off_outlined,
                  size: 48,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.searchNoResults,
                  style: text.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.searchResultsCount(rooms.length),
              style: text.titleSmall?.copyWith(color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.md),
            ResponsiveCardGrid(
              children: [for (final room in rooms) RoomCard(room: room)],
            ),
          ],
        );
      },
    );
  }
}
