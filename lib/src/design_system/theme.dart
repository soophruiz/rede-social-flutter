// Thomas e Sophia DEVB
/// App Theme Configuration
/// Define os temas claro e escuro do app com Material 3

import 'package:flutter/material.dart';
import 'colors.dart';
import 'spacing.dart';
import 'typography.dart';
import 'theme_extension.dart';

class AppTheme {
  /// Light Theme
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: AppColors.textLight,
        error: AppColors.error,
        onError: Colors.white,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppThemeExtension.light,
      ],
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textLight,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.headingSm.copyWith(
          color: AppColors.textLight,
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLightSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 16,
      ),
      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          ),
          textStyle: AppTypography.labelLg.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          textStyle: AppTypography.labelLg,
        ),
      ),
      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 2),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          ),
          textStyle: AppTypography.labelLg,
        ),
      ),
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFAFBFC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.borderLight, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.borderLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: AppTypography.bodyMd.copyWith(
          color: AppColors.textLightSecondary,
        ),
        labelStyle: AppTypography.labelMd.copyWith(
          color: AppColors.textLight,
        ),
        errorStyle: AppTypography.labelMd.copyWith(
          color: AppColors.error,
        ),
      ),
      // Card
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        ),
      ),
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFF3F4F6),
        disabledColor: const Color(0xFFE5E7EB),
        selectedColor: AppColors.primary.withValues(alpha: 0.1),
        labelStyle: AppTypography.labelMd.copyWith(
          color: AppColors.textLight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
        ),
      ),
      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.borderLight,
        thickness: 1,
        space: AppSpacing.lg,
      ),
      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        ),
      ),
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypography.headingXl.copyWith(
          color: AppColors.textLight,
        ),
        displayMedium: AppTypography.headingLg.copyWith(
          color: AppColors.textLight,
        ),
        displaySmall: AppTypography.headingMd.copyWith(
          color: AppColors.textLight,
        ),
        headlineMedium: AppTypography.headingSm.copyWith(
          color: AppColors.textLight,
        ),
        headlineSmall: AppTypography.headingXs.copyWith(
          color: AppColors.textLight,
        ),
        titleLarge: AppTypography.bodyLg.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: AppTypography.bodyMd.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: AppTypography.bodySm.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: AppTypography.bodyLg.copyWith(
          color: AppColors.textLight,
        ),
        bodyMedium: AppTypography.bodyMd.copyWith(
          color: AppColors.textLight,
        ),
        bodySmall: AppTypography.bodySm.copyWith(
          color: AppColors.textLightSecondary,
        ),
        labelLarge: AppTypography.labelLg.copyWith(
          color: AppColors.textLight,
        ),
        labelMedium: AppTypography.labelMd.copyWith(
          color: AppColors.textLight,
        ),
        labelSmall: AppTypography.labelSm.copyWith(
          color: AppColors.textLightSecondary,
        ),
      ),
      scaffoldBackgroundColor: AppColors.bgLight,
    );
  }

  /// Dark Theme
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textDark,
        error: AppColors.error,
        onError: Colors.white,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppThemeExtension.dark,
      ],
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.headingSm.copyWith(
          color: AppColors.textDark,
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textDarkSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          ),
          textStyle: AppTypography.labelLg.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          textStyle: AppTypography.labelLg,
        ),
      ),
      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 2),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          ),
          textStyle: AppTypography.labelLg,
        ),
      ),
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDarkAlt,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: AppTypography.bodyMd.copyWith(
          color: AppColors.textDarkSecondary,
        ),
        labelStyle: AppTypography.labelMd.copyWith(
          color: AppColors.textDark,
        ),
        errorStyle: AppTypography.labelMd.copyWith(
          color: AppColors.error,
        ),
      ),
      // Card
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        ),
      ),
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceDarkAlt,
        disabledColor: const Color(0xFF3A3A3A),
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        labelStyle: AppTypography.labelMd.copyWith(
          color: AppColors.textDark,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
        ),
      ),
      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.borderDark,
        thickness: 1,
        space: AppSpacing.lg,
      ),
      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        ),
      ),
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypography.headingXl.copyWith(
          color: AppColors.textDark,
        ),
        displayMedium: AppTypography.headingLg.copyWith(
          color: AppColors.textDark,
        ),
        displaySmall: AppTypography.headingMd.copyWith(
          color: AppColors.textDark,
        ),
        headlineMedium: AppTypography.headingSm.copyWith(
          color: AppColors.textDark,
        ),
        headlineSmall: AppTypography.headingXs.copyWith(
          color: AppColors.textDark,
        ),
        titleLarge: AppTypography.bodyLg.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: AppTypography.bodyMd.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: AppTypography.bodySm.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: AppTypography.bodyLg.copyWith(
          color: AppColors.textDark,
        ),
        bodyMedium: AppTypography.bodyMd.copyWith(
          color: AppColors.textDark,
        ),
        bodySmall: AppTypography.bodySm.copyWith(
          color: AppColors.textDarkSecondary,
        ),
        labelLarge: AppTypography.labelLg.copyWith(
          color: AppColors.textDark,
        ),
        labelMedium: AppTypography.labelMd.copyWith(
          color: AppColors.textDark,
        ),
        labelSmall: AppTypography.labelSm.copyWith(
          color: AppColors.textDarkSecondary,
        ),
      ),
      scaffoldBackgroundColor: AppColors.bgDark,
    );
  }
}

