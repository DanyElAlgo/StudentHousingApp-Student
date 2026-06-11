import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_radii.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';
import 'app_color_scheme.dart';

ThemeData get appLightTheme {
  final TextTheme textTheme = AppTypography.textTheme;

  // Filled inputs (search bar, form fields): rounded, subtle fill, 2px focus.
  const double inputRadius = AppRadii.mdValue;
  OutlineInputBorder inputBorder(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(inputRadius)),
        borderSide: BorderSide(color: color, width: width),
      );

  return ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: AppColors.surface,
    splashFactory: InkRipple.splashFactory,

    // --- App bar ----------------------------------------------------------
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.onSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.titleLarge,
    ),

    // --- Cards ------------------------------------------------------------
    cardTheme: const CardThemeData(
      color: AppColors.surfaceContainerLowest,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.lg),
    ),

    // --- Buttons (pill-shaped, 52dp tall) ---------------------------------
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        minimumSize: const Size(64, 52),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        textStyle: textTheme.labelLarge,
        shape: const StadiumBorder(),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(64, 52),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        textStyle: textTheme.labelLarge,
        side: const BorderSide(color: AppColors.outline),
        shape: const StadiumBorder(),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: textTheme.labelLarge,
        shape: const StadiumBorder(),
      ),
    ),

    // --- Inputs -----------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceContainerLow,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      hintStyle: textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
      labelStyle: textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
      prefixIconColor: AppColors.onSurfaceVariant,
      suffixIconColor: AppColors.onSurfaceVariant,
      border: inputBorder(AppColors.outlineVariant),
      enabledBorder: inputBorder(AppColors.outlineVariant),
      focusedBorder: inputBorder(AppColors.primary, 2),
      errorBorder: inputBorder(AppColors.error),
      focusedErrorBorder: inputBorder(AppColors.error, 2),
    ),

    // --- Chips ------------------------------------------------------------
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceContainerHigh,
      labelStyle: textTheme.labelLarge,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.sm),
    ),

    // --- Bottom navigation ------------------------------------------------
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: AppColors.secondaryContainer,
      elevation: 0,
      height: 72,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: WidgetStatePropertyAll<TextStyle?>(textTheme.labelMedium),
      iconTheme: const WidgetStatePropertyAll<IconThemeData>(
        IconThemeData(color: AppColors.onSurfaceVariant),
      ),
    ),

    // --- Misc -------------------------------------------------------------
    dividerTheme: const DividerThemeData(
      color: AppColors.outlineVariant,
      thickness: 1,
      space: AppSpacing.lg,
    ),
    iconTheme: const IconThemeData(color: AppColors.onSurfaceVariant),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.xlValue)),
      ),
    ),
  );
}
