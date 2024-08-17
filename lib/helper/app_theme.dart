import 'package:flutter/material.dart';

class AppTheme {
  static const appTheme = Brightness.dark;

  static const gridBoxColor = Color(0xFF212121);

  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(elevation: 1.0),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.green,
      secondary: const Color(0xFFFFA48E),
      error: Colors.red.shade500,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      surface: const Color(0xFF121212),
    ),
  );

  static final sakuraTheme = ThemeData();

  static final lightTheme = ThemeData();
}
