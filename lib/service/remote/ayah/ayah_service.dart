import 'dart:math';

import 'package:dio/dio.dart';
import '../../../core/base/resource.dart';
import '../../../core/config/env_variables/development_env.dart';
import '../../../core/exception/exception_type.dart';
import '../../../model/ayah.dart';
import 'ayah_service_interface.dart';

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
        return const ErrorState(ExceptionType.noData);
      }
    } on DioException catch (_) {
      return const ErrorState(ExceptionType.errorOccured);
    } catch (e) {
      return const ErrorState(ExceptionType.errorOccured);
    }
  }
}
