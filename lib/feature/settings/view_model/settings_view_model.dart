import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/exception/exception_type.dart';
import 'package:internship_project/core/exception/exception_util.dart';
import 'package:internship_project/model/city.dart';
import 'package:internship_project/service/local/city_name/city_name_service.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:internship_project/service/notification/notification_service.dart';
import 'package:stacked/stacked.dart';

/// SettingsViewModel class is responsible for the settings view logic.
class SettingsViewModel extends BaseViewModel {
  //TODO: Theme and notif implementation
  ///
  SettingsViewModel(
    this.cityNameService,
    this.localNotificationService,
    this.localDatabaseService,
  ) {
    fetchNotificationStatus();
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

  /// Update theme
  void updateTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  /// Fetch notif status
  Future<void> fetchNotificationStatus() async {
    final notifStatus = await localDatabaseService.get<bool>(
      dbName: 'notificationDatabase',
      key: 'isNotificationOpen',
    );

    _isNotificationOpen = notifStatus;
    notifyListeners();
  }

  /// Update notification status
  Future<void> updateNotificationStatus({required bool value}) async {
    if (value == true) {
      _isNotificationOpen = const LoadingState();
      notifyListeners();

      ///
      await localNotificationService.initNotifications();

      /// Initialize Local Notification Service
      final hasPermission = await localNotificationService.checkNotificationPermission();

      /// If the permission is granted, schedule the notification
      if (hasPermission) {
        /// Schedule notification for prayer times
        await localNotificationService.scheduleNotificationForPrayerTimes(
          title: 'Haydi!',
          body: 'Namaz Vakti geldi.',
          id: 0,
        );

        final setNotifTrueResponse = await localDatabaseService.set<bool>(
          dbName: 'notificationDatabase',
          key: 'isNotificationOpen',
          value: value,
        );

        if (setNotifTrueResponse is SuccessState<String>) {
          _isNotificationOpen = const SuccessState(true);
        } else {
          _isNotificationOpen = const ErrorState(ExceptionType.errorOccured);
        }
      } else {
        ///
        _isNotificationOpen = const SuccessState(false);
        await Fluttertoast.showToast(
          msg: ExceptionUtil.getExceptionMessage(ExceptionType.errorOccured),
        );
      }
    }

    /// If switch is off, cancel all notifications
    else {
      _isNotificationOpen = const LoadingState();
      notifyListeners();

      /// Cancel all notifications
      await localNotificationService.cancelPrayerTimeNotification();

      final setNotifFalseResponse = await localDatabaseService.set<bool>(
        dbName: 'notificationDatabase',
        key: 'isNotificationOpen',
        value: value,
      );

      if (setNotifFalseResponse is SuccessState<String>) {
        _isNotificationOpen = const SuccessState(false);
      } else {
        _isNotificationOpen = const ErrorState(ExceptionType.errorOccured);
      }
    }
    notifyListeners();
  }

  /// Get city names
  Future<void> getCityNames(BuildContext context) async {
    /// Fetching city names from the json file
    final listOfCities = await cityNameService.getTurkeyCities(context);

    /// If the response is success or error, assign the value to the _cityNames
    _cityNames = listOfCities;
    notifyListeners();
  }
}
