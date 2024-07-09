import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internship_project/core/router/app_router.dart';

/// App Navbar
final class AppNavbar extends StatefulWidget {
  ///
  AppNavbar({
    super.key,
  });

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppRouter.initialIndex.value,
      onTap: (value) => setState(() => AppRouter.initialIndex.value = value),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.timelapse_sharp),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Hello',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
