import 'dart:async';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:metaweather/common/extensions/date_time_extensions.dart';
import 'package:metaweather/common/utils/device.dart';
import 'package:metaweather/data/model/weather/forecast.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_detail/forecast_detail.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_list/horizontal_forecast_list.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_list/vertical_forecast_list.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';
import 'package:metaweather/presentation/widgets/orientation_based_page_body.dart';
import 'package:metaweather/presentation/widgets/refresh_indicator_mixin.dart';

class ForecastPageBody extends OrientationBasedPageBody with RefreshIndicatorMixin {
  final List<Forecast> forecasts;
  final Forecast selectedForecast;
  final void Function(Forecast) onForecastSelected;
  final void Function({Completer<void> completer, bool showLoadingIndicator}) refreshForecast;

  ForecastPageBody({
    Key key,
    @required this.forecasts,
    @required this.selectedForecast,
    @required this.onForecastSelected,
    @required this.refreshForecast,
  })  : assert(forecasts != null),
        assert(selectedForecast != null),
        assert(onForecastSelected != null),
        assert(refreshForecast != null),
        super(key: key);

  Future<void> _onRefresh() {
    final Completer<void> completer = Completer();
    refreshForecast(completer: completer, showLoadingIndicator: false);
    return completer.future;
  }

  @override
  Widget buildPortrait(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: 70,
      builder: _buildRefreshIndicator,
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: _buildPortraitBody(context),
      ),
    );
  }

  Widget _buildPortraitBody(BuildContext context) {
    return Container(
      height: Device.screenHeight(context) - Device.pullToRefreshOffset,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildForecastDetail(context),
            _buildForecastHorizontalList(context),
          ],
        ),
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

  Widget _buildRefreshIndicator(
    BuildContext context,
    Widget child,
    IndicatorController controller,
  ) {
    final formattedDate = selectedForecast.createdAt.formatDayTime();
    final deviceWidth = MediaQuery.of(context).size.width;
    return buildRefreshIndicator(
      context,
      child: child,
      controller: controller,
      label: AppTexts.current.forecastCreated(formattedDate),
      width: Device.isLandscape(context) ? deviceWidth / 2 : deviceWidth,
    );
  }

  Widget _buildForecastDetail(BuildContext context) {
    return ForecastDetail(forecast: selectedForecast);
  }

  Widget _buildScrollableForecastDetail(BuildContext context) {
    return Flexible(
      child: CustomRefreshIndicator(
        offsetToArmed: 50,
        builder: _buildRefreshIndicator,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: AppMargin.vertical),
          child: SafeArea(
            child: ForecastDetail(forecast: selectedForecast),
          ),
        ),
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
      child: SafeArea(
        child: VerticalForecastList(
          forecasts: forecasts,
          selectedForecast: selectedForecast,
          onForecastSelected: onForecastSelected,
        ),
      ),
    );
  }
}
