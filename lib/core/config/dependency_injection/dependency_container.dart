import 'package:dio/dio.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import '../../../service/local/city_name/city_name_service.dart';
import '../../../service/local/god_names/god_names_service.dart';
import '../../../service/local/hive/db_service.dart';
import '../../../service/notification/background_service.dart';
import '../../../service/notification/notification_service.dart';
import '../../../service/remote/ayah/ayah_service.dart';
import '../../../service/remote/location/location_service.dart';
import '../../../service/remote/prayer_times/prayer_times_service.dart';

/// The locator class where we register our dependencies
final locator = GetIt.instance;

/// Setup dependencies for the application
Future<void> setupDependencies() async {
  locator

    /// Registering DatabaseService as Singleton
    ..registerSingleton<LocalDatabaseService>(LocalDatabaseService())

    /// Registering Dio instance as Singleton
    ..registerSingleton<Dio>(Dio())

    /// Registering GodNamesService as Singleton
    ..registerSingleton<LocationService>(LocationService())

    /// Registering PrayerTimesService as Singleton
    ..registerSingleton<PrayerTimesService>(PrayerTimesService(locator()))

    /// Registering FlutterLocalNotificationsPlugin as Singleton
    ..registerSingleton<FlutterLocalNotificationsPlugin>(FlutterLocalNotificationsPlugin())

    /// Registering LocalNotificationService as Singleton
    ..registerSingleton<LocalNotificationService>(LocalNotificationService(locator(), locator()))

    /// Registering FlutterBackgroundService as Singleton
    ..registerSingleton<FlutterBackgroundService>(FlutterBackgroundService())

    /// Registering WorkmanagerService as Singleton
    ..registerSingleton<BackgroundService>(BackgroundService())

    /// Registering GodNamesService as Singleton
    ..registerSingleton<GodNamesService>(GodNamesService())

    /// Registering CityNameService as Singleton
    ..registerSingleton<CityNameService>(CityNameService())

    /// Registering AyahService as Singleton
    ..registerSingleton<AyahService>(AyahService(locator()));
}
