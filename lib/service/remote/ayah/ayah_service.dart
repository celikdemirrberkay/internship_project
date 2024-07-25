import 'dart:math';

import 'package:dio/dio.dart';
import 'package:either_dart/src/either.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/env_variables/development_env.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/core/exception/exception_type.dart';
import 'package:internship_project/model/ayah.dart';
import 'package:internship_project/service/remote/ayah/ayah_service_interface.dart';

/// AyahService class is responsible for fetching data from the remote server.
class AyahService extends IAyahServiceInterface {
  /// Constructor
  AyahService(super.dio);

  /// Get Ayahs from API
  @override
  Future<Resource<Ayah>> getSpecificAyah() async {
    try {
      /// Generate random number between 0 and 6236
      final randomAyahNumber = Random().nextInt(6235);

      /// Fetch data from the API
      final response = await dio.get<Map<String, dynamic>?>('${DevEnv.baseURLQuran}/$randomAyahNumber');

      if (response.data != null) {
        /// Getting only ayah from the response
        final responseOnlyData = response.data!['data'] as Map<String, dynamic>;

        return SuccessState(Ayah.fromJson(responseOnlyData));
      } else {
        return ErrorState(ExceptionType.noData);
      }
    } on DioException catch (_) {
      return ErrorState(ExceptionType.errorOccured);
    } catch (e) {
      return ErrorState(ExceptionType.errorOccured);
    }
  }
}