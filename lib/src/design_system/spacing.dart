/// Design System Spacing
/// Escalas de espaçamento consistentes

import 'package:flutter/material.dart';

abstract class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

/// Design System Border Radius
abstract class AppBorderRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 9999;
}

/// Design System Shadows
abstract class AppShadows {
  static const BoxShadow xs = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05),
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  static const BoxShadow sm = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.08),
    blurRadius: 4,
    offset: Offset(0, 2),
  );

  static const BoxShadow md = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  static const BoxShadow lg = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.12),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  static const BoxShadow xl = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.15),
    blurRadius: 24,
    offset: Offset(0, 12),
  );

  static List<BoxShadow> get glassLight => [
        BoxShadow(
          color: const Color.fromRGBO(0, 0, 0, 0.06),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get glassDark => [
        BoxShadow(
          color: const Color.fromRGBO(0, 0, 0, 0.3),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];
}
