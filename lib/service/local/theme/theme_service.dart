import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/constants/local_database_constants.dart';
import 'package:internship_project/service/local/hive/db_service.dart';

/// Service for managing the theme of the application.
class ThemeService {
  /// Get theme preferences as boolean
  /// If there is no theme preference, return false
  /// If theme preference is true , its dark theme else light theme
  Future<bool> getThemePreferences() async {
    final isDarkTheme = await locator<LocalDatabaseService>().get<bool>(
      dbName: LocalDatabaseNames.themeDB.value,
      key: LocalDatabaseKeys.isDarkTheme.value,
    );
    if (isDarkTheme is SuccessState<bool>) {
      return isDarkTheme.data ?? false;
    } else {
      return false;
    }
  }
}
