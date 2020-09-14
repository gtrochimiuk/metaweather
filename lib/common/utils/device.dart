import 'package:flutter/material.dart';

abstract class Device {
  static const double appBarHeight = 60;
  static const double pullToRefreshOffset = 20;

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static bool isLandscape(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > size.height;
  }

  static double screenHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height - mediaQuery.padding.vertical - Device.appBarHeight;
  }
}
