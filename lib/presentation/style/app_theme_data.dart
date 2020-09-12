import 'package:flutter/material.dart';
import 'package:metaweather/presentation/style/color/dark_theme_colors.dart';
import 'package:metaweather/presentation/style/color/light_theme_colors.dart';

abstract class AppThemeData {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    backgroundColor: LightThemeColors.background,
    scaffoldBackgroundColor: LightThemeColors.background,
    canvasColor: Colors.transparent,
  );
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: DarkThemeColors.background,
    scaffoldBackgroundColor: DarkThemeColors.background,
    canvasColor: Colors.transparent,
  );
}
