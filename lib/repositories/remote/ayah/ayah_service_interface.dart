import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:internship_project/repositories/model/ayah.dart';

/// Ayah service interface
abstract class IAyahServiceInterface {
  ///
  IAyahServiceInterface(this.dio);

  /// Dio instance
  final Dio dio;

  /// Get specific Ayah
  Future<Either<String, Ayah>> getSpecificAyah();
}
