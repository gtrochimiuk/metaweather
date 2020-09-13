import 'package:flutter/material.dart';
import 'package:metaweather/data/model/forecast.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_app_bar.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_detail/forecast_detail.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_list/horizontal_forecast_list.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_list/vertical_forecast_list.dart';
import 'package:metaweather/presentation/widgets/page_body.dart';

class ForecastPageBody extends PageBody {
  final List<Forecast> forecasts;
  final Forecast selectedForecast;
  final void Function(Forecast) onForecastSelected;

  ForecastPageBody({
    Key key,
    @required this.forecasts,
    @required this.selectedForecast,
    @required this.onForecastSelected,
  })  : assert(forecasts != null),
        assert(selectedForecast != null),
        assert(onForecastSelected != null),
        super(key: key);

  @override
  Widget buildPortrait(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildForecastDetail(context),
          _buildForecastHorizontalList(context),
        ],
      ),
    );
  }

  @override
  Widget buildLandscape(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildScrollableForecastDetail(context),
        _buildForecastVerticalList(context),
      ],
    );
  }

  Widget _buildForecastDetail(BuildContext context) {
    return Flexible(
      child: ForecastDetail(forecast: selectedForecast),
    );
  }

  Widget _buildScrollableForecastDetail(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: ForecastDetail(forecast: selectedForecast),
      ),
    );
  }

  Widget _buildForecastHorizontalList(BuildContext context) {
    return Flexible(
      child: Container(
        height: 150,
        child: HorizontalForecastList(
          forecasts: forecasts,
          selectedForecast: selectedForecast,
          onForecastSelected: onForecastSelected,
        ),
      ),
    );
  }

  Widget _buildForecastVerticalList(BuildContext context) {
    return Flexible(
      child: Container(
        height: MediaQuery.of(context).size.height - ForecastAppBar.height,
        child: VerticalForecastList(
          forecasts: forecasts,
          selectedForecast: selectedForecast,
          onForecastSelected: onForecastSelected,
        ),
      ),
    );
  }
}
