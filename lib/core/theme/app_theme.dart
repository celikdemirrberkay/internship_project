import 'package:flutter/material.dart';

/// App Colors
class AppTheme {
  /// Light theme
  static ThemeData lightTheme = ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF3F3F5),
    inputDecorationTheme: const InputDecorationTheme(
      counterStyle: TextStyle(color: Colors.black),
    ),
  );

  /// App color schema
  static ColorScheme get colorScheme => ColorScheme(
        primary: const Color(0XFF26c687),
        secondary: const Color.fromARGB(255, 19, 46, 20),
        surface: const Color.fromARGB(255, 246, 246, 246),
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.grey.shade300,
        onError: Colors.red,
        primaryContainer: Colors.purple.shade200,
        brightness: Brightness.light,
      );

  /// Other static colors
  static const Color settingsButtonColor = Colors.green;
  static const Color bottomNavbarTextColor = Color.fromARGB(255, 44, 132, 46);
  static const Color bottomNavbarTextBackgroundColor = Color(0xFFd3f3e6);
}
