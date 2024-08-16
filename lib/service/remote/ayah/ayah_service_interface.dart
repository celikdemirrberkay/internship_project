import 'package:dio/dio.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/model/ayah.dart';

/// Ayah service interface
abstract class IAyahServiceInterface {
  ///
  IAyahServiceInterface(this.dio);

  /// Dio instance
  final Dio dio;

  /// Get specific Ayah
  Future<Resource<Ayah>> getSpecificAyah();
}
