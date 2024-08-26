import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/constants/local_database_constants.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:stacked/stacked.dart';

/// MissedPrayerViewmodel is a class that is used to manage the state of the MissedPrayerView.
class MissedPrayerViewmodel extends BaseViewModel {
  /// MissedPrayerViewmodel constructor
  MissedPrayerViewmodel(this._localDatabaseService);

  /// LocalDatabaseService instance
  final LocalDatabaseService _localDatabaseService;

  /// saveMissedPrayerCount method is used to save
  /// missed prayer count to the local database.
  Future<void> saveMissedPrayerCount(String prayerTime, int missedCount) async {
    await _localDatabaseService.set<int>(
      dbName: LocalDatabaseNames.missedPrayerDB.value,
      key: prayerTime,
      value: missedCount,
    );
  }

  /// getMissedPrayerCount method is used to get
  /// missed prayer count from the local database.
  Future<int> getMissedPrayerCount(String prayerTime) async {
    final response = await _localDatabaseService.get<int>(
      dbName: LocalDatabaseNames.missedPrayerDB.value,
      key: prayerTime,
    );
    if (response.data is SuccessState<int>) {
      return response.data!;
    } else {
      return 0;
    }
  }
}
