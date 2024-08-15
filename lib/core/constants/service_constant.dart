/// Prayer times service constants
enum PrayerTimesServiceConstants {
  /// isManuelSelected key name
  ddMMYYFormat('dd-MM-yyyy');

  const PrayerTimesServiceConstants(this.value);

  /// Value parameter
  final String value;
}

/// Local notification service constants
enum LocalNotificationServiceConstants {
  /// Notification body
  body('Namaz Vakti'),

  /// Notification title
  title('Namaz Vakti geldi. Haydi namaza!');

  const LocalNotificationServiceConstants(this.value);

  /// Value parameter
  final String value;
}
