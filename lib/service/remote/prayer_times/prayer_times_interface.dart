import 'package:dio/dio.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/model/times_response.dart';

/// Prayer times service interface.
/// Abstraction of the service is done here.
abstract class IPrayerTimesService {
  ///
  IPrayerTimesService(this.dio);

  /// Dio instance
  final Dio dio;

  /// Get prayer times from the api
  Future<Resource<PrayerApiData?>> getPrayerTimes(
    String city,
    String country,
  );

  /// Get prayer times as map format
  Future<Resource<Map<String, dynamic>>> getPrayerTimesAsMap(
    String city,
    String country,
  );

  /// Get prayer times as DateTime format
  Future<Resource<List<DateTime>>> getPrayerTimesAsDateTime(
    String city,
    String country,
  );
}
