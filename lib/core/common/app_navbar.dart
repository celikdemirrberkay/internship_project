import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.themeData.colorScheme.onSurface,
          width: 2,
        ),
        borderRadius: context.circularBorderRadius(radius: 24),
      ),
      child: ClipRRect(
        borderRadius: context.circularBorderRadius(radius: 24),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: context.themeData.colorScheme.onSecondary,
          unselectedItemColor: context.themeData.colorScheme.onSecondary,
          selectedLabelStyle: GoogleFonts.roboto(fontWeight: context.fontWeights.fwBold),
          currentIndex: AppRouter.initialIndex.value,
          onTap: (value) => setState(() => AppRouter.initialIndex.value = value),
          items: [
            /// Prayer Times bar item
            BottomNavigationBarItem(
              backgroundColor: context.themeData.colorScheme.onPrimary,
              tooltip: 'Namaz Vakitleri',
              label: 'Namaz Vakitleri',
              icon: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppRouter.initialIndex.value == 0 ? context.themeData.colorScheme.onPrimary : context.themeData.colorScheme.onSurface,
                  borderRadius: context.circularBorderRadius(radius: 24),
                  border: Border.all(
                    color: AppRouter.initialIndex.value == 0 ? context.themeData.colorScheme.primaryContainer : context.themeData.colorScheme.secondary,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/svg/praying.svg',
                  ),
                ),
              ),
            ),

            /// Rosary  bar item
            BottomNavigationBarItem(
              backgroundColor: context.themeData.colorScheme.onPrimary,
              tooltip: 'Zikirmatik',
              label: 'Zikirmatik',
              icon: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppRouter.initialIndex.value == 1 ? context.themeData.colorScheme.onPrimary : context.themeData.colorScheme.onSurface,
                  borderRadius: context.circularBorderRadius(radius: 24),
                  border: Border.all(
                    color: AppRouter.initialIndex.value == 1 ? context.themeData.colorScheme.primaryContainer : context.themeData.colorScheme.secondary,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/svg/prayer.svg',
                  ),
                ),
              ),
            ),

            /// Qibla way bar item
            BottomNavigationBarItem(
              backgroundColor: context.themeData.colorScheme.onPrimary,
              tooltip: 'Kıble Yönü',
              label: 'Kıble Yönü',
              icon: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppRouter.initialIndex.value == 2 ? context.themeData.colorScheme.onPrimary : context.themeData.colorScheme.onSurface,
                  borderRadius: context.circularBorderRadius(radius: 24),
                  border: Border.all(
                    color: AppRouter.initialIndex.value == 2 ? context.themeData.colorScheme.primaryContainer : context.themeData.colorScheme.secondary,
                    width: 2,
                  ),
                ),
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
      ),
    );
  }
}
