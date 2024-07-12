import 'package:either_dart/src/either.dart';
import 'package:hive/hive.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/repositories/local/shared_pref/db_service_interface.dart';

/// Abstraction of local database service
class LocalDatabaseService extends IDatabaseService {
  /// Constructor
  LocalDatabaseService();

  @override
  Future<Either<String, T>> get<T>(String key) async {
    try {
      /// Hive box
      final box = await Hive.openBox<T?>(_DbServiceEnum.databaseService.name);
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
  Future<Either<String, String>> remove<T>(String key) async {
    try {
      /// Hive box
      final box = await Hive.openBox<T?>(_DbServiceEnum.databaseService.name);
      await box.delete(key);

      return const Right('Başarıyla silindi.');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> set<T>(String key, T value) async {
    try {
      /// Hive box
      final box = await Hive.openBox<T?>(_DbServiceEnum.databaseService.name);
      await box.put(key, value);

      return const Right('Başarıyla kaydedildi');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

/// Database service enum
enum _DbServiceEnum {
  /// Database service
  databaseService,
}
