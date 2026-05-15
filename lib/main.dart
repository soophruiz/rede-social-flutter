import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app_state.dart';
import 'src/design_system/theme.dart';
import 'src/pages/splash_screen.dart';

void main() {
  runApp(const RedeSocialApp());
}

class RedeSocialApp extends StatefulWidget {
  const RedeSocialApp({super.key});

  @override
  State<RedeSocialApp> createState() => _RedeSocialAppState();
}

class _RedeSocialAppState extends State<RedeSocialApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TRacks',
        themeMode: _themeMode,
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        home: SplashScreen(onThemeToggle: _toggleTheme),
      ),
    );
  }
}
