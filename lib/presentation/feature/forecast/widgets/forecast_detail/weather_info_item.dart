import 'package:flutter/material.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';

abstract class WeatherInfoItem extends StatelessWidget {
  final String label;

  const WeatherInfoItem({
    Key key,
    @required this.label,
  })  : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(context),
          buildValue(context),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.subtitle(context),
    );
  }

  Widget buildValue(BuildContext context);
}
