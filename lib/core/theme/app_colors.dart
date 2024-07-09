import 'package:flutter/material.dart';

/// App Colors
class AppColors {
  /// App color schema
  static ColorScheme get colorScheme => const ColorScheme(
        primary: Color.fromARGB(255, 41, 135, 44),
        secondary: Color.fromARGB(255, 19, 46, 20),
        surface: Colors.white,
        error: Color.fromARGB(255, 151, 28, 19),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.white,
        brightness: Brightness.light,
      );
}
