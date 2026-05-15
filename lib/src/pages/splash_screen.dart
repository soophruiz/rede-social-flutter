import 'dart:async';

import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback? onThemeToggle;

  const SplashScreen({this.onThemeToggle, super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F7FA),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4A90E2),
                    Color(0xFF357ABD),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  const BoxShadow(
                    color: Color(0x2E000000),
                    blurRadius: 24,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 60,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'TRacks',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Conectando você à comunidade.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF636E72),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
