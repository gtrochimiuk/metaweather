import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/dependency_injection/injector.dart';
import 'package:metaweather/data/model/settings/settings.dart';
import 'package:metaweather/data/model/weather/temperature.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_bloc.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_state.dart';
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
    return BlocBuilder<SettingsBloc, SettingsState>(
      cubit: Injector.resolve(),
      builder: (context, state) {
        return _buildContent(context, state.settings);
      },
    );
  }

  Widget _buildContent(BuildContext context, Settings settings) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        _buildTemperatureWithIcon(
          context,
          formattedTemperature: temperature.formatMin(settings.temperatureUnit),
          icon: Icons.arrow_downward,
        ),
        _buildTemperatureWithIcon(
          context,
          formattedTemperature: temperature.formatMax(settings.temperatureUnit),
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
