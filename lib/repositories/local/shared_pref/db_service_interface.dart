import 'package:either_dart/either.dart';

/// Abstraction of local database service
abstract class IDatabaseService {
  /// Get the value of the key from the shared preferences.
  Future<Either<String, dynamic>> get<T>({
    required String dbName,
    required String key,
  });

  /// Set the value of the key in the shared preferences.
  Future<Either<String, String>> set<T>({
    required String dbName,
    required String key,
    required T value,
  });

  /// Remove the value of the key from the shared preferences.
  Future<Either<String, String>> remove<T>({
    required String dbName,
    required String key,
  });
}
