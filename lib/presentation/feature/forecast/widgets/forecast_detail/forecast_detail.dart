import 'package:flutter/material.dart';
import 'package:metaweather/common/extensions/date_time_extensions.dart';
import 'package:metaweather/data/model/weather/forecast.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_detail/forecast_additional_info.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_detail/forecast_basic_info.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/metaweather_attribution_label.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';

class ForecastDetail extends StatelessWidget {
  final Forecast forecast;

  const ForecastDetail({
    Key key,
    @required this.forecast,
  })  : assert(forecast != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.horizontal,
        vertical: AppMargin.vertical,
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDateLabel(context),
        _buildBasicInfo(context),
        _buildAdditionalInfo(context),
        _buildAttributionLabel(context),
      ],
    );
  }

  Widget _buildAttributionLabel(BuildContext context) {
    return MetaweatherAttributionLabel();
  }

  Widget _buildDateLabel(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppMargin.vertical,
      ),
      child: Text(
        forecast.date.formatLong(),
        style: AppTextStyles.body(context),
      ),
    );
  }

  Widget _buildBasicInfo(BuildContext context) {
    return ForecastBasicInfo(forecast: forecast);
  }

  Widget _buildAdditionalInfo(BuildContext context) {
    return ForecastAdditionalInfo(forecast: forecast);
  }
}
