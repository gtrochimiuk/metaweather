import 'package:flutter/material.dart';
import 'package:metaweather/presentation/style/color/dark_theme_colors.dart';
import 'package:metaweather/presentation/style/color/light_theme_colors.dart';
import 'package:metaweather/presentation/style/color/themed_color.dart';

abstract class AppColors {
  static Color background(BuildContext context) => ThemedColor(
        light: LightThemeColors.background,
        dark: DarkThemeColors.background,
      ).getColor(context);

  static Color secondaryBackground(BuildContext context) => ThemedColor(
        light: LightThemeColors.secondaryBackground,
        dark: DarkThemeColors.secondaryBackground,
      ).getColor(context);

  static Color primaryContent(BuildContext context) => ThemedColor(
        light: LightThemeColors.primaryContent,
        dark: DarkThemeColors.primaryContent,
      ).getColor(context);

  static Color secondaryContent(BuildContext context) => ThemedColor(
        light: LightThemeColors.secondaryContent,
        dark: DarkThemeColors.secondaryContent,
      ).getColor(context);
}
