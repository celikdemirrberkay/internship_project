import 'package:flutter/material.dart';
import 'package:internship_project/core/init/app_initializer.dart';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:internship_project/core/router/app_router.dart';
<<<<<<< HEAD
import 'package:internship_project/core/theme/app_colors.dart';
=======
>>>>>>> 324fc6f (Backend successfully integrated and dependency injection container created.)
=======
import 'package:internship_project/repositories/god_names/god_names_service.dart';
import 'package:internship_project/repositories/model/god_names.dart';
>>>>>>> 9e48148 (God names services added.)
=======
import 'package:internship_project/core/router/app_router.dart';
import 'package:internship_project/core/theme/app_colors.dart';
<<<<<<< HEAD
import 'package:internship_project/feature/prayer_times/view/prayer_times_view.dart';
>>>>>>> ccab5c1 (Navigation logic integrated and Navbar created)
=======
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
=======
import 'package:internship_project/core/theme/app_theme.dart';
>>>>>>> 8196ae1 (Bottom navbar refactoring)

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
        bottomNavigationBarTheme: AppTheme.bottomNavBarThemeData(),
      ),
<<<<<<< HEAD
<<<<<<< HEAD
=======
      home: Scaffold(),
>>>>>>> 9e48148 (God names services added.)
=======
>>>>>>> ccab5c1 (Navigation logic integrated and Navbar created)
    );
  }
}
