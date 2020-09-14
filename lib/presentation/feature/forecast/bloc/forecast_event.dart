import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/data/model/weather/forecast.dart';

abstract class ForecastEvent extends Equatable {}

class LoadForecastEvent extends ForecastEvent {
  final int locationId;
  final Completer completer;

  LoadForecastEvent({@required this.locationId, this.completer}) : assert(locationId != null);

  @override
  List<Object> get props => [locationId];
}

class SelectForecastEvent extends ForecastEvent {
  final Forecast forecast;

  SelectForecastEvent({@required this.forecast}) : assert(forecast != null);

  @override
  List<Object> get props => [forecast];
}
