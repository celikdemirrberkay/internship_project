// ignore: implementation_imports
import 'package:either_dart/src/either.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/service&repository/remote/location/location_service_interface.dart';

/// Location service
class LocationService extends ILocationService {
  /// Default city name and country name
  /// Used when location permission is not granted scenario
  static String cityName = 'İstanbul';
  static String countryName = 'Turkey';

  /// Get city name
  /// Before use check the location permission
  @override
  Future<Either<String, String>> getCityName() async {
    try {
      final position = await _getCurrentPosition();
      if (position.isLeft) {
        return Left(position.left);
      } else {
        final placemarks = await placemarkFromCoordinates(
          position.right.latitude,
          position.right.longitude,
        );

        final place = placemarks[0];
        return Right(place.locality ?? 'istanbul');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Get country name
  @override
  Future<Either<String, String>> getCountryName() async {
    try {
      final position = await _getCurrentPosition();
      if (position.isLeft) {
        return Left(position.left);
      } else {
        /// Placemarks
        final placemarks = await placemarkFromCoordinates(
          position.right.latitude,
          position.right.longitude,
        );

        /// Place
        final place = placemarks[0];
        return Right(place.country ?? 'Turkey');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Get current position as latitude and longitude
  Future<Either<String, Position>> _getCurrentPosition() async {
    try {
      /// Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return Right(position);
    } catch (e) {
      return Left(ExceptionMessage.errorOccured.message);
    }
  }
}
