import 'package:either_dart/either.dart';

/// Abstraction of local database service
abstract class IDatabaseService {
  /// Get the value of the key from the shared preferences.
  Future<Either<String, dynamic>> get<T>(String key);

  /// Set the value of the key in the shared preferences.
  Future<Either<String, String>> set<T>(String key, T value);

  /// Remove the value of the key from the shared preferences.
  Future<Either<String, String>> remove<T>(String key);
}
