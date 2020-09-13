import 'package:flutter/material.dart';
import 'package:metaweather/data/model/forecast.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_list/forecast_list.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_list/vertical_forecast_list_item.dart';

class VerticalForecastList extends ForecastList {
  const VerticalForecastList({
    Key key,
    List<Forecast> forecasts,
    Forecast selectedForecast,
    void Function(Forecast) onForecastSelected,
  }) : super(
          key: key,
          direction: Axis.vertical,
          forecasts: forecasts,
          selectedForecast: selectedForecast,
          onForecastSelected: onForecastSelected,
        );

  @override
  Widget buildItem(BuildContext context, int index) {
    final forecast = forecasts[index];
    return VerticalForecastListItem(
      forecast: forecast,
      isSelected: forecast == selectedForecast,
      onSelected: onForecastSelected,
    );
  }
}
