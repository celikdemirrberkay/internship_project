import 'package:either_dart/either.dart';

/// Abstraction of local database service
abstract class IDatabaseService {
  /// Get the value of the key from the shared preferences.
  Future<Either<String, int?>> get(String key);

  /// Set the value of the key in the shared preferences.
  Future<Either<String, String>> set(String key, int value);

  /// Remove the value of the key from the shared preferences.
  Future<Either<String, String>> remove(String key);
}
