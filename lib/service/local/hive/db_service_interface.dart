import 'package:internship_project/core/base/resource.dart';

/// Abstraction of local database service
abstract class ILocalDatabaseService {
  /// Get the value of the key from the shared preferences.
  Future<Resource<T>> get<T>({
    required String dbName,
    required String key,
  });

  /// Set the value of the key in the shared preferences.
  Future<Resource<String>> set<T>({
    required String dbName,
    required String key,
    required T value,
  });

  /// Remove the value of the key from the shared preferences.
  Future<Resource<String>> remove<T>({
    required String dbName,
    required String key,
  });
}
