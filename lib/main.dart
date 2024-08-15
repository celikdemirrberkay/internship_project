import 'package:flutter/material.dart';
import 'package:internship_project/core/init/app_initializer.dart';
import 'package:internship_project/core/router/app_router.dart';
import 'package:internship_project/core/theme/app_theme.dart';
import 'package:internship_project/service/remote/location/location_service.dart';

Future<void> main() async {
  /// Ensure initialized
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
    return ValueListenableBuilder(
      /// Listen city name to
      /// reconfigure the application according to new city information
      valueListenable: LocationService.cityName,
      builder: (context, value, child) => ValueListenableBuilder(
        /// Listen theme preference to
        /// reconfigure the application according to new theme preference
        valueListenable: AppTheme.themePreference,
        builder: (context, value, child) => MaterialApp.router(
          routerConfig: AppRouter.router(),
          debugShowCheckedModeBanner: false,
          title: 'Internship Project',
          theme: value,
        ),
      ),
    );
  }
}
