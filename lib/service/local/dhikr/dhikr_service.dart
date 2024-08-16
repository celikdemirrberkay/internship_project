import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/constants/local_database_constants.dart';
import 'package:internship_project/service/local/hive/db_service.dart';

/// Service class for Dhikr
class DhikrService {
  /// Set first time dhikr list
  Future<void> setFirstTimeDhikr() async {
    await locator<LocalDatabaseService>().set<List<String>>(
      dbName: LocalDatabaseNames.rosaryDB.value,
      key: LocalDatabaseKeys.dhikrList.value,
      value: [
        'Subhanallah',
        'Elhamdulillah',
        'Allahu ekber',
        'La ilahe illallah',
      ],
    );
  }
}
