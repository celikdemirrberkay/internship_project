import 'package:dio/dio.dart';
import 'package:internship_project/repositories/model/response.dart';

/// Prayer times service interface.
/// Abstraction of the service is done here.
abstract class IPrayerTimesService {
  ///
  IPrayerTimesService(this.dio);

  /// Dio instance
  final Dio dio;

  /// Get prayer times from the api.
  Future<ApiResponse?> getPrayerTimes();
}
