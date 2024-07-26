import 'package:stacked/stacked.dart';

/// SettingsViewModel class is responsible for the settings view logic.
class SettingsViewModel extends BaseViewModel {
  /// Dark mode status
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  /// Notification status
  bool _isNotificationOpen = false;
  bool get isNotificationOpen => _isNotificationOpen;

  /// Update theme
  void updateTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  /// Update notification
  void updateNotificationStatus() {
    _isNotificationOpen = !_isNotificationOpen;
    notifyListeners();
  }
}
