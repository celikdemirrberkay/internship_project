import 'package:flutter/material.dart';
import 'core/init/app_initializer.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the app
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
      routerConfig: AppRouter.router(),
      debugShowCheckedModeBanner: false,
      title: 'Internship Project',
      theme: AppTheme.lightTheme,
    );
  }
}
