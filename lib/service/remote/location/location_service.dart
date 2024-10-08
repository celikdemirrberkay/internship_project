// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/exception/exception_type.dart';
import 'package:internship_project/service/remote/location/location_service_interface.dart';

/// Location service
class LocationService extends ILocationService {
  /// Default city name and country name
  /// Used when location permission is not granted scenario
  static ValueNotifier<String> cityName = ValueNotifier('İstanbul');
  static ValueNotifier<String> countryName = ValueNotifier('Turkey');

  /// Get city name
  /// Before use check the location permission
  @override
  Future<Resource<String>> getCityName() async {
    try {
      /// Get current position
      final position = await _getCurrentPosition();

      /// Check if the position is an error
      if (position is ErrorState<Position>) {
        return ErrorState(position.exceptionType!);
      } else {
        /// Placemarks
        final placemarks = await placemarkFromCoordinates(
          position.data!.latitude,
          position.data!.longitude,
        );

        final place = placemarks[0];

        /// If locality is empty, return 'istanbul'
        if (place.locality!.isEmpty) {
          return const SuccessState('istanbul');
        }

        /// Return locality city name
        return SuccessState(place.locality ?? 'istanbul');
      }
    } catch (_) {
      return const ErrorState(ExceptionTypes.errorOccured);
    }
  }

  /// Get country name
  @override
  Future<Resource<String>> getCountryName() async {
    try {
      final position = await _getCurrentPosition();
      if (position.runtimeType == ErrorState) {
        return ErrorState(position.exceptionType!);
      } else {
        /// Placemarks
        final placemarks = await placemarkFromCoordinates(
          position.data!.latitude,
          position.data!.longitude,
        );

        /// Place
        final place = placemarks[0];

        /// If locality is empty, return 'Turkey'
        if (place.locality!.isEmpty) {
          return const SuccessState('Turkey');
        }

        /// Return country name
        return SuccessState(place.country ?? 'Turkey');
      }
    } catch (_) {
      return const ErrorState(ExceptionTypes.errorOccured);
    }
  }

  /// Get current position as latitude and longitude
  Future<Resource<Position>> _getCurrentPosition() async {
    try {
      /// Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return SuccessState(position);
    } catch (e) {
      return const ErrorState(ExceptionTypes.locationNotFound);
    }
  }
}
