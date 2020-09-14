import 'package:flutter/material.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double value;
  final double strokeWidth;

  const LoadingIndicator({
    Key key,
    this.value,
    this.strokeWidth = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = AppColors.secondaryContent(context);
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        value: value,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
