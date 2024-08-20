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
        await _keepSwitchOffShowToastWhenNotificationIsNotGranted();
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
      _isNotificationOpen = const ErrorState(ExceptionTypes.errorOccured);
    }
  }

  /// --------------------------------------------------------------------------
  /// If notification is not granted, show a toast message
  Future<void> _keepSwitchOffShowToastWhenNotificationIsNotGranted() async {
    _isNotificationOpen = const SuccessState(false);
    await Fluttertoast.showToast(
      msg: ExceptionMessager.getExceptionMessage(
        ExceptionTypes.accessDeniedForNotification,
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
    await localNotificationService.cancelAllNotifications();

    final setNotifFalseResponse = await localDatabaseService.set<bool>(
      dbName: LocalDatabaseNames.notificationDB.value,
      key: LocalDatabaseKeys.isNotificationOpen.value,
      value: value,
    );

    if (setNotifFalseResponse is SuccessState<String>) {
      _isNotificationOpen = const SuccessState(false);
    } else {
      _isNotificationOpen = const ErrorState(ExceptionTypes.errorOccured);
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

  /// --------------------------------------------------------------------------
  /// Pick button onpressed
  Future<void> pickButtonOnPressed(int pickerValue) async {
    /// Cancel all notifications at the beginning
    await localNotificationService.cancelAllNotifications();

    /// Set remaining time according to the picker value
    var remainingTime = 0;

    /// Picker value is 5 minutes before the prayer time logic
    if (pickerValue == 0) {
      await localDatabaseService.set<int>(
        dbName: LocalDatabaseNames.remainingTimeDB.value,
        key: LocalDatabaseKeys.isTimeRemainingActive.value,
        value: 5,
      );
      remainingTime = 5;

      await localNotificationService.scheduleNotificationForPrayerTimesMinutesRemaining(
        body: '5 ${LocalNotificationServiceConstants.bodyOfTimeRemaining.value}',
        title: LocalNotificationServiceConstants.titleOfTimeRemaining.value,
        minutesRemaining: 5,
      );

      /// Picker value is 10 minutes before the prayer time logic
    } else if (pickerValue == 1) {
      await localDatabaseService.set<int>(
        dbName: LocalDatabaseNames.remainingTimeDB.value,
        key: LocalDatabaseKeys.isTimeRemainingActive.value,
        value: 10,
      );
      remainingTime = 10;
      await localNotificationService.scheduleNotificationForPrayerTimesMinutesRemaining(
        body: '10 ${LocalNotificationServiceConstants.bodyOfTimeRemaining.value}',
        title: LocalNotificationServiceConstants.titleOfTimeRemaining.value,
        minutesRemaining: 10,
      );

      /// Picker value is 15 minutes before the prayer time logic
    } else if (pickerValue == 2) {
      await localDatabaseService.set<int>(
        dbName: LocalDatabaseNames.remainingTimeDB.value,
        key: LocalDatabaseKeys.isTimeRemainingActive.value,
        value: 15,
      );
      remainingTime = 15;
      await localNotificationService.scheduleNotificationForPrayerTimesMinutesRemaining(
        body: '15 ${LocalNotificationServiceConstants.bodyOfTimeRemaining.value}',
        title: LocalNotificationServiceConstants.titleOfTimeRemaining.value,
        minutesRemaining: 15,
      );

      /// Picker value is 0 minutes before the prayer time logic
    } else {
      await localDatabaseService.set<int>(
        dbName: LocalDatabaseNames.remainingTimeDB.value,
        key: LocalDatabaseKeys.isTimeRemainingActive.value,
        value: 0,
      );
      remainingTime = 0;
      await localNotificationService.scheduleNotificationForPrayerTimes(
        title: LocalNotificationServiceConstants.title.value,
        body: LocalNotificationServiceConstants.body.value,
      );
    }

    /// Show toast according to the remaining time
    if (remainingTime == 0) {
      await Fluttertoast.showToast(msg: 'Bildirim namaz vaktinde gönderilecek');
    } else {
      await Fluttertoast.showToast(msg: 'Bildirim namaza $remainingTime dk. kalınca gönderilecek');
    }
  }
}
