import 'package:flutter/material.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/exception/exception_type.dart';
import 'package:internship_project/model/city.dart';
import 'package:internship_project/service/local/city_name/city_name_service.dart';
import 'package:stacked/stacked.dart';

/// SettingsViewModel class is responsible for the settings view logic.
class SettingsViewModel extends BaseViewModel {
  //TODO: Theme and notif implementation
  ///
  SettingsViewModel(this.cityNameService, this._context);

  /// CityNameService instance
  final CityNameService cityNameService;

  /// City name
  Resource<List<City>> _cityNames = LoadingState();
  Resource<List<City>> get cityNames => _cityNames;

  /// Dark mode status
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  /// Notification status
  bool _isNotificationOpen = false;
  bool get isNotificationOpen => _isNotificationOpen;

  /// --------------------------------------------------------------------------
  /// BuildContext
  /// Required for fetching data from json file
  final BuildContext _context;

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

  /// Get city names
  Future<void> getCityNames(BuildContext context) async {
    /// Fetching city names from the json file
    final listOfCities = await cityNameService.getTurkeyCities(context);

    /// If the response is success or error, assign the value to the _cityNames
    _cityNames = listOfCities;
    notifyListeners();
  }
}
