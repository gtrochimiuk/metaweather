import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/data/model/forecast.dart';

abstract class ForecastState extends Equatable {}

class LoadingForecastState extends ForecastState {
  @override
  List<Object> get props => [];
}

class LoadedForecastState extends ForecastState {
  final List<Forecast> forecasts;
  final Forecast selectedForecast;

  LoadedForecastState({
    @required this.forecasts,
    @required this.selectedForecast,
  })  : assert(forecasts != null),
        assert(selectedForecast != null);

  @override
  List<Object> get props => [forecasts, selectedForecast];
}

class FailureForecastState extends ForecastState {
  final Failure failure;

  FailureForecastState({@required this.failure}) : assert(failure != null);

  @override
  List<Object> get props => [failure];
}
