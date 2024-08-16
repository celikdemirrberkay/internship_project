/// ----------------------------------------------------------------------------
/// Prayer times service constants
enum PrayerTimesServiceConstants {
  /// yyyyMMdd Format key name
  yyyyMMddFormat('yyyy-MM-dd'),

  /// ddMMYY Format key name
  ddMMYYFormat('dd-MM-yyyy');

  const PrayerTimesServiceConstants(this.value);

  /// Value parameter
  final String value;
}

/// ----------------------------------------------------------------------------
/// Local notification service constants
enum LocalNotificationServiceConstants {
  /// Notification body
  body('Namaz Vakti'),

  /// Sunset key name
  sunset('Sunset'),

  /// Imsak key name
  imsak('Imsak'),

  /// Midnight key name
  midnight('Midnight'),

  /// Lastthird key name
  lastthird('Lastthird'),

  /// Firstthird key name
  firstthird('Firstthird'),

  /// Notification title
  title('Namaz Vakti geldi. Haydi namaza!');

  const LocalNotificationServiceConstants(this.value);

  /// Value parameter
  final String value;
}

/// ----------------------------------------------------------------------------
/// HomeWidgetValues is an enum class that holds the values of the strings.
enum HomeWidgetConstants {
  /// Fajr key name
  fajr('Fajr'),

  /// Sunrise key name
  sunrise('Sunrise'),

  /// Dhuhr key name
  dhuhr('Dhuhr'),

  /// Asr key name
  asr('Asr'),

  /// Maghrib key name
  maghrib('Maghrib'),

  /// Isha key name
  isha('Isha'),

  /// Location key name
  location('Location'),

  /// Remaining time hours key name
  remainingTimeHours('RemainingTimeHours'),

  /// Remaining time minutes key name
  remainingTimeMinutes('RemainingTimeMinutes'),

  /// Remaining time seconds key name
  remainingTimeSeconds('RemainingTimeSeconds'),

  /// Android name
  androidName('HomeWidget'),

  /// iOS widget name
  iOSWidgetName('home_widget'),

  /// App group id
  appGroupId('group.home_widget_flutter');

  const HomeWidgetConstants(this.value);

  /// Value parameter
  final String value;
}
