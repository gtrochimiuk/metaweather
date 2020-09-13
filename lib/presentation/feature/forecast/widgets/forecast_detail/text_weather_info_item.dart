import 'package:flutter/material.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_detail/weather_info_item.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';

class TextWeatherInfoItem extends WeatherInfoItem {
  final String value;

  TextWeatherInfoItem({
    Key key,
    @required String label,
    @required this.value,
  })  : assert(value != null),
        super(key: key, label: label);

  @override
  Widget buildValue(BuildContext context) {
    return Text(
      value,
      style: AppTextStyles.body(context),
    );
  }
}
