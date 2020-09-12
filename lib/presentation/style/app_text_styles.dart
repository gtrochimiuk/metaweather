import 'package:flutter/material.dart';

import 'color/app_colors.dart';

abstract class AppTextStyles {
  static const fontFamily = 'Lato';

  static TextStyle headline(BuildContext context, {Color color}) => TextStyle(
        color: color ?? AppColors.primaryContent(context),
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
      );

  static TextStyle body(BuildContext context, {Color color}) => TextStyle(
        color: color ?? AppColors.primaryContent(context),
        fontSize: 18,
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      );

  static TextStyle subtitle(BuildContext context, {Color color}) => TextStyle(
        color: color ?? AppColors.secondaryContent(context),
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      );
}
