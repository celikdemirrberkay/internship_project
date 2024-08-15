import 'package:hive/hive.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/constants/local_database_constants.dart';
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
      dbName: LocalDatabaseNames.onboardDB.value,
      key: LocalDatabaseKeys.isOnboardDone.value,
    );

    /// If onboard is not done

    if (isOnboardDone is ErrorState<bool?>) {
      /// Return false
      return false;
    } else {
      /// Or there is an error from db
      /// Return false
      return isOnboardDone.data ?? false;
    }
  }

  /// Set first time dhikr list
  Future<void> setFirstTimeDhikr() async {
    await set<List<String>>(
      dbName: LocalDatabaseNames.rosaryDB.value,
      key: LocalDatabaseKeys.dhikrList.value,
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
      dbName: LocalDatabaseNames.notificationDB.value,
      key: LocalDatabaseKeys.isNotificationOpen.value,
    );
    if (isNotificationOpen is SuccessState<bool>) {
      if (isNotificationOpen.data == null) {
        await set<bool>(
          dbName: LocalDatabaseNames.notificationDB.value,
          key: LocalDatabaseKeys.isNotificationOpen.value,
          value: false,
        );
      }
    } else {
      await set<bool>(
        dbName: LocalDatabaseNames.notificationDB.value,
        key: LocalDatabaseKeys.isNotificationOpen.value,
        value: false,
      );
    }
  }

  /// Get theme preferences as boolean
  /// If there is no theme preference, return false
  /// If theme preference is true , its dark theme else light theme
  Future<bool> getThemePreferences() async {
    final isDarkTheme = await get<bool>(
      dbName: LocalDatabaseNames.themeDB.value,
      key: LocalDatabaseKeys.isDarkTheme.value,
    );
    if (isDarkTheme is SuccessState<bool>) {
      return isDarkTheme.data ?? false;
    } else {
      return false;
    }
  }
}
