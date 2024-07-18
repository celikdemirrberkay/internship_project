import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/init/app_initializer.dart';
import 'package:internship_project/core/router/app_router.dart';
import 'package:internship_project/core/theme/app_theme.dart';
import 'package:internship_project/repositories/local/hive/db_service.dart';

Future<void> main() async {
  /// App initializer
  await AppInitializer.initialize();

  /// Onboard situation
  final onboardSituation = await _isOnboardDone();

  /// Running the app
  runApp(PrayerTime(isOnboardDone: onboardSituation));
}

/// Is onboard done check method
Future<bool> _isOnboardDone() async {
  /// Onboard situation
  final db = locator<LocalDatabaseService>();
  final isOnboardDone = await db.get<bool?>(
    dbName: 'onboardService',
    key: 'isOnboardDone',
  );

  /// If onboard is not done
  /// Or there is an error from db
  /// Return false
  if (isOnboardDone.isLeft) {
    return false;
  } else {
    return isOnboardDone.right ?? false;
  }
}

/// Root of our application
class PrayerTime extends StatelessWidget {
  ///
  const PrayerTime({
    required this.isOnboardDone,
    super.key,
  });

  /// Is onboard done
  final bool isOnboardDone;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// MaterialApp
    return MaterialApp.router(
      routerConfig: AppRouter.router(isOnboardDone: isOnboardDone),
      debugShowCheckedModeBanner: false,
      title: 'Internship Project',
      theme: AppTheme.lightTheme,
    );
  }
}
