import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../tokens/app_elevation.dart';

class AppBottomNavDestination {
  const AppBottomNavDestination({
    required this.icon,
    required this.label,
    this.selectedIcon,
  });

  final IconData icon;
  final IconData? selectedIcon;
  final String label;
}

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final List<AppBottomNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: AppElevation.glassBlurSigma,
          sigmaY: AppElevation.glassBlurSigma,
        ),
        child: NavigationBar(
          backgroundColor: colors.surface.withValues(alpha: 0.8),
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: [
            for (final AppBottomNavDestination d in destinations)
              NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: d.selectedIcon == null ? null : Icon(d.selectedIcon),
                label: d.label,
              ),
          ],
        ),
      ),
    );
  }
}
