import 'package:flutter/material.dart';
import 'package:metaweather/data/model/weather/forecast.dart';
import 'package:metaweather/presentation/style/app_margin.dart';

abstract class ForecastList extends StatelessWidget {
  final Axis direction;
  final List<Forecast> forecasts;
  final Forecast selectedForecast;
  final void Function(Forecast) onForecastSelected;

  const ForecastList({
    Key key,
    @required this.direction,
    @required this.forecasts,
    @required this.selectedForecast,
    @required this.onForecastSelected,
  })  : assert(direction != null),
        assert(forecasts != null),
        assert(selectedForecast != null),
        assert(onForecastSelected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: direction,
      padding: const EdgeInsets.symmetric(
        horizontal: AppMargin.horizontal,
        vertical: AppMargin.vertical,
      ),
      itemCount: forecasts.length,
      itemBuilder: buildItem,
      separatorBuilder: _buildSeparator,
    );
  }

  Widget buildItem(BuildContext context, int index);

  Widget _buildSeparator(BuildContext context, int index) {
    return const SizedBox(
      width: AppMargin.horizontal,
      height: AppMargin.vertical,
    );
  }
}
