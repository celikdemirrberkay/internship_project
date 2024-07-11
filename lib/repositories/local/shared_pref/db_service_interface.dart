import 'package:either_dart/either.dart';
import 'package:hive/hive.dart';

/// Abstraction of local database service
abstract class IDatabaseService {
  /// Constructor
  IDatabaseService(this.hive);

  /// Hive interface instance
  final HiveInterface hive;

  /// Get the value of the key from the shared preferences.
  Future<Either<String, String?>> get(String key);

  /// Set the value of the key in the shared preferences.
  Future<Either<String, String>> set(String key, int value);

  /// Remove the value of the key from the shared preferences.
  Future<Either<String, String>> remove(String key);
}
