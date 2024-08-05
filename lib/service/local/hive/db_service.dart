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
        return const ErrorState(ExceptionType.noData);
      }
    } catch (e) {
      return const ErrorState(ExceptionType.errorOccured);
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
      return const ErrorState(ExceptionType.errorOccured);
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
      return const ErrorState(ExceptionType.errorOccured);
    }
  }

  /// Check if onboard is done
  Future<bool> isOnboardDone() async {
    final isOnboardDone = await get<bool?>(
      dbName: 'onboardService',
      key: 'isOnboardDone',
    );

    /// If onboard is not done
    /// Or there is an error from db
    /// Return false
    if (isOnboardDone is ErrorState<bool?>) {
      return false;
    } else {
      return isOnboardDone.data ?? false;
    }
  }

  /// Set first time dhikr list
  Future<void> setFirstTimeDhikr() async {
    await set<List<String>>(
      dbName: 'databaseService',
      key: 'dhikrList',
      value: [
        'Subhanallah',
        'Elhamdulillah',
        'Allahu ekber',
        'La ilahe illallah',
      ],
    );
  }

  /// Set notification disable for first time
  /// Notifications of the application will only be active if the user opens it
  /// from the settings screen.
  Future<void> setNotificationDisableForFirstTime() async {
    final isNotificationOpen = await get<bool>(
      dbName: 'notificationDatabase',
      key: 'isNotificationOpen',
    );
    if (isNotificationOpen is SuccessState<bool>) {
      if (isNotificationOpen.data == null) {
        await set<bool>(
          dbName: 'notificationDatabase',
          key: 'isNotificationOpen',
          value: false,
        );
      }
    } else {
      await set<bool>(
        dbName: 'notificationDatabase',
        key: 'isNotificationOpen',
        value: false,
      );
    }
  }

  /// Get theme preferences as boolean
  /// If there is no theme preference, return false
  /// If theme preference is true , its dark theme else light theme
  Future<bool> getThemePreferences() async {
    final isDarkTheme = await get<bool>(
      dbName: 'themeDatabase',
      key: 'isDarkTheme',
    );
    if (isDarkTheme is SuccessState<bool>) {
      return isDarkTheme.data ?? false;
    } else {
      return false;
    }
  }
}
