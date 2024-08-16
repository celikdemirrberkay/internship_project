import 'dart:async';
import 'dart:io';

import 'package:home_widget/home_widget.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/constants/service_constant.dart';
import 'package:internship_project/service/remote/location/location_service.dart';
import 'package:internship_project/service/remote/prayer_times/prayer_times_service.dart';

/// HomeWidgetManager is a class that manages all the
/// widgets that are used in the home screen.
class HomeWidgetManager {
  /// --------------------------------------------------------------------------
  /// Set appGroupId for iOS
  static Future<void> setAppGroupIdForIOS() async {
    if (Platform.isIOS) {
      await HomeWidget.setAppGroupId(HomeWidgetConstants.appGroupId.value);
    } else {
      return;
    }
  }

  /// --------------------------------------------------------------------------
  /// Update the home widget
  static Future<void> updateHomeWidget() async {
    await HomeWidget.updateWidget(
      androidName: HomeWidgetConstants.androidName.value,
      iOSName: HomeWidgetConstants.iOSWidgetName.value,
    );
  }

  /// --------------------------------------------------------------------------
  /// Save Widget Data
  static Future<void> saveWidgetData(String key, dynamic value) async {
    await HomeWidget.saveWidgetData(key, value);
  }

  /// --------------------------------------------------------------------------
  /// Update the home widget for Android
  static Future<void> fetchPrayerTimesAndUpdateHomeWidget() async {
    /// Fetch prayer times
    final prayerTimes = await locator<PrayerTimesService>().getPrayerTimesAsMap(
      LocationService.cityName.value,
      LocationService.countryName.value,
    );

    /// If there is an error, return
    if (prayerTimes is ErrorState) {
      return;
    }

    /// Prayer times map format
    final prayerTimesMap = prayerTimes.data!['data']['timings'] as Map<String, dynamic>;

    /// Save prayer times and location to the home widget
    await saveWidgetData(
      HomeWidgetConstants.fajr.value,
      prayerTimesMap[HomeWidgetConstants.fajr.value],
    );
    await saveWidgetData(
      HomeWidgetConstants.sunrise.value,
      prayerTimesMap[HomeWidgetConstants.sunrise.value],
    );
    await saveWidgetData(
      HomeWidgetConstants.dhuhr.value,
      prayerTimesMap[HomeWidgetConstants.dhuhr.value],
    );
    await saveWidgetData(
      HomeWidgetConstants.asr.value,
      prayerTimesMap[HomeWidgetConstants.asr.value],
    );
    await saveWidgetData(
      HomeWidgetConstants.maghrib.value,
      prayerTimesMap[HomeWidgetConstants.maghrib.value],
    );
    await saveWidgetData(
      HomeWidgetConstants.isha.value,
      prayerTimesMap[HomeWidgetConstants.isha.value],
    );
    await saveWidgetData(
      HomeWidgetConstants.location.value,
      LocationService.cityName.value,
    );

    /// Update the home widget for Android
    await updateHomeWidget();
  }

  /// --------------------------------------------------------------------------
  /// Check nearest time and start countdown
  Future<void> startCountdownOnWidgetForPrayer() async {
    /// Fetch prayer times as DateTime
    final prayerTimesAsDateTime = await locator<PrayerTimesService>().getPrayerTimesAsDateTime(
      LocationService.cityName.value,
      LocationService.countryName.value,
    );

    /// If there is an error, return
    if (prayerTimesAsDateTime is ErrorState) {
      return;
    }

    /// If success state start timer for countdown
    if (prayerTimesAsDateTime is SuccessState) {
      /// Filter the next prayer time
      final nextPrayerTime = findNextPrayerTime(prayerTimesAsDateTime.data!);

      /// If the next prayer time is not null, start the countdown
      if (nextPrayerTime != null) {
        Timer.periodic(
          const Duration(seconds: 1),
          (timer) async {
            /// Calculate the remaining time
            final remainingTime = nextPrayerTime.difference(DateTime.now());
            if (remainingTime.isNegative) {
              /// If the remaining time is negative, cancel the timer
              /// and start the countdown again
              timer.cancel();
              await startCountdownOnWidgetForPrayer();
            } else {
              /// Save the remaining time to the home widget
              await saveWidgetData(
                HomeWidgetConstants.remainingTimeHours.value,
                twoDigits(remainingTime.inHours),
              );
              await saveWidgetData(
                HomeWidgetConstants.remainingTimeMinutes.value,
                twoDigits(remainingTime.inMinutes.remainder(60)),
              );
              await saveWidgetData(
                HomeWidgetConstants.remainingTimeSeconds.value,
                twoDigits(remainingTime.inSeconds.remainder(60)),
              );

              /// Update the home widget
              await updateHomeWidget();
            }

            /// Listen to the city name changes
            /// and cancel the timer if don't cancel the timer it conflict with
            /// the new timer
            LocationService.cityName.addListener(() {
              timer.cancel();
            });
          },
        );
      }
    }
  }

  /// --------------------------------------------------------------------------
  /// Switch date times to hour format
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  /// --------------------------------------------------------------------------
  /// Finding first prayer time after now
  DateTime? findNextPrayerTime(List<DateTime> dateTimes) {
    /// Get current time
    final now = DateTime.now();

    /// Return the first prayer time after now
    return dateTimes.where((dt) => dt.isAfter(now)).reduce(
          (a, b) => a.isBefore(b) ? a : b,
        );
  }
}
