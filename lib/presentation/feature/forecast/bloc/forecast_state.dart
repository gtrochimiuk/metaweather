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
  final Forecast forecast;

  LoadedForecastState({@required this.forecast}) : assert(forecast != null);

  @override
  List<Object> get props => [forecast];
}

class FailureForecastState extends ForecastState {
  final Failure failure;

  FailureForecastState({@required this.failure}) : assert(failure != null);

  @override
  List<Object> get props => [failure];
}
