import 'package:hive_flutter/hive_flutter.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/theme/app_theme.dart';
import 'package:internship_project/service/local/theme/theme_service.dart';
import 'package:internship_project/service/notification/background_service.dart';
import 'package:internship_project/service/notification/notification_service.dart';

/// AppInitializer is a class that initializes the app.
class AppInitializer {
  /// Initialize the app
  static Future<void> initialize() async {
    /// Initialize Hive DB
    await Hive.initFlutter();

    /// Setting up dependencies
    await setupDependencies();

    /// Set notification disable for first time
    await _setNotificationDisableForFirstTime();

    /// Configure background service
    await BackgroundService.configureAndStartBackgroundService();

    /// Set theme on first time
    await setThemeOnFirstTime();
  }

  /// Set notification disable for first time
  /// Notifications of the application will only be active if the user opens it
  /// from the settings screen.
  static Future<void> _setNotificationDisableForFirstTime() async {
    await locator<LocalNotificationService>().setNotificationDisableForFirstTime();
  }

  /// Set theme on first time
  static Future<void> setThemeOnFirstTime() async {
    final isDarkTheme = await locator<ThemeService>().getThemePreferences();
    if (isDarkTheme) {
      AppTheme.themePreference.value = AppTheme.darkTheme;
    } else {
      AppTheme.themePreference.value = AppTheme.lightTheme;
    }
  }
}
