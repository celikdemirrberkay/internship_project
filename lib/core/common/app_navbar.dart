import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internship_project/core/router/app_router.dart';

/// App Navbar
@immutable
final class AppNavbar extends StatefulWidget {
  ///
  const AppNavbar({super.key});

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
          icon: Icon(Icons.timelapse_outlined),
          label: 'Namaz Vakitleri',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_outlined),
          label: 'Tespih',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'Ayarlar',
        ),
      ],
    );
  }
}
