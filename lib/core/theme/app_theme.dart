import 'package:flutter/material.dart';

/// App Colors
class AppTheme {
  /// Light theme
  static ThemeData lightTheme = ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromARGB(255, 239, 239, 239),
    inputDecorationTheme: const InputDecorationTheme(
      counterStyle: TextStyle(color: Colors.black),
    ),
  );

  /// App color schema
  static ColorScheme get colorScheme => const ColorScheme(
        primary: Color.fromARGB(255, 41, 135, 44),
        secondary: Color.fromARGB(255, 19, 46, 20),
        surface: Color.fromARGB(255, 246, 246, 246),
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onError: Colors.red,
        brightness: Brightness.light,
      );

  /// Other static colors
  static const Color prayerContainerColor = Color(0xFF3d6838);
}
