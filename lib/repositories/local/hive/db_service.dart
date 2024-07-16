import 'package:either_dart/src/either.dart';
import 'package:hive/hive.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/repositories/local/hive/db_service_interface.dart';

/// Abstraction of local database service
class LocalDatabaseService extends ILocalDatabaseService {
  /// Constructor
  LocalDatabaseService();

  @override
  Future<Either<String, T>> get<T>({
    required String dbName,
    required String key,
  }) async {
    try {
      /// Hive box
      final box = await Hive.openBox<T?>(dbName);
      final response = box.get(key);

      if (response != null) {
        return Right(response);
      } else {
        return Left(ExceptionMessage.noData.name);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> remove<T>({
    required String dbName,
    required String key,
  }) async {
    try {
      /// Hive box
      final box = await Hive.openBox<T?>(dbName);
      await box.delete(key);

      return const Right('Başarıyla silindi.');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> set<T>({
    required String dbName,
    required String key,
    required T value,
  }) async {
    try {
      /// Hive box
      final box = await Hive.openBox<T?>(dbName);
      await box.put(key, value);

      return const Right('Başarıyla kaydedildi');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
