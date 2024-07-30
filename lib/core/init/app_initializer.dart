import 'package:hive_flutter/hive_flutter.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:internship_project/service/notification/notification_service.dart';

/// AppInitializer is a class that initializes the app.
class AppInitializer {
  /// Initialize the app
  static Future<void> initialize() async {
    /// Setting up dependencies
    await setupDependencies();

    /// Initialize Hive DB
    await Hive.initFlutter();

    /// Initialize Local Notification Service
    await LocalNotificationService.init();

    /// Setting up dependencies
    await _setFirstTimeDhikr();
  }

  /// Set first time dhikr
  static Future<void> _setFirstTimeDhikr() async {
    final db = locator<LocalDatabaseService>();
    await db.set<List<String>>(
      dbName: 'databaseService',
      key: 'dhikrList',
      value: [
        'Subhanallah',
        'Elhamdulillah',
        'Allahu ekber',
        'La ilahe illallah',
      ],
    );
  }

  /// Is onboard done check method
  static Future<bool> isOnboardDone() async {
    /// Onboard situation
    final db = locator<LocalDatabaseService>();
    final isOnboardDone = await db.get<bool?>(
      dbName: 'onboardService',
      key: 'isOnboardDone',
    );

    /// If onboard is not done
    /// Or there is an error from db
    /// Return false
    if (isOnboardDone.runtimeType == ErrorState<bool?>) {
      return false;
    } else {
      return isOnboardDone.data ?? false;
    }
  }
}
