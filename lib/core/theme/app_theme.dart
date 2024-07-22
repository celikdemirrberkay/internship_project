import 'package:flutter/material.dart';

/// App Colors
class AppTheme {
  /// Light theme
  static ThemeData lightTheme = ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xfff3f3f5),
    inputDecorationTheme: const InputDecorationTheme(
      counterStyle: TextStyle(color: Colors.black),
    ),
  );

  /// App color schema
  static ColorScheme get colorScheme => const ColorScheme(
        primary: Color(0XFF26c687),
        secondary: Color.fromARGB(255, 19, 46, 20),
        surface: Color.fromARGB(255, 246, 246, 246),
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Color(0xFF424242),
        onError: Colors.red,
        primaryContainer: Color.fromARGB(255, 100, 178, 234),
        brightness: Brightness.light,
      );

  /// Other static colors
  static const Color settingsButtonColor = Colors.green;
  static const Color bottomNavbarTextColor = Color.fromARGB(255, 44, 132, 46);
}
