import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/data/model/location.dart';

abstract class LocationSearchState extends Equatable {}

class LoadingLocationSearchState extends LocationSearchState {
  @override
  List<Object> get props => [];
}

class LoadedLocationSearchState extends LocationSearchState {
  final List<Location> locations;

  LoadedLocationSearchState({@required this.locations}) : assert(locations != null);

  @override
  List<Object> get props => [locations];
}

class FailureLocationSearchState extends LocationSearchState {
  final Failure failure;

  FailureLocationSearchState({@required this.failure}) : assert(failure != null);

  @override
  List<Object> get props => [failure];
}
