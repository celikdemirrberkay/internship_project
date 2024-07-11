import 'package:flutter/material.dart';
import 'package:internship_project/core/init/app_initializer.dart';
import 'package:internship_project/core/router/app_router.dart';
import 'package:internship_project/core/theme/app_theme.dart';

Future<void> main() async {
  ///
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
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Internship Project',
      theme: ThemeData(
        colorScheme: AppTheme.colorScheme,
        useMaterial3: true,
      ),
    );
  }
}
