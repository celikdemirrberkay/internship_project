import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/// The locator class where we register our dependencies
final locator = GetIt.instance;

/// Setup dependencies for the application
Future<void> setupDependencies() async {
  /// Registering Dio instance as Singleton
  locator.registerSingleton<Dio>(Dio());
}
