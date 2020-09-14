import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/data/model/weather/forecast.dart';

abstract class ForecastEvent extends Equatable {}

class LoadForecastEvent extends ForecastEvent {
  final int locationId;
  final Completer completer;
  final bool showLoadingIndicator;

  LoadForecastEvent({
    @required this.locationId,
    this.completer,
    this.showLoadingIndicator = true,
  }) : assert(locationId != null);

  @override
  List<Object> get props => [locationId, completer, showLoadingIndicator];
}

class SelectForecastEvent extends ForecastEvent {
  final Forecast forecast;

  SelectForecastEvent({@required this.forecast}) : assert(forecast != null);

  @override
  List<Object> get props => [forecast];
}
