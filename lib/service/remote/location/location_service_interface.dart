import 'package:internship_project/core/base/resource.dart';

/// Location service interface
abstract class ILocationService {
  /// Get city name from the position
  Future<Resource<String>> getCityName();

  /// Get country name from the position
  Future<Resource<String>> getCountryName();
}
