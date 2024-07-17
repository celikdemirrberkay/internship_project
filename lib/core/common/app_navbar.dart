import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internship_project/core/router/app_router.dart';
import 'package:internship_project/core/theme/app_theme.dart';

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
    return Theme(
      data: context.themeData.copyWith(
        bottomNavigationBarTheme: context.themeData.bottomNavigationBarTheme.copyWith(
          selectedItemColor: AppTheme.bottomNavbarTextColor,
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        elevation: 100,
        currentIndex: AppRouter.initialIndex.value,
        onTap: (value) => setState(() => AppRouter.initialIndex.value = value),
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/namaz.svg',
              width: 30,
              height: 30,
            ),
            label: 'Namaz Vakitleri',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/rosary.svg',
              width: 30,
              height: 30,
            ),
            label: 'Tespih',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/compass.svg',
              width: 30,
              height: 30,
            ),
            label: 'Kabe Yönü',
          ),
        ],
      ),
    );
  }
}
