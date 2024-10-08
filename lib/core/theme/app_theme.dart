import 'package:flutter/material.dart';

/// App Colors
class AppTheme {
  /// Light theme
  static ThemeData lightTheme = ThemeData(
    colorScheme: _lightColorScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF3F3F5),
    inputDecorationTheme: const InputDecorationTheme(
      counterStyle: TextStyle(color: Colors.black),
    ),
  );

  /// Dark theme
  static ThemeData darkTheme = ThemeData(
    colorScheme: _darkColorScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromARGB(255, 201, 201, 201),
    inputDecorationTheme: const InputDecorationTheme(
      counterStyle: TextStyle(color: Colors.black),
    ),
  );

  /// Light color scheme
  static ColorScheme get _lightColorScheme => ColorScheme(
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

  /// Dark color scheme
  static ColorScheme get _darkColorScheme => ColorScheme(
        primary: const Color(0XFF26c687),
        secondary: const Color.fromARGB(255, 30, 80, 35),
        surface: const Color.fromARGB(255, 40, 40, 40),
        error: Colors.red.shade400,
        onPrimary: const Color.fromARGB(255, 232, 232, 232),
        onSecondary: Colors.black,
        onSurface: Colors.grey.shade500,
        onError: Colors.white,
        primaryContainer: Colors.purple.shade700,
        brightness: Brightness.dark,
      );

  /// Other static colors
  static const Color settingsButtonColor = Colors.green;
  static const Color bottomNavbarTextColor = Color.fromARGB(255, 44, 132, 46);
  static const Color bottomNavbarTextBackgroundColor = Color(0xFFd3f3e6);
  static const Color shimmerBaseColor = Color.fromARGB(255, 188, 188, 188);
  static const Color shimmerHighlightColor = Color.fromARGB(255, 224, 224, 224);

  /// Theme preference of app (default is light theme)
  static ValueNotifier<ThemeData> themePreference = ValueNotifier(AppTheme.lightTheme);
}
