import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:internship_project/repositories/model/times_response.dart';

/// Prayer times service interface.
/// Abstraction of the service is done here.
abstract class IPrayerTimesService {
  ///
  IPrayerTimesService(this.dio);

  /// Dio instance
  final Dio dio;

  /// Get prayer times from the api.
  Future<Either<String?, PrayerApiData?>> getPrayerTimes(
    String city,
    String country,
  );
}
