import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';

/// AppInitializer is a class that initializes the app.
class AppInitializer {
  /// Initialize the app
  static Future<void> initialize() async {
    /// Setting up dependencies
    await setupDependencies();
  }
}
