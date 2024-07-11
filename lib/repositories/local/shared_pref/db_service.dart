import 'package:either_dart/src/either.dart';
import 'package:hive/hive.dart';
import 'package:internship_project/repositories/local/shared_pref/db_service_interface.dart';

class DatabaseService extends IDatabaseService {
  /// Constructor
  DatabaseService(super.hive);

  @override
  Future<Either<String, String?>> get(String key) async {
    try {
      /// Hive box
      final box = await hive.openBox<String>(DbServiceEnum.databaseService.name);
      final response = box.get(key);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> remove(String key) async {
    try {
      /// Hive box
      final box = await hive.openBox<String>(DbServiceEnum.databaseService.name);
      await box.delete(key);

      return Right('Başarıyla silindi.');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> set(String key, int value) async {
    try {
      /// Hive box
      final box = await hive.openBox<int>(DbServiceEnum.databaseService.name);
      await box.put(key, value);

      return Right('Başarıyla kaydedildi');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

/// Database service enum
enum DbServiceEnum {
  /// Database service
  databaseService,
}
