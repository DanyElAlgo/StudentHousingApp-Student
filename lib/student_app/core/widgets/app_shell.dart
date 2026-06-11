import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_lib/student_design_system/student_design_system.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const List<AppBottomNavDestination> _destinations = [
    AppBottomNavDestination(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
    ),
    AppBottomNavDestination(
      icon: Icons.search_outlined,
      selectedIcon: Icons.search,
      label: 'Rooms',
    ),
    AppBottomNavDestination(
      icon: Icons.event_note_outlined,
      selectedIcon: Icons.event_note,
      label: 'Bookings',
    ),
    AppBottomNavDestination(
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeArea: false,
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        destinations: _destinations,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
