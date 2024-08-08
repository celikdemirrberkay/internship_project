import 'package:home_widget/home_widget.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/service/remote/location/location_service.dart';
import 'package:internship_project/service/remote/prayer_times/prayer_times_service.dart';

/// HomeWidgetManager is a class that manages all the
/// widgets that are used in the home screen.
class HomeWidgetManager {
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
    await HomeWidget.saveWidgetData('Fajr', prayerTimesMap['Fajr']);
    await HomeWidget.saveWidgetData('Sunrise', prayerTimesMap['Sunrise']);
    await HomeWidget.saveWidgetData('Dhuhr', prayerTimesMap['Dhuhr']);
    await HomeWidget.saveWidgetData('Asr', prayerTimesMap['Asr']);
    await HomeWidget.saveWidgetData('Maghrib', prayerTimesMap['Maghrib']);
    await HomeWidget.saveWidgetData('Isha', prayerTimesMap['Isha']);
    await HomeWidget.saveWidgetData('Location', LocationService.cityName.value);

    /// Update the home widget for Android
    await HomeWidget.updateWidget(
      androidName: 'HomeWidget',
    );
  }
}
