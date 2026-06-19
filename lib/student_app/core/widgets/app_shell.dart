import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../features/chat/providers/chat_providers.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(chatSessionProvider);

    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<AppBottomNavDestination> destinations = [
      AppBottomNavDestination(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: l10n.navHome,
      ),
      AppBottomNavDestination(
        icon: Icons.chat_bubble_outline,
        selectedIcon: Icons.chat_bubble,
        label: l10n.navChat,
      ),
      AppBottomNavDestination(
        icon: Icons.search_outlined,
        selectedIcon: Icons.search,
        label: l10n.navSearch,
      ),
      AppBottomNavDestination(
        icon: Icons.event_note_outlined,
        selectedIcon: Icons.event_note,
        label: l10n.navBookings,
      ),
      AppBottomNavDestination(
        icon: Icons.person_outline,
        selectedIcon: Icons.person,
        label: l10n.navProfile,
      ),
    ];

    void onSelected(int index) => navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );

    if (Breakpoints.isCompact(context)) {
      return AppScaffold(
        safeArea: false,
        body: navigationShell,
        bottomNavigationBar: AppBottomNavBar(
          destinations: destinations,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: onSelected,
        ),
      );
    }

    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              backgroundColor: colors.surface,
              labelType: NavigationRailLabelType.all,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: onSelected,
              destinations: [
                for (final AppBottomNavDestination d in destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: d.selectedIcon == null
                        ? null
                        : Icon(d.selectedIcon),
                    label: Text(d.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      ),
    );
  }
}
