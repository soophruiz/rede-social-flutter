import 'package:flutter/material.dart';
import '../design_system/colors.dart';

import 'feed_page.dart';
import 'messages_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    FeedPage(),
    SearchPage(),
    MessagesPage(),
    NotificationsPage(),
    ProfilePage(),
  ];

  static const List<String> _titles = [
    'Feed',
    'Explorar',
    'Mensagens',
    'Notificações',
    'Perfil',
  ];

  static const List<IconData> _icons = [
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.chat_bubble_rounded,
    Icons.notifications_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
          },
          elevation: 0,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          backgroundColor: isDark ? AppColors.surfaceDark : AppColors.bgLight,
          destinations: List.generate(_titles.length, (index) {
            return NavigationDestination(
              icon: Icon(
                _icons[index],
                color: _currentIndex == index
                    ? AppColors.primary
                    : (isDark
                        ? AppColors.textDarkSecondary
                        : AppColors.textLightSecondary),
              ),
              label: _titles[index],
            );
          }),
        ),
      ),
    );
  }
}
