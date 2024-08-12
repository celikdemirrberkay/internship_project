import 'dart:async';
import 'dart:io';

import 'package:home_widget/home_widget.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/service/remote/location/location_service.dart';
import 'package:internship_project/service/remote/prayer_times/prayer_times_service.dart';

/// HomeWidgetManager is a class that manages all the
/// widgets that are used in the home screen.
class HomeWidgetManager {
  /// --------------------------------------------------------------------------
  /// Set appGroupId for iOS
  static Future<void> setAppGroupIdForIOS() async {
    if (Platform.isIOS) {
      await HomeWidget.setAppGroupId(_HomeWidgetValues.appGroupId.value);
    } else {
      return;
    }
  }

  /// --------------------------------------------------------------------------
  /// Update the home widget
  static Future<void> updateHomeWidget() async {
    await HomeWidget.updateWidget(
      androidName: _HomeWidgetValues.androidName.value,
      iOSName: _HomeWidgetValues.iOSWidgetName.value,
    );
  }

  /// --------------------------------------------------------------------------
  /// Save Widget Data
  static Future<void> saveWidgetData(String key, dynamic value) async {
    await HomeWidget.saveWidgetData(key, value);
  }

  /// --------------------------------------------------------------------------
  /// Update the home widget for Android
  static Future<void> fetchPrayerTimesAndUpdateAndroidWidget() async {
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
    await saveWidgetData('Fajr', prayerTimesMap['Fajr']);
    await saveWidgetData('Sunrise', prayerTimesMap['Sunrise']);
    await saveWidgetData('Dhuhr', prayerTimesMap['Dhuhr']);
    await saveWidgetData('Asr', prayerTimesMap['Asr']);
    await saveWidgetData('Maghrib', prayerTimesMap['Maghrib']);
    await saveWidgetData('Isha', prayerTimesMap['Isha']);
    await saveWidgetData('Location', LocationService.cityName.value);

    /// Update the home widget for Android
    await updateHomeWidget();
  }

  /// --------------------------------------------------------------------------
  /// Check nearest time and start countdown
  Future<void> startCountdownOnWidgetForPrayer() async {
    final prayerTimesAsDateTime = await locator<PrayerTimesService>().getPrayerTimesAsDateTime(
      LocationService.cityName.value,
      LocationService.countryName.value,
    );

    if (prayerTimesAsDateTime is ErrorState) {
      return;
    } else {
      final nextPrayerTime = findNextPrayerTime(prayerTimesAsDateTime.data!);
      if (nextPrayerTime != null) {
        Timer.periodic(const Duration(seconds: 1), (timer) async {
          final remainingTime = nextPrayerTime.difference(DateTime.now());
          if (remainingTime.isNegative) {
            timer.cancel();
            await startCountdownOnWidgetForPrayer();
          } else {
            String twoDigits(int n) => n.toString().padLeft(2, '0');
            final hours = twoDigits(remainingTime.inHours);
            final minutes = twoDigits(remainingTime.inMinutes.remainder(60));
            final seconds = twoDigits(remainingTime.inSeconds.remainder(60));
            await saveWidgetData('RemainingTimeHours', hours);
            await saveWidgetData('RemainingTimeMinutes', minutes);
            await saveWidgetData('RemainingTimeSeconds', seconds);
            await updateHomeWidget();
          }
        });
      }
    }
  }

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

/// HomeWidgetValues is an enum class that holds the values of the strings.
enum _HomeWidgetValues {
  androidName('HomeWidget'),

  iOSWidgetName('home_widget'),

  appGroupId('group.home_widget_flutter');

  const _HomeWidgetValues(this.value);

  final String value;
}
