import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/data/model/location/location.dart';

abstract class LocationSearchEvent extends Equatable {}

class PerformLocationSearchEvent extends LocationSearchEvent {
  final String query;

  PerformLocationSearchEvent({@required this.query}) : assert(query != null);

  @override
  List<Object> get props => [query];
}

class LoadPreviousLocationsEvent extends LocationSearchEvent {
  @override
  List<Object> get props => [];
}

class SavePreviousLocationEvent extends LocationSearchEvent {
  final Location location;

  SavePreviousLocationEvent({@required this.location}) : assert(location != null);

  @override
  List<Object> get props => [location];
}
