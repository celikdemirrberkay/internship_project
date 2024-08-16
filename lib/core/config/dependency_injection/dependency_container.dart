import 'package:dio/dio.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:internship_project/service/local/city_name/city_name_service.dart';
import 'package:internship_project/service/local/dhikr/dhikr_service.dart';
import 'package:internship_project/service/local/god_names/god_names_service.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:internship_project/service/local/onboard/onboard_service.dart';
import 'package:internship_project/service/local/theme/theme_service.dart';
import 'package:internship_project/service/notification/background_service.dart';
import 'package:internship_project/service/notification/notification_service.dart';
import 'package:internship_project/service/remote/ayah/ayah_service.dart';
import 'package:internship_project/service/remote/location/location_service.dart';
import 'package:internship_project/service/remote/prayer_times/prayer_times_service.dart';

/// The locator class where we register our dependencies
final locator = GetIt.instance;

/// Setup dependencies for the application
Future<void> setupDependencies() async {
  locator

    /// Registering DatabaseService as Singleton
    ..registerSingleton<LocalDatabaseService>(LocalDatabaseService())

    /// Registering OnboardService as Singleton
    ..registerSingleton<OnboardService>(OnboardService())

    /// Registering DhikrService as Singleton
    ..registerSingleton<DhikrService>(DhikrService())

    /// Registering ThemeService as Singleton
    ..registerSingleton<ThemeService>(ThemeService())

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
