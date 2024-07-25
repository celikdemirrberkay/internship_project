import 'package:either_dart/either.dart';

/// Location service interface
abstract class ILocationService {
  /// Get city name from the position
  Future<Either<String, String>> getCityName();

  /// Get country name from the position
  Future<Either<String, String>> getCountryName();
}
