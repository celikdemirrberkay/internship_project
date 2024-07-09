import 'package:flutter/material.dart';
import 'package:internship_project/core/init/app_initializer.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:internship_project/core/router/app_router.dart';
import 'package:internship_project/core/theme/app_colors.dart';
=======
>>>>>>> 324fc6f (Backend successfully integrated and dependency injection container created.)
=======
import 'package:internship_project/repositories/god_names/god_names_service.dart';
import 'package:internship_project/repositories/model/god_names.dart';
>>>>>>> 9e48148 (God names services added.)

Future<void> main() async {
  ///
  await AppInitializer.initialize();

  /// Running the app
  runApp(const PrayerTime());
}

/// Root of our application
class PrayerTime extends StatefulWidget {
  ///
  const PrayerTime({super.key});

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Internship Project',
      theme: ThemeData(
        colorScheme: AppColors.colorScheme,
        useMaterial3: true,
      ),
<<<<<<< HEAD
=======
      home: Scaffold(),
>>>>>>> 9e48148 (God names services added.)
    );
  }
}
