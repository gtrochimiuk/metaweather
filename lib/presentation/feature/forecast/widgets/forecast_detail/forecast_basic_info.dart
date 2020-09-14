import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/dependency_injection/injector.dart';
import 'package:metaweather/data/model/weather/forecast.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/temperature_range.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/weather_image.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_bloc.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_state.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';

class ForecastBasicInfo extends StatelessWidget {
  final Forecast forecast;

  const ForecastBasicInfo({
    Key key,
    @required this.forecast,
  })  : assert(forecast != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppMargin.vertical),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWeatherImage(context),
          _buildWeatherData(context),
        ],
      ),
    );
  }

  Widget _buildWeatherImage(BuildContext context) {
    return Expanded(
      child: WeatherImage(imageUrl: forecast.weatherState.imageUrl),
    );
  }

  Widget _buildWeatherData(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStateName(context),
        _buildCurrentTemperature(context),
        _buildTemperatureRange(context),
      ],
    );
  }

  Widget _buildStateName(BuildContext context) {
    return Text(
      forecast.weatherState.name,
      style: AppTextStyles.body(context),
    );
  }

  Widget _buildCurrentTemperature(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      cubit: Injector.resolve(),
      builder: (context, state) {
        return Text(
          forecast.weatherState.temperature.formatCurrent(state.settings.temperatureUnit),
          style: AppTextStyles.mainInfo(context),
        );
      },
    );
  }

  Widget _buildTemperatureRange(BuildContext context) {
    return TemperatureRange(temperature: forecast.weatherState.temperature);
  }
}
