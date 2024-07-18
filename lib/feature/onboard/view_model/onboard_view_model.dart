import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/repositories/local/hive/db_service.dart';
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
      dbName: 'onboardService',
      key: 'isOnboardDone',
      value: true,
    );
    if (response.isLeft) {
      print(response.left);
    }

    /// If set operation success
    if (response.isLeft) {
      await Fluttertoast.showToast(msg: ExceptionMessage.errorOccured.message);
    }
  }
}
