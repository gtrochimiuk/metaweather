import 'package:flutter/material.dart';
import 'package:metaweather/data/model/forecast.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_list/forecast_list_item.dart';

class VerticalForecastListItem extends ForecastListItem {
  @override
  double get weatherImageHeight => 60;

  const VerticalForecastListItem({
    Key key,
    Forecast forecast,
    bool isSelected,
    void Function(Forecast) onSelected,
  }) : super(
          key: key,
          forecast: forecast,
          isSelected: isSelected,
          onSelected: onSelected,
          size: 70,
        );

  @override
  Widget buildContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildInfoColumn(context),
        buildWeatherImage(context),
      ],
    );
  }

  Widget _buildInfoColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDateLabel(context),
        buildTemperatureRange(context),
      ],
    );
  }
}
