import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:internship_project/core/router/app_router.dart';
import 'package:internship_project/core/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';

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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ValueListenableBuilder(
          valueListenable: AppRouter.initialIndex,
          builder: (context, value, child) => Container(
            height: context.screenSizes.dynamicHeight(0.082),
            decoration: BoxDecoration(
              color: context.themeData.colorScheme.onPrimary,
              borderRadius: context.circularBorderRadius(radius: 100),
              border: Border.all(color: context.themeData.colorScheme.secondary),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.screenSizes.dynamicWidth(0.05),
                vertical: context.screenSizes.dynamicHeight(0.014),
              ),
              child: ClipRRect(
                borderRadius: context.circularBorderRadius(radius: 100),
                child: GNav(
                  selectedIndex: AppRouter.initialIndex.value,
                  activeColor: context.themeData.colorScheme.onPrimary,
                  backgroundColor: context.themeData.colorScheme.onPrimary,
                  gap: 8,
                  tabActiveBorder: Border.all(
                    color: context.themeData.colorScheme.primary,
                  ),
                  tabs: [
                    /// Prayer times
                    GButton(
                      padding: EdgeInsets.all(context.screenSizes.dynamicWidth(0.01)),
                      icon: LineIcons.pray,
                      text: 'Namaz Vakitleri',
                      textStyle: _navbarTextStyle(context),
                      backgroundColor: AppTheme.bottomNavbarTextBackgroundColor,
                      leading: CircleAvatar(
                        backgroundColor: context.themeData.colorScheme.onSurface,
                        child: SvgPicture.asset(
                          'assets/svg/praying.svg',
                        ),
                      ),
                    ),

                    /// Rosary counter
                    GButton(
                      padding: EdgeInsets.all(context.screenSizes.dynamicWidth(0.01)),
                      icon: LineIcons.pray,
                      text: 'Zikirmatik',
                      textStyle: _navbarTextStyle(context),
                      backgroundColor: AppTheme.bottomNavbarTextBackgroundColor,
                      leading: CircleAvatar(
                        backgroundColor: context.themeData.colorScheme.onSurface,
                        child: SvgPicture.asset(
                          'assets/svg/prayer.svg',
                        ),
                      ),
                    ),

                    /// Qibla direction
                    GButton(
                      padding: EdgeInsets.all(context.screenSizes.dynamicWidth(0.01)),
                      icon: LineIcons.pray,
                      text: 'Kıble Yönü',
                      textStyle: _navbarTextStyle(context),
                      backgroundColor: AppTheme.bottomNavbarTextBackgroundColor,
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: SvgPicture.asset(
                          'assets/svg/qibla.svg',
                        ),
                      ),
                    ),

                    GButton(
                      padding: EdgeInsets.all(context.screenSizes.dynamicWidth(0.01)),
                      icon: LineIcons.pray,
                      text: 'Kaza  Takip',
                      textStyle: _navbarTextStyle(context),
                      backgroundColor: AppTheme.bottomNavbarTextBackgroundColor,
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: SvgPicture.asset(
                          'assets/svg/missed_prayer.svg',
                        ),
                      ),
                    ),
                  ],
                  onTabChange: (value) {
                    AppRouter.initialIndex.value = value;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _navbarTextStyle(BuildContext context) {
    return GoogleFonts.roboto(
      textStyle: context.textStyles.bodyLarge?.copyWith(
        color: context.themeData.colorScheme.onSecondary,
        fontWeight: context.fontWeights.fwBold,
      ),
    );
  }
}
