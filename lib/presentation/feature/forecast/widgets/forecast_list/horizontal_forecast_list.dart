import 'package:flutter/material.dart';
import 'package:metaweather/data/model/weather/forecast.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_list/forecast_list.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_list/horizontal_forecast_list_item.dart';

class HorizontalForecastList extends ForecastList {
  const HorizontalForecastList({
    Key key,
    List<Forecast> forecasts,
    Forecast selectedForecast,
    void Function(Forecast) onForecastSelected,
  }) : super(
          key: key,
          direction: Axis.horizontal,
          forecasts: forecasts,
          selectedForecast: selectedForecast,
          onForecastSelected: onForecastSelected,
        );

  @override
  Widget buildItem(BuildContext context, int index) {
    final forecast = forecasts[index];
    return HorizontalForecastListItem(
      forecast: forecast,
      isSelected: forecast == selectedForecast,
      onSelected: onForecastSelected,
    );
  }
}
