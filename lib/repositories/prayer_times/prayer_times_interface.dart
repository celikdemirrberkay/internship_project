import 'package:dio/dio.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:either_dart/either.dart';
import 'package:internship_project/repositories/model/times_response.dart';
=======
=======
import 'package:either_dart/either.dart';
>>>>>>> 324fc6f (Backend successfully integrated and dependency injection container created.)
import 'package:internship_project/repositories/model/response.dart';
>>>>>>> 22a82f5 (Models were created based on response)

/// Prayer times service interface.
/// Abstraction of the service is done here.
abstract class IPrayerTimesService {
  ///
  IPrayerTimesService(this.dio);

  /// Dio instance
  final Dio dio;

  /// Get prayer times from the api.
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  Future<Either<String?, ApiData?>> getPrayerTimes(
    String city,
    String country,
  );
=======
  Future<ApiResponse?> getPrayerTimes();
>>>>>>> 22a82f5 (Models were created based on response)
=======
  Future<Either<String?, Timings?>> getPrayerTimes(
=======
  Future<Either<String?, ApiData?>> getPrayerTimes(
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
    String city,
    String country,
  );
>>>>>>> 324fc6f (Backend successfully integrated and dependency injection container created.)
}
