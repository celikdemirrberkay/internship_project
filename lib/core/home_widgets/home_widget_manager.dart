import 'package:home_widget/home_widget.dart';

/// HomeWidgetManager is a class that manages all the
/// widgets that are used in the home screen.
class HomeWidgetManager {
  /// Update the home widget for Android
  static Future<void> updateAndroidWidget() async {
    await HomeWidget.saveWidgetData('Fajr', '04:04');
    await HomeWidget.saveWidgetData('Sunrise', '05:48');
    await HomeWidget.saveWidgetData('Dhuhr', '12:48');
    await HomeWidget.saveWidgetData('Asr', '16:39');
    await HomeWidget.saveWidgetData('Maghrib', '19:47');
    await HomeWidget.saveWidgetData('Isha', '21:24');

    /// Update the home widget for Android
    await HomeWidget.updateWidget(androidName: 'HomeWidget');
  }
}
