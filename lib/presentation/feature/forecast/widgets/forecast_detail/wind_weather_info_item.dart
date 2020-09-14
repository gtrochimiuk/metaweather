import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/dependency_injection/injector.dart';
import 'package:metaweather/common/extensions/double_extensions.dart';
import 'package:metaweather/data/model/weather/wind.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_detail/weather_info_item.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_bloc.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_state.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';

class WindWeatherInfoItem extends WeatherInfoItem {
  final Wind wind;

  WindWeatherInfoItem({
    Key key,
    @required this.wind,
    @required String label,
  })  : assert(wind != null),
        super(key: key, label: label);

  @override
  Widget buildValue(BuildContext context) {
    return Row(
      children: [
        _buildSpeedLabel(context),
        _buildDirectionIcon(context),
      ],
    );
  }

  Widget _buildSpeedLabel(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      cubit: Injector.resolve(),
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(right: 5),
          child: Text(
            wind.formatSpeed(state.settings.lengthUnit),
            style: AppTextStyles.body(context),
          ),
        );
      },
    );
  }

  Widget _buildDirectionIcon(BuildContext context) {
    return Transform.rotate(
      angle: wind.direction.degreesToRadians(),
      child: Icon(
        Icons.arrow_downward,
        color: AppColors.secondaryContent(context),
      ),
    );
  }
}
