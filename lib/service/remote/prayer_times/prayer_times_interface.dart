import 'package:dio/dio.dart';
import '../../../core/base/resource.dart';
import '../../../model/times_response.dart';

/// Prayer times service interface.
/// Abstraction of the service is done here.
abstract class IPrayerTimesService {
  ///
  IPrayerTimesService(this.dio);

  /// Dio instance
  final Dio dio;

  /// Get prayer times from the api.
  Future<Resource<PrayerApiData?>> getPrayerTimes(
    String city,
    String country,
  );
}
