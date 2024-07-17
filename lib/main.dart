import 'package:flutter/material.dart';
import 'package:internship_project/core/init/app_initializer.dart';
import 'package:internship_project/core/router/app_router.dart';
import 'package:internship_project/core/theme/app_theme.dart';

Future<void> main() async {
  /// App initializer
  await AppInitializer.initialize();

  /// Running the app
  runApp(const PrayerTime());
}

/// Root of our application
class PrayerTime extends StatelessWidget {
  ///
  const PrayerTime({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// MaterialApp
    return MaterialApp.router(
      routerConfig: AppRouter.router(isOnboardDone: false),
      debugShowCheckedModeBanner: false,
      title: 'Internship Project',
      theme: AppTheme.lightTheme,
    );
  }
}
