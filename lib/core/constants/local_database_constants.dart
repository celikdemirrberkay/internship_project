/// ----------------------------------------------------------------------------
///  Database name constants
/// Like localDatabase ..
enum LocalDatabaseNames {
  /// Dhikr list database name
  rosaryDB('rosaryDB'),

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

  /// isManuelSelected key name
  isManuelSelected('isManuelSelected');

  const LocalDatabaseKeys(this.value);

  /// Name parameter
  final String value;
}
