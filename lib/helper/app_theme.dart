import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const appTheme = Brightness.dark;

  static const gridBoxColor = Color(0xFF212121);

  static final darkTheme = FlexThemeData.dark(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff5db3d5),
      onPrimary: Color(0xff101b1e),
      primaryContainer: Color(0xff297ea0),
      onPrimaryContainer: Color(0xffd9edf5),
      secondary: Color(0xffa1e9df),
      onSecondary: Color(0xff181e1e),
      secondaryContainer: Color(0xff005049),
      onSecondaryContainer: Color(0xffd0e3e1),
      tertiary: Color(0xffa0e5e5),
      onTertiary: Color(0xff181e1e),
      tertiaryContainer: Color(0xff004f50),
      onTertiaryContainer: Color(0xffd0e2e3),
      error: Color(0xffcf6679),
      onError: Color(0xff1e1214),
      errorContainer: Color(0xffb1384e),
      onErrorContainer: Color(0xfff9dde2),
      outline: Color(0xff959999),
      surface: Color(0xff131516),
      onSurface: Color(0xfff1f1f1),
      onSurfaceVariant: Color(0xffe3e3e4),
      inverseSurface: Color(0xfffafcfd),
      onInverseSurface: Color(0xff0e0e0e),
      inversePrimary: Color(0xff355967),
      shadow: Color(0xff000000),
    ),
  );

  static final sakuraTheme = ThemeData();

  static final lightTheme = ThemeData();
}
