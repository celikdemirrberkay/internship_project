import 'package:hive/hive.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/exception/exception_type.dart';
import 'package:internship_project/service/local/hive/db_service_interface.dart';

/// Abstraction of local database service
class LocalDatabaseService extends ILocalDatabaseService {
  /// Constructor
  LocalDatabaseService();

  @override
  Future<Resource<T>> get<T>({
    required String dbName,
    required String key,
  }) async {
    try {
      /// Hive box
      final box = await Hive.openBox<T?>(dbName);
      final response = box.get(key);

      if (response != null) {
        return SuccessState(response);
      } else {
        return const ErrorState(ExceptionTypes.noData);
      }
    } catch (e) {
      return const ErrorState(ExceptionTypes.errorOccured);
    }
  }

  @override
  Future<Resource<String>> remove<T>({
    required String dbName,
    required String key,
  }) async {
    try {
      /// Hive box
      final box = await Hive.openBox<T?>(dbName);
      await box.delete(key);

      return const SuccessState('Başarıyla silindi.');
    } catch (e) {
      return const ErrorState(ExceptionTypes.errorOccured);
    }
  }

  @override
  Future<Resource<String>> set<T>({
    required String dbName,
    required String key,
    required T value,
  }) async {
    try {
      /// Hive box
      final box = await Hive.openBox<T?>(dbName);
      await box.put(key, value);

      return const SuccessState('Başarıyla kaydedildi');
    } catch (e) {
      return const ErrorState(ExceptionTypes.errorOccured);
    }
  }
}
