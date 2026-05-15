/// Theme Extensions
/// Extensões de tema para variáveis customizadas

import 'package:flutter/material.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color glassBackground;
  final Color glassBorder;
  final Color cardGradientStart;
  final Color cardGradientEnd;

  const AppThemeExtension({
    required this.glassBackground,
    required this.glassBorder,
    required this.cardGradientStart,
    required this.cardGradientEnd,
  });

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? glassBackground,
    Color? glassBorder,
    Color? cardGradientStart,
    Color? cardGradientEnd,
  }) {
    return AppThemeExtension(
      glassBackground: glassBackground ?? this.glassBackground,
      glassBorder: glassBorder ?? this.glassBorder,
      cardGradientStart: cardGradientStart ?? this.cardGradientStart,
      cardGradientEnd: cardGradientEnd ?? this.cardGradientEnd,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
      ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      glassBackground: Color.lerp(glassBackground, other.glassBackground, t) ??
          glassBackground,
      glassBorder:
          Color.lerp(glassBorder, other.glassBorder, t) ?? glassBorder,
      cardGradientStart: Color.lerp(cardGradientStart, other.cardGradientStart,
              t) ??
          cardGradientStart,
      cardGradientEnd: Color.lerp(
              cardGradientEnd, other.cardGradientEnd, t) ??
          cardGradientEnd,
    );
  }

  // Light theme instance
  static const light = AppThemeExtension(
    glassBackground: Color.fromRGBO(255, 255, 255, 0.85),
    glassBorder: Color.fromRGBO(255, 255, 255, 0.3),
    cardGradientStart: Color(0xFF6C63FF),
    cardGradientEnd: Color(0xFF8B7FFF),
  );

  // Dark theme instance
  static const dark = AppThemeExtension(
    glassBackground: Color.fromRGBO(30, 30, 30, 0.85),
    glassBorder: Color.fromRGBO(255, 255, 255, 0.1),
    cardGradientStart: Color(0xFF5A52D5),
    cardGradientEnd: Color(0xFF6C63FF),
  );
}
