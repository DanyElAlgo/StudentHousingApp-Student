import 'package:flutter/widgets.dart';

abstract final class AppColors {
  AppColors._();

  // --- Primary (brand green) ---------------------------------------------
  static const Color primary = Color(0xFF003D33);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFB8EDDF);
  static const Color onPrimaryContainer = Color(0xFF00251E);

  // --- Secondary ----------------------------------------------------------
  static const Color secondary = Color(0xFF4E6952);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFC9E7CA);
  static const Color onSecondaryContainer = Color(0xFF0B1F13);

  // --- Tertiary -----------------------------------------------------------
  static const Color tertiary = Color(0xFF1A4F44);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFBDEBDD);
  static const Color onTertiaryContainer = Color(0xFF00201A);

  // --- Error (Material 3 default red set) ---------------------------------
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  // --- Surfaces & text ----------------------------------------------------
  static const Color surface = Color(0xFFF8FAF8);
  static const Color onSurface = Color(0xFF191C1B);
  static const Color onSurfaceVariant = Color(0xFF404946);

  /// Surface tonal tiers (light → dim), taken from the SVG's layered greys.
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F4F2);
  static const Color surfaceContainer = Color(0xFFECEEEC);
  static const Color surfaceContainerHigh = Color(0xFFE6E9E7);
  static const Color surfaceContainerHighest = Color(0xFFE1E3E1);
  static const Color surfaceDim = Color(0xFFD8DAD9);
  static const Color surfaceBright = Color(0xFFF8FAF8);

  // --- Outlines & dividers ------------------------------------------------
  static const Color outline = Color(0xFF707976);
  static const Color outlineVariant = Color(0xFFC0C8C4);

  // --- Inverse (snackbars, etc.) -----------------------------------------
  static const Color inverseSurface = Color(0xFF2D312F);
  static const Color onInverseSurface = Color(0xFFEFF1EF);
  static const Color inversePrimary = Color(0xFF80D4C4);

  // --- Utility ------------------------------------------------------------
  static const Color surfaceTint = primary;
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
}
