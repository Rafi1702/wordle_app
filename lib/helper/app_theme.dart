import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

enum Themes { sakuraTheme, darkTheme }

extension ThemesX on Themes {
  ThemeData get getThemeData {
    switch (this) {
      case Themes.sakuraTheme:
        return AppTheme.sakuraTheme;
      case Themes.darkTheme:
        return AppTheme.darkTheme;
    }
  }
}

class AppTheme {
  static const gridBoxColor = Color(0xFF212121);

  static final darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.sakura,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 15,
    appBarStyle: FlexAppBarStyle.background,
    appBarOpacity: 0.90,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 30,
      elevatedButtonRadius: 4.0,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );

  static final sakuraTheme = FlexThemeData.light(
    scheme: FlexScheme.sakura,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 20,
    appBarOpacity: 0.95,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      blendOnColors: false,
      elevatedButtonRadius: 0.0,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );

  static final lightTheme = ThemeData();
}
