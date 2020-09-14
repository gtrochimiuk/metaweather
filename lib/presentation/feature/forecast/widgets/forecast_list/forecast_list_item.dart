import 'package:flutter/material.dart';
import 'package:metaweather/common/extensions/date_time_extensions.dart';
import 'package:metaweather/data/model/weather/forecast.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/temperature_range.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/weather_image.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';

abstract class ForecastListItem extends StatelessWidget {
  final Forecast forecast;
  final bool isSelected;
  final void Function(Forecast) onSelected;
  final double size;

  double get weatherImageHeight;

  BorderRadius get borderRadius => BorderRadius.circular(5);

  const ForecastListItem({
    Key key,
    @required this.forecast,
    @required this.isSelected,
    @required this.onSelected,
    this.size,
  })  : assert(forecast != null),
        assert(isSelected != null),
        assert(onSelected != null),
        super(key: key);

  void _onSelected(BuildContext context) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 300),
      alignment: 0.5,
    );
    onSelected(forecast);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onSelected(context),
      borderRadius: borderRadius,
      child: Material(
        child: Container(
          width: size,
          height: size,
          decoration: _buildDecoration(context),
          child: buildContent(context),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(
        color: isSelected ? AppColors.secondaryContent(context) : AppColors.secondaryBackground(context),
      ),
      borderRadius: borderRadius,
    );
  }

  Widget buildContent(BuildContext context);

  Widget buildDateLabel(BuildContext context) {
    return Text(
      forecast.date.formatWeekDay(),
      style: AppTextStyles.body(context),
    );
  }

  Widget buildWeatherImage(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: weatherImageHeight),
      child: WeatherImage(imageUrl: forecast.weatherState.imageUrl),
    );
  }

  Widget buildTemperatureRange(BuildContext context) {
    return TemperatureRange(
      temperature: forecast.weatherState.temperature,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
