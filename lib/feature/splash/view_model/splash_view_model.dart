import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:internship_project/service/notification/notification_service.dart';
import 'package:internship_project/service/permission/permission_manager.dart';
import 'package:internship_project/service/remote/location/location_service.dart';
import 'package:stacked/stacked.dart';

/// Splash view model
class SplashViewModel extends BaseViewModel {
  ///
  SplashViewModel(this.locationService);

  /// Location service instance
  final LocationService locationService;

  /// Request and check permission for location
  Future<void> requestAndCheckPermissionForLocation() async {
    await PermissionManager.requestPermissionForLocation();
  }

  /// Set city and country name for prayer times request
  /// If there is no city or country name, set default values
  Future<void> setCityAndCountryName() async {
    final city = await locationService.getCityName();
    final country = await locationService.getCountryName();

    if (city is ErrorState<String> || country is ErrorState<String>) {
      await Fluttertoast.showToast(
        msg: ExceptionMessage.accessDeniedForeverForLocation.message,
      );
    } else {
      LocationService.cityName.value = city.data == '' ? 'İstanbul' : city.data!;
      LocationService.countryName.value = country.data == '' ? 'Turkey' : country.data!;
    }
  }

  /// Set notifications on opening
  Future<void> setNotificationsOnOpening() async {
    final isNotifOpen = await locator<LocalDatabaseService>().get<bool>(
      dbName: 'notificationDatabase',
      key: 'isNotificationOpen',
    );
    if (isNotifOpen is SuccessState<bool>) {
      if (isNotifOpen.data!) {
        await locator<LocalNotificationService>().scheduleNotificationForPrayerTimes(
          title: 'Namaz Vakti',
          body: 'Namaz Vakti geldi. Haydi namaza!',
        );
      }
    }
  }
}
