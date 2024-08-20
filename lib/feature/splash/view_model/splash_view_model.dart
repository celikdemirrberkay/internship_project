import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/constants/local_database_constants.dart';
import 'package:internship_project/core/constants/service_constant.dart';
import 'package:internship_project/core/exception/exception_util.dart';
import 'package:internship_project/core/home_widgets/home_widget_manager.dart';
import 'package:internship_project/service/local/dhikr/dhikr_service.dart';
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
    /// Get city and country name from location service
    final country = await locationService.getCountryName();
    final city = await locationService.getCityName();

    /// If there is an error, show a toast message
    if (city is ErrorState<String> || country is ErrorState<String>) {
      await Fluttertoast.showToast(
        msg: ExceptionMessager.getExceptionMessage(city.exceptionType!),
      );
    } else {
      /// Check if the user has selected the city and country manually
      final isManuelSelected = await locator<LocalDatabaseService>().get<bool>(
        dbName: LocalDatabaseNames.isManuelSelectedDB.value,
        key: LocalDatabaseKeys.isManuelSelected.value,
      );

      /// If the user has not selected the city and country manually,
      /// set the default values
      if (isManuelSelected.data != null && isManuelSelected.data! == true) {
        return;
      } else {
        /// Else set the city and country name from the location service
        /// If there is no city or country name, so there is empty string,
        /// set default values
        LocationService.countryName.value = country.data!;
        LocationService.cityName.value = city.data!;
      }
    }
  }

  /// --------------------------------------------------------------------------
  /// Set notifications on opening
  Future<void> setNotificationsOnOpening() async {
    final isNotifOpen = await locator<LocalDatabaseService>().get<bool>(
      dbName: LocalDatabaseNames.notificationDB.value,
      key: LocalDatabaseKeys.isNotificationOpen.value,
    );

    if (isNotifOpen is SuccessState<bool>) {
      if (isNotifOpen.data!) {
        /// If notifications are enabled, cancel all notifications because city
        /// and country name may be changed
        await locator<LocalNotificationService>().cancelAllNotifications();

        /// If remaining time active for notifications, schedule notification
        /// for prayer times minutes remaining
        final remainingTime = await locator<LocalDatabaseService>().get<int>(
          dbName: LocalDatabaseNames.remainingTimeDB.value,
          key: LocalDatabaseKeys.isTimeRemainingActive.value,
        );

        /// If there is a remaining time and it is not 0, schedule notification
        /// for prayer times minutes remaining
        if (remainingTime is SuccessState<int> && remainingTime.data != 0) {
          await locator<LocalNotificationService>().scheduleNotificationForPrayerTimesMinutesRemaining(
            minutesRemaining: remainingTime.data ?? 0,
            title: LocalNotificationServiceConstants.titleOfTimeRemaining.value,
            body: '${remainingTime.data} ${LocalNotificationServiceConstants.bodyOfTimeRemaining.value}',
          );
          return;
        } else {
          /// Schedule notification for prayer times
          await locator<LocalNotificationService>().scheduleNotificationForPrayerTimes(
            title: LocalNotificationServiceConstants.title.value,
            body: LocalNotificationServiceConstants.body.value,
          );
        }
      }
    }
  }

  /// --------------------------------------------------------------------------
  /// Set Dhikr List for first time
  static Future<void> setFirstTimeDhikr() async {
    await locator<DhikrService>().setFirstTimeDhikr();
  }

  /// --------------------------------------------------------------------------
  /// Initialize the view model
  Future<void> onInit() async {
    /// Request location permission
    await requestAndCheckPermissionForLocation();

    /// Set city and country name for prayer times request
    await setCityAndCountryName();

    /// Set Dhikr List for first time
    await setFirstTimeDhikr();

    /// Set notifications on opening if it is enabled
    await setNotificationsOnOpening();

    /// Update the home widget for Android and set appGroupId for iOS
    /// Also start countdown on widget for prayer
    await HomeWidgetManager.setAppGroupIdForIOS();
    await HomeWidgetManager.fetchPrayerTimesAndUpdateHomeWidget();
    await HomeWidgetManager().startCountdownOnWidgetForPrayer();
  }
}
