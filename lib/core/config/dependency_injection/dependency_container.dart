import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internship_project/service/local/city_name/city_name_service.dart';
import 'package:internship_project/service/local/god_names/god_names_service.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:internship_project/service/notification/notification_service.dart';
import 'package:internship_project/service/remote/ayah/ayah_service.dart';
import 'package:internship_project/service/remote/location/location_service.dart';
import 'package:internship_project/service/remote/prayer_times/prayer_times_service.dart';

/// The locator class where we register our dependencies
final locator = GetIt.instance;

/// Setup dependencies for the application
Future<void> setupDependencies() async {
  /// Registering Dio instance as Singleton
  locator
    ..registerSingleton<Dio>(Dio())

    /// Registering GodNamesService as Singleton
    ..registerSingleton<GodNamesService>(GodNamesService())

    /// Registering CityNameService as Singleton
    ..registerSingleton<CityNameService>(CityNameService())

    /// Registering GodNamesService as Singleton
    ..registerSingleton<LocationService>(LocationService())

    /// Registering DatabaseService as Singleton
    ..registerSingleton<LocalDatabaseService>(LocalDatabaseService())

    /// Registering LocalNotificationService as Singleton
    ..registerSingleton<LocalNotificationService>(LocalNotificationService())

    /// Registering AyahService as Singleton
    ..registerSingleton<AyahService>(AyahService(locator()))

    /// Registering PrayerTimesService as Singleton
    ..registerSingleton<PrayerTimesService>(PrayerTimesService(locator()));
}
