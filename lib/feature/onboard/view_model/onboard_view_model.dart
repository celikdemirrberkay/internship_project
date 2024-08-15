import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_project/core/base/resource.dart';
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
    final response = await localDatabaseService.set<bool>(
      dbName: LocalDatabaseNames.onboardDB.value,
      key: LocalDatabaseKeys.isOnboardDone.value,
      value: true,
    );

    /// If set operation success
    if (response is SuccessState<String>) {
      await Fluttertoast.showToast(
        msg: response.data!,
      );
    }
  }
}
