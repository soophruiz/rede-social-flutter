// Thomas e Sophia DEVB
/// Glass Card Component
/// Card com efeito Glassmorphism (vidro fosco)

import 'dart:ui';
import 'package:flutter/material.dart';
import '../design_system/spacing.dart';
import '../design_system/theme_extension.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double blur;
  final VoidCallback? onTap;

  const GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.blur = 10,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<AppThemeExtension>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(
              color: themeExtension?.glassBackground ??
                  (isDark
                      ? const Color.fromRGBO(30, 30, 30, 0.85)
                      : const Color.fromRGBO(255, 255, 255, 0.85)),
              border: Border.all(
                color: themeExtension?.glassBorder ??
                    (isDark
                        ? const Color.fromRGBO(255, 255, 255, 0.1)
                        : const Color.fromRGBO(255, 255, 255, 0.3)),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

