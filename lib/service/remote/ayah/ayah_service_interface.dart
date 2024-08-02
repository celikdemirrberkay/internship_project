import 'package:dio/dio.dart';
import '../../../core/base/resource.dart';
import '../../../model/ayah.dart';

/// Ayah service interface
abstract class IAyahServiceInterface {
  ///
  IAyahServiceInterface(this.dio);

  /// Dio instance
  final Dio dio;

  /// Get specific Ayah
  Future<Resource<Ayah>> getSpecificAyah();
}
