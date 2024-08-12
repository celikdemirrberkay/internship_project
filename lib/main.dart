import 'package:flutter/material.dart';
import 'package:internship_project/core/home_widgets/home_widget_manager.dart';
import 'package:internship_project/core/init/app_initializer.dart';
import 'package:internship_project/core/router/app_router.dart';
import 'package:internship_project/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the app
  await AppInitializer.initialize();

  /// Running the app
  runApp(const PrayerTime());

  await HomeWidgetManager().startCountdownOnWidgetForPrayer();
}

/// Root of our application
class PrayerTime extends StatelessWidget {
  ///
  const PrayerTime({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// MaterialApp
    return ValueListenableBuilder(
      valueListenable: AppTheme.themePreference,
      builder: (context, value, child) => MaterialApp.router(
        routerConfig: AppRouter.router(),
        debugShowCheckedModeBanner: false,
        title: 'Internship Project',
        theme: value,
      ),
    );
  }
}
