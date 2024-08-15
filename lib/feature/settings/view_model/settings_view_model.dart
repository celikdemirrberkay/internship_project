import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/constants/local_database_constants.dart';
import 'package:internship_project/core/constants/service_constant.dart';
import 'package:internship_project/core/exception/exception_type.dart';
import 'package:internship_project/core/exception/exception_util.dart';
import 'package:internship_project/core/theme/app_theme.dart';
import 'package:internship_project/model/city.dart';
import 'package:internship_project/service/local/city_name/city_name_service.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:internship_project/service/notification/notification_service.dart';
import 'package:stacked/stacked.dart';

/// SettingsViewModel class is responsible for the settings view logic.
class SettingsViewModel extends BaseViewModel {
  ///
  SettingsViewModel(
    this.cityNameService,
    this.localNotificationService,
    this.localDatabaseService,
  ) {
    fetchNotificationStatus();
    setThemeSwitchStatusOnInit();
  }

  /// CityNameService instance
  final CityNameService cityNameService;

  /// LocalNotificationService instance
  final LocalNotificationService localNotificationService;

  /// Local database service instance
  final LocalDatabaseService localDatabaseService;

  /// City name
  Resource<List<City>> _cityNames = const LoadingState();
  Resource<List<City>> get cityNames => _cityNames;

  /// Dark mode status
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  /// Notification status
  Resource<bool> _isNotificationOpen = const LoadingState();
  Resource<bool> get isNotificationOpen => _isNotificationOpen;

  /// --------------------------------------------------------------------------
  /// Update theme
  Future<void> updateTheme() async {
    if (AppTheme.themePreference.value == AppTheme.lightTheme) {
      AppTheme.themePreference.value = AppTheme.darkTheme;
      _isDarkMode = true;
    } else {
      AppTheme.themePreference.value = AppTheme.lightTheme;
      _isDarkMode = false;
    }
    await localDatabaseService.set<bool>(
      dbName: LocalDatabaseNames.themeDB.value,
      key: LocalDatabaseKeys.isDarkTheme.value,
      value: _isDarkMode,
    );
    notifyListeners();
  }

  /// --------------------------------------------------------------------------
  /// Set theme switch according to the theme
  Future<void> setThemeSwitchStatusOnInit() async {
    final isDarkTheme = await localDatabaseService.get<bool>(
      dbName: LocalDatabaseNames.themeDB.value,
      key: LocalDatabaseKeys.isDarkTheme.value,
    );
    if (isDarkTheme is SuccessState<bool>) {
      _isDarkMode = isDarkTheme.data ?? false;
    } else {
      _isDarkMode = false;
    }
    notifyListeners();
  }

  /// --------------------------------------------------------------------------
  /// Fetch notif status
  Future<void> fetchNotificationStatus() async {
    final notifStatus = await localDatabaseService.get<bool>(
      dbName: LocalDatabaseNames.notificationDB.value,
      key: LocalDatabaseKeys.isNotificationOpen.value,
    );
    _isNotificationOpen = notifStatus;
    notifyListeners();
  }

  /// --------------------------------------------------------------------------
  /// Update notification status
  Future<void> updateNotificationStatus({required bool value}) async {
    if (value == true) {
      /// Set switch to loading state
      _isNotificationOpen = const LoadingState();
      notifyListeners();

      /// Init notification for the first time
      await _initNotification();

      /// Initialize Local Notification Service
      final hasPermission = await localNotificationService.checkNotificationPermission();

      /// If the permission is granted, schedule the notification
      if (hasPermission) {
        await _turnSwitchOnSetNotificationIfPermissionAccess(value);
      } else {
        await _turnSwitchOnShowToastWhenNotificationIsNotGranted();
      }
    }

    /// If switch is off, cancel all notifications
    else {
      await _turnSwitchOff(value);
    }
    notifyListeners();
  }

  /// --------------------------------------------------------------------------
  /// Initialize notification
  Future<void> _initNotification() async {
    await localNotificationService.initNotifications();
  }

  /// --------------------------------------------------------------------------
  /// Set notification
  Future<void> _turnSwitchOnSetNotificationIfPermissionAccess(bool value) async {
    /// Schedule notification for prayer times
    await localNotificationService.scheduleNotificationForPrayerTimes(
      title: LocalNotificationServiceConstants.title.value,
      body: LocalNotificationServiceConstants.body.value,
    );

    final setNotifTrueResponse = await localDatabaseService.set<bool>(
      dbName: LocalDatabaseNames.notificationDB.value,
      key: LocalDatabaseKeys.isNotificationOpen.value,
      value: value,
    );

    if (setNotifTrueResponse is SuccessState<String>) {
      _isNotificationOpen = const SuccessState(true);
    } else {
      _isNotificationOpen = const ErrorState(ExceptionType.errorOccured);
    }
  }

  /// --------------------------------------------------------------------------
  /// If notification is not granted, show a toast message
  Future<void> _turnSwitchOnShowToastWhenNotificationIsNotGranted() async {
    _isNotificationOpen = const SuccessState(false);
    await Fluttertoast.showToast(
      msg: ExceptionUtil.getExceptionMessage(
        ExceptionType.accessDeniedForNotification,
      ),
      toastLength: Toast.LENGTH_LONG,
    );
  }

  /// --------------------------------------------------------------------------
  /// Turn switch off
  Future<void> _turnSwitchOff(bool value) async {
    _isNotificationOpen = const LoadingState();
    notifyListeners();

    /// Cancel all notifications
    await localNotificationService.cancelPrayerTimeNotification();

    final setNotifFalseResponse = await localDatabaseService.set<bool>(
      dbName: LocalDatabaseNames.notificationDB.value,
      key: LocalDatabaseKeys.isNotificationOpen.value,
      value: value,
    );

    if (setNotifFalseResponse is SuccessState<String>) {
      _isNotificationOpen = const SuccessState(false);
    } else {
      _isNotificationOpen = const ErrorState(ExceptionType.errorOccured);
    }
  }

  /// --------------------------------------------------------------------------
  /// Get city names
  Future<void> getCityNames(BuildContext context) async {
    /// Fetching city names from the json file
    final listOfCities = await cityNameService.getTurkeyCities(context);

    /// If the response is success or error, assign the value to the _cityNames
    _cityNames = listOfCities;
    notifyListeners();
  }
}
