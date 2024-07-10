/// Abstraction of local database service
abstract class IDatabaseService {
  /// Get the value of the key from the shared preferences.
  Future<String?> get(String key);

  /// Set the value of the key in the shared preferences.
  Future<void> set(String key, String value);
}
