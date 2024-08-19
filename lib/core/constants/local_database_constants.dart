/// ----------------------------------------------------------------------------
///  Database name constants
/// Like localDatabase ..
enum LocalDatabaseNames {
  /// Dhikr list database name
  rosaryDB('rosaryDB'),

  /// Notification database name
  notificationDB('notificationDB'),

  /// Onboard database name
  onboardDB('onboardDB'),

  /// Theme database name
  themeDB('themeDB'),

  /// Local database name
  isManuelSelectedDB('isManuelSelectedDB');

  const LocalDatabaseNames(this.value);

  /// Name parameter
  final String value;
}

/// ----------------------------------------------------------------------------
///  Local database name constants
/// Like localDatabase,
enum LocalDatabaseKeys {
  /// Dhikr list key name
  dhikrList('dhikrList'),

  /// Theme key name
  isDarkTheme('isDarkTheme'),

  /// isOnboardDone key name
  isOnboardDone('isOnboardDone'),

  /// isTimeRemaining key name
  isTimeRemaining('isTimeRemaining'),

  /// isNotificationOpen key name
  isNotificationOpen('isNotificationOpen'),

  /// isManuelSelected key name
  isManuelSelected('isManuelSelected');

  const LocalDatabaseKeys(this.value);

  /// Name parameter
  final String value;
}
