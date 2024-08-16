import 'package:internship_project/core/constants/local_database_constants.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:stacked/stacked.dart';

/// Onboard view model
class OnboardViewModel extends BaseViewModel {
  ///
  OnboardViewModel(this.localDatabaseService);

  /// Local database service instance
  final LocalDatabaseService localDatabaseService;

  /// Set onboard done
  Future<void> setOnboardDone() async {
    /// Set onboard done to local database
    await localDatabaseService.set<bool>(
      dbName: LocalDatabaseNames.onboardDB.value,
      key: LocalDatabaseKeys.isOnboardDone.value,
      value: true,
    );
  }
}
