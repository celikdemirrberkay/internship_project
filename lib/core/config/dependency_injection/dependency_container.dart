import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internship_project/repositories/prayer_times/prayer_times_service.dart';

/// The locator class where we register our dependencies
final locator = GetIt.instance;

/// Setup dependencies for the application
Future<void> setupDependencies() async {
  /// Registering Dio instance as Singleton
  locator
    ..registerSingleton<Dio>(Dio())

    /// Registering PrayerTimesService
    ..registerSingleton<PrayerTimesService>(PrayerTimesService(locator()));
}
