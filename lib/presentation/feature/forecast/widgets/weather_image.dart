import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:metaweather/presentation/widgets/loading_indicator.dart';

class WeatherImage extends StatelessWidget {
  final String imageUrl;

  const WeatherImage({
    Key key,
    @required this.imageUrl,
  })  : assert(imageUrl != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxSize = min(constraints.maxWidth, constraints.maxHeight);
        return SvgPicture.network(
          imageUrl,
          width: maxSize / 1.5,
          height: maxSize / 1.5,
          alignment: Alignment.centerLeft,
          placeholderBuilder: (_) => const LoadingIndicator(),
        );
      },
    );
  }
}
