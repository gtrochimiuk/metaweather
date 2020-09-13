import 'package:flutter/material.dart';
import 'package:metaweather/data/model/forecast.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_list/forecast_list_item.dart';

class HorizontalForecastListItem extends ForecastListItem {
  @override
  double get weatherImageHeight => 80;

  const HorizontalForecastListItem({
    Key key,
    Forecast forecast,
    bool isSelected,
    void Function(Forecast) onSelected,
  }) : super(
          key: key,
          forecast: forecast,
          isSelected: isSelected,
          onSelected: onSelected,
          size: 150,
        );

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildDateLabel(context),
        buildWeatherImage(context),
        buildTemperatureRange(context),
      ],
    );
  }
}
