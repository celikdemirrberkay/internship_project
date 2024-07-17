import 'package:hive_flutter/hive_flutter.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/repositories/local/hive/db_service.dart';

/// AppInitializer is a class that initializes the app.
class AppInitializer {
  /// Initialize the app
  static Future<void> initialize() async {
    /// Setting up dependencies
    await setupDependencies();

    /// Initialize Hive DB
    await Hive.initFlutter();

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
}
