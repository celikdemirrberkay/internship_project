import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/constants/local_database_constants.dart';
import 'package:internship_project/service/local/hive/db_service.dart';

/// Service for Onboard
class OnboardService {
  /// Constructor
  OnboardService();

  /// --------------------------------------------------------------------------
  /// Check if onboard is done
  /// Check if onboard is done
  Future<bool> isOnboardDone() async {
    final isOnboardDone = await locator<LocalDatabaseService>().get<bool?>(
      dbName: LocalDatabaseNames.onboardDB.value,
      key: LocalDatabaseKeys.isOnboardDone.value,
    );

    /// If onboard is not done
    if (isOnboardDone is ErrorState<bool?>) {
      /// Return false
      return false;
    } else {
      /// Or there is an error from db
      /// Return false
      return isOnboardDone.data ?? false;
    }
  }
}
