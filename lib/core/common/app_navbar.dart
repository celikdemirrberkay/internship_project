import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return ClipRRect(
      borderRadius: context.circularBorderRadius(radius: 24),
      child: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        currentIndex: AppRouter.initialIndex.value,
        onTap: (value) => setState(() => AppRouter.initialIndex.value = value),
        selectedItemColor: context.themeData.colorScheme.onPrimary,
        selectedLabelStyle: GoogleFonts.roboto(
          fontWeight: context.fontWeights.fwBold,
        ),
        items: [
          BottomNavigationBarItem(
            backgroundColor: context.themeData.colorScheme.primary,
            tooltip: 'Namaz Vakitleri',
            label: 'Namaz Vakitleri',
            icon: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: context.themeData.colorScheme.onPrimary,
                borderRadius: context.circularBorderRadius(radius: 24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  'assets/svg/praying.svg',
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: context.themeData.colorScheme.primary,
            tooltip: 'Zikirmatik',
            label: 'Zikirmatik',
            icon: SizedBox(
              width: 45,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  'assets/svg/prayer.svg',
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: context.themeData.colorScheme.primary,
            tooltip: 'Kıble Yönü',
            label: 'Kıble Yönü',
            icon: SizedBox(
              width: 45,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  'assets/svg/qibla.svg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
