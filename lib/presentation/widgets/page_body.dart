import 'package:flutter/material.dart';
import 'package:metaweather/common/utils/device.dart';

abstract class PageBody extends StatelessWidget {
  const PageBody({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    if (Device.isLandscape(context)) {
      return buildLandscape(context);
    } else {
      return buildPortrait(context);
    }
  }

  Widget buildPortrait(BuildContext context);

  Widget buildLandscape(BuildContext context);
}
