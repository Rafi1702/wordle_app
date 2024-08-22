import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

enum Themes { sakuraTheme, blueTheme }

extension ThemesX on Themes {
  ThemeData get getThemeData {
    switch (this) {
      case Themes.sakuraTheme:
        return AppTheme.sakuraTheme;
      case Themes.blueTheme:
        return AppTheme.blueTheme;
    }
  }
}

class AppTheme {
  static const gridBoxColor = Color(0xFF212121);

  static final sakuraTheme = FlexThemeData.dark(
    scheme: FlexScheme.sakura,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 13,
    appBarStyle: FlexAppBarStyle.background,
    appBarOpacity: 0.90,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 30,
      elevatedButtonRadius: 4.0,
      useTextTheme: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );

  static final blueTheme = FlexThemeData.dark(
    scheme: FlexScheme.blue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 13,
    appBarStyle: FlexAppBarStyle.background,
    appBarOpacity: 0.90,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 30,
      elevatedButtonRadius: 4.0,
      useTextTheme: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );
  static final lightTheme = ThemeData();
}
