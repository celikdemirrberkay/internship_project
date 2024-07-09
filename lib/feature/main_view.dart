import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/common/app_navbar.dart';
import 'package:internship_project/core/router/app_router.dart';

///
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppNavbar(),
      appBar: AppBar(
        centerTitle: false,
        title: FittedBox(
          child: Text(
            'Prayer Times',
            style: GoogleFonts.cookie(
              textStyle: context.appTextTheme.displayMedium,
              color: context.themeData.colorScheme.primary,
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: AppRouter.initialIndex,
        builder: (context, value, child) => SafeArea(
          child: AppRouter.allViewsForBottomNavBar[value],
        ),
      ),
    );
  }
}
