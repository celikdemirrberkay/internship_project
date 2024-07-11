<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 324fc6f (Backend successfully integrated and dependency injection container created.)
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:internship_project/core/config/env_variables/development_env.dart';
import 'package:internship_project/core/exception/exception_message.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:internship_project/repositories/model/times_response.dart';
import 'package:internship_project/repositories/remote/prayer_times/prayer_times_interface.dart';
import 'package:intl/intl.dart';
=======
import 'package:internship_project/repositories/model/response.dart';
import 'package:internship_project/repositories/prayer_times/prayer_times_interface.dart';
>>>>>>> 22a82f5 (Models were created based on response)
=======
import 'package:internship_project/repositories/model/response.dart';
=======
import 'package:internship_project/repositories/model/times_response.dart';
>>>>>>> 47ff30c (View and view model structure change a bit)
import 'package:internship_project/repositories/prayer_times/prayer_times_interface.dart';
import 'package:intl/intl.dart';
>>>>>>> 324fc6f (Backend successfully integrated and dependency injection container created.)

/// The service where we fetch prayer times
class PrayerTimesService extends IPrayerTimesService {
  ///
  PrayerTimesService(super.dio);

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  /// --------------------------------------------------------------------------
  /// Fetching data from api.
  /// Returns either error message or response data.
  /// Did the null check here to avoid null safety issues.
<<<<<<< HEAD
  @override
  Future<Either<String, ApiData>> getPrayerTimes(
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
        '${DevEnv.baseURL}/timingsByCity/$formattedDate?city=$city&country=$country&method=3',
      );

      if (response.data != null) {
        /// Converting response to ApiResponse object
        final responseAsApiResponse = ApiResponse.fromJson(response.data!);
        return Right(responseAsApiResponse.data!);
      } else {
        return Left(ExceptionMessage.noData.message);
      }

      /// Catching errors
    } on DioException catch (dioError) {
      return Left(dioError.message ?? ExceptionMessage.errorOccured.message);
    } catch (error) {
      return Left(ExceptionMessage.errorOccured.message);
    }
=======
  @override
  Future<ApiResponse?> getPrayerTimes() {
    // TODO: implement getPrayerTimes
    throw UnimplementedError();
>>>>>>> 22a82f5 (Models were created based on response)
=======
=======
  /// --------------------------------------------------------------------------
>>>>>>> 9e48148 (God names services added.)
  /// Fetching data from api.
  /// Returns either error message or response data.
=======
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
  @override
  Future<Either<String, ApiData>> getPrayerTimes(
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
        '${DevEnv.baseURL}/timingsByCity/$formattedDate?city=$city&country=$country&method=3',
      );

      if (response.data != null) {
        /// Converting response to ApiResponse object
        final responseAsApiResponse = ApiResponse.fromJson(response.data!);
        return Right(responseAsApiResponse.data!);
      } else {
        return Left(ExceptionMessage.noData.message);
      }

      /// Catching errors
    } on DioException catch (dioError) {
      return Left(dioError.message ?? ExceptionMessage.errorOccured.message);
    } catch (error) {
      return Left(ExceptionMessage.errorOccured.message);
    }
>>>>>>> 324fc6f (Backend successfully integrated and dependency injection container created.)
  }
}