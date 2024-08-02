import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/base/resource.dart';
import '../../../service/local/hive/db_service.dart';
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

    /// If set operation success
    if (response is SuccessState<String>) {
      await Fluttertoast.showToast(
        msg: response.data!,
      );
    }
  }
}
