import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internship_project/repositories/local/god_names/god_names_service.dart';
import 'package:internship_project/repositories/local/shared_pref/db_service.dart';
import 'package:internship_project/repositories/remote/prayer_times/prayer_times_service.dart';

/// The locator class where we register our dependencies
final locator = GetIt.instance;

/// Setup dependencies for the application
Future<void> setupDependencies() async {
  /// Registering Dio instance as Singleton
  locator
    ..registerSingleton<Dio>(Dio())

    /// Registering GodNamesService as Singleton
    ..registerSingleton<GodNamesService>(GodNamesService())

    /// Registering DatabaseService as Singleton
    ..registerSingleton<DatabaseService>(DatabaseService())

    /// Registering PrayerTimesService as Singleton
    ..registerSingleton<PrayerTimesService>(PrayerTimesService(locator()));
}
