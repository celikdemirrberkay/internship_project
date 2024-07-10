import 'package:flutter/material.dart';

/// App Colors
class AppTheme {
  /// App color schema
  static ColorScheme get colorScheme => const ColorScheme(
        primary: Color.fromARGB(255, 41, 135, 44),
        secondary: Color.fromARGB(255, 19, 46, 20),
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onError: Colors.white,
        brightness: Brightness.light,
      );

  /// App bottom navigation bar theme data
  static BottomNavigationBarThemeData bottomNavBarThemeData() => const BottomNavigationBarThemeData(
        selectedItemColor: Color.fromARGB(255, 41, 135, 44),
        type: BottomNavigationBarType.shifting,
      );
}
