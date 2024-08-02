import 'package:dio/dio.dart';
import '../../../core/base/resource.dart';
import '../../../core/config/env_variables/development_env.dart';
import '../../../core/exception/exception_type.dart';
import '../../../model/times_response.dart';
import 'prayer_times_interface.dart';
import 'package:intl/intl.dart';

/// The service where we fetch prayer times
class PrayerTimesService extends IPrayerTimesService {
  ///
  PrayerTimesService(super.dio);

  /// --------------------------------------------------------------------------
  /// Fetching data from api.
  /// Returns either error message or response data.
  /// Did the null check here to avoid null safety issues.
  @override
  Future<Resource<PrayerApiData>> getPrayerTimes(
    String city,
    String country,
  ) async {
    /// Getting current date
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy').format(now);

    /// Try fetch data from api
    try {
      /// Fetching data from the api
      final response = await dio.get<Map<String, dynamic>>(
        '${DevEnv.baseURL}/timingsByCity/$formattedDate?city=${city.toLowerCase()}&country=${country.toLowerCase()}&method=3',
      );

      if (response.data != null) {
        /// Converting response to ApiResponse object
        final responseAsApiResponse = PrayerApiResponse.fromJson(response.data!);
        return SuccessState(responseAsApiResponse.data!);
      } else {
        return const ErrorState(ExceptionType.noData);
      }

      /// Catching errors
    } on DioException catch (_) {
      return const ErrorState(ExceptionType.errorOccured);
    } catch (_) {
      return const ErrorState(ExceptionType.errorOccured);
    }
  }

  /// --------------------------------------------------------------------------
  /// Get prayer times for schedule notifications
  Future<Resource<Map<String, dynamic>>> getPrayerTimesForScheduleNotifications(
    String city,
    String country,
  ) async {
    /// Getting current date
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy').format(now);

    /// Try fetch data from api
    try {
      /// Fetching data from the api
      final response = await dio.get<Map<String, dynamic>>(
        '${DevEnv.baseURL}/timingsByCity/$formattedDate?city=${city.toLowerCase()}&country=${country.toLowerCase()}&method=3',
      );

      if (response.data != null) {
        return SuccessState(response.data!);
      } else {
        return const ErrorState(ExceptionType.noData);
      }

      /// Catching errors
    } on DioException catch (_) {
      return const ErrorState(ExceptionType.errorOccured);
    } catch (_) {
      return const ErrorState(ExceptionType.errorOccured);
    }
  }
}
