import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/data/model/location/location.dart';

abstract class LocationSearchState extends Equatable {
  final List<Location> previouslySelectedLocations;

  const LocationSearchState({
    @required this.previouslySelectedLocations,
  }) : assert(previouslySelectedLocations != null);

  LocationSearchState copyWith({
    List<Location> previouslySelectedLocations,
  });

  @override
  List<Object> get props => [previouslySelectedLocations];
}

class UninitializedLocationSearchState extends LocationSearchState {
  const UninitializedLocationSearchState({
    @required List<Location> previouslySelectedLocations,
  }) : super(previouslySelectedLocations: previouslySelectedLocations);

  @override
  LocationSearchState copyWith({
    List<Location> previouslySelectedLocations,
  }) =>
      UninitializedLocationSearchState(
        previouslySelectedLocations: previouslySelectedLocations,
      );
}

class LoadingLocationSearchState extends LocationSearchState {
  const LoadingLocationSearchState({
    @required List<Location> previouslySelectedLocations,
  }) : super(previouslySelectedLocations: previouslySelectedLocations);

  @override
  LocationSearchState copyWith({
    List<Location> previouslySelectedLocations,
  }) =>
      LoadingLocationSearchState(
        previouslySelectedLocations: previouslySelectedLocations,
      );
}

class LoadedLocationSearchState extends LocationSearchState {
  final List<Location> locations;

  LoadedLocationSearchState({
    @required this.locations,
    @required List<Location> previouslySelectedLocations,
  })  : assert(locations != null),
        super(previouslySelectedLocations: previouslySelectedLocations);

  @override
  LocationSearchState copyWith({
    List<Location> previouslySelectedLocations,
  }) =>
      LoadedLocationSearchState(
        previouslySelectedLocations: previouslySelectedLocations,
        locations: locations,
      );

  @override
  List<Object> get props => [...super.props, locations];
}

class FailureLocationSearchState extends LocationSearchState {
  final Failure failure;

  FailureLocationSearchState({
    @required this.failure,
    @required List<Location> previouslySelectedLocations,
  })  : assert(failure != null),
        super(previouslySelectedLocations: previouslySelectedLocations);

  @override
  LocationSearchState copyWith({
    List<Location> previouslySelectedLocations,
  }) =>
      FailureLocationSearchState(
        previouslySelectedLocations: previouslySelectedLocations,
        failure: failure,
      );

  @override
  List<Object> get props => [...super.props, failure];
}
