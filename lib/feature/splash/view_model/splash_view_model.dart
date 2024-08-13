import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/core/home_widgets/home_widget_manager.dart';
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

  /// --------------------------------------------------------------------------
  /// Request and check permission for location
  Future<void> requestAndCheckPermissionForLocation() async {
    await PermissionManager.requestPermissionForLocation();
  }

  /// --------------------------------------------------------------------------
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
      LocationService.countryName.value = country.data == '' ? 'Turkey' : country.data!;
      LocationService.cityName.value = city.data == '' ? 'İstanbul' : city.data!;
    }
  }

  /// --------------------------------------------------------------------------
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

  /// --------------------------------------------------------------------------
  /// Set Dhikr List for first time
  static Future<void> _setFirstTimeDhikr() async {
    await locator<LocalDatabaseService>().setFirstTimeDhikr();
  }

  /// --------------------------------------------------------------------------
  /// Initialize the view model
  Future<void> onInit() async {
    /// Request location permission
    await requestAndCheckPermissionForLocation();

    /// Set city and country name for prayer times request
    await setCityAndCountryName();

    /// Set Dhikr List for first time
    await _setFirstTimeDhikr();

    /// Set notifications on opening if it is enabled
    await setNotificationsOnOpening();

    /// Update the home widget for Android and set appGroupId for iOS
    /// Also start countdown on widget for prayer
    await HomeWidgetManager.setAppGroupIdForIOS();
    await HomeWidgetManager.fetchPrayerTimesAndUpdateHomeWidget();
    await HomeWidgetManager().startCountdownOnWidgetForPrayer();
  }
}
