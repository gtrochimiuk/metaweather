import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/dependency_injection/injector.dart';
import 'package:metaweather/data/model/weather/forecast.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_detail/text_weather_info_item.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_detail/wind_weather_info_item.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_bloc.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_state.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

class ForecastAdditionalInfo extends StatelessWidget {
  final Forecast forecast;

  const ForecastAdditionalInfo({
    Key key,
    @required this.forecast,
  })  : assert(forecast != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStartColumn(context),
        _buildEndColumn(context),
      ],
    );
  }

  Widget _buildStartColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHumidityInfoItem(context),
        _buildWindInfoItem(context),
      ],
    );
  }

  Widget _buildEndColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAirPressureInfoItem(context),
        _buildVisibilityInfoItem(context),
      ],
    );
  }

  Widget _buildHumidityInfoItem(BuildContext context) {
    return TextWeatherInfoItem(
      label: AppTexts.current.humidity(),
      value: forecast.weatherState.formatHumidity(),
    );
  }

  Widget _buildAirPressureInfoItem(BuildContext context) {
    return TextWeatherInfoItem(
      label: AppTexts.current.airPressure(),
      value: forecast.weatherState.formatAirPressure(),
    );
  }

  Widget _buildWindInfoItem(BuildContext context) {
    return WindWeatherInfoItem(
      label: AppTexts.current.wind(),
      wind: forecast.weatherState.wind,
    );
  }

  Widget _buildVisibilityInfoItem(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      cubit: Injector.resolve(),
      builder: (context, state) {
        return TextWeatherInfoItem(
          label: AppTexts.current.visibility(),
          value: forecast.weatherState.formatVisibility(state.settings.lengthUnit),
        );
      },
    );
  }
}
