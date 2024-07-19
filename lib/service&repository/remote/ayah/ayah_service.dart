import 'dart:math';

import 'package:dio/dio.dart';
import 'package:either_dart/src/either.dart';
import 'package:internship_project/core/config/env_variables/development_env.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/model/ayah.dart';
import 'package:internship_project/service&repository/remote/ayah/ayah_service_interface.dart';

/// AyahService class is responsible for fetching data from the remote server.
class AyahService extends IAyahServiceInterface {
  /// Constructor
  AyahService(super.dio);

  /// Get Ayahs from API
  @override
  Future<Either<String, Ayah>> getSpecificAyah() async {
    try {
      /// Generate random number between 0 and 6236
      final randomAyahNumber = Random().nextInt(6235);

      /// Fetch data from the API
      final response = await dio.get<Map<String, dynamic>?>('${DevEnv.baseURLQuran}/$randomAyahNumber');

      if (response.data != null) {
        /// Getting only ayah from the response
        final responseOnlyData = response.data!['data'] as Map<String, dynamic>;

        return Right(Ayah.fromJson(responseOnlyData));
      } else {
        return Left(ExceptionMessage.noData.message);
      }
    } on DioException catch (e) {
      return Left(e.message ?? ExceptionMessage.errorOccured.message);
    } catch (e) {
      return Left(ExceptionMessage.errorOccured.message);
    }
  }
}
