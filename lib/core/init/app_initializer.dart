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

    /// set Dhikr List for first time
    await _setFirstTimeDhikr();

    /// Set notification disable for first time
    await _setNotificationDisableForFirstTime();
  }

  /// Set notification disable for first time
  /// Notifications of the application will only be active if the user opens it
  /// from the settings screen.
  static Future<void> _setNotificationDisableForFirstTime() async {
    await locator<LocalDatabaseService>().set<bool>(
      dbName: 'notificationDatabase',
      key: 'isNotificationOpen',
      value: false,
    );
  }

  /// Set first time dhikr.
  /// Setting up custom dhikr list for the first time.
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
    if (isOnboardDone is ErrorState<bool?>) {
      return false;
    } else {
      return isOnboardDone.data ?? false;
    }
  }
}
