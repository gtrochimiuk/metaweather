import 'package:flutter/material.dart';
import 'package:metaweather/data/model/temperature.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';

class TemperatureRange extends StatelessWidget {
  final Temperature temperature;
  final MainAxisAlignment mainAxisAlignment;

  const TemperatureRange({
    Key key,
    @required this.temperature,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  })  : assert(temperature != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        _buildTemperatureWithIcon(
          context,
          formattedTemperature: temperature.formatMin(),
          icon: Icons.arrow_downward,
        ),
        _buildTemperatureWithIcon(
          context,
          formattedTemperature: temperature.formatMax(),
          icon: Icons.arrow_upward,
        ),
      ],
    );
  }

  Widget _buildTemperatureWithIcon(
    BuildContext context, {
    String formattedTemperature,
    IconData icon,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: AppColors.secondaryContent(context),
        ),
        Text(
          formattedTemperature,
          style: AppTextStyles.body(context),
        )
      ],
    );
  }
}
