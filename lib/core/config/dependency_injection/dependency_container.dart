import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:internship_project/repositories/god_names/god_names_service.dart';
import 'package:internship_project/repositories/prayer_times/prayer_times_service.dart';
=======
>>>>>>> 324fc6f (Backend successfully integrated and dependency injection container created.)
=======
import 'package:internship_project/repositories/prayer_times/prayer_times_service.dart';
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))

/// The locator class where we register our dependencies
final locator = GetIt.instance;

/// Setup dependencies for the application
Future<void> setupDependencies() async {
  /// Registering Dio instance as Singleton
<<<<<<< HEAD
<<<<<<< HEAD
  locator
    ..registerSingleton<Dio>(Dio())

    /// Registering GodNamesService as Singleton
    ..registerSingleton<GodNamesService>(GodNamesService())

    /// Registering PrayerTimesService as Singleton
    ..registerSingleton<PrayerTimesService>(PrayerTimesService(locator()));
=======
  locator.registerSingleton<Dio>(Dio());
>>>>>>> 324fc6f (Backend successfully integrated and dependency injection container created.)
=======
  locator
    ..registerSingleton<Dio>(Dio())

    /// Registering PrayerTimesService
    ..registerSingleton<PrayerTimesService>(PrayerTimesService(locator()));
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
}
