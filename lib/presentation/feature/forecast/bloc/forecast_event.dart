import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ForecastEvent extends Equatable {}

class LoadForecastEvent extends ForecastEvent {
  final int locationId;

  LoadForecastEvent({@required this.locationId}) : assert(locationId != null);

  @override
  List<Object> get props => [locationId];
}
