import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/domain/use_case/load_previous_locations.dart';
import 'package:metaweather/domain/use_case/save_previous_location.dart';
import 'package:metaweather/domain/use_case/search_location.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_event.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_state.dart';

class LocationSearchBloc extends Bloc<LocationSearchEvent, LocationSearchState> {
  final SearchLocation searchLocation;
  final LoadPreviousLocations loadPreviousLocations;
  final SavePreviousLocation savePreviousLocation;

  static LocationSearchState get initialState => UninitializedLocationSearchState(
        previouslySelectedLocations: [],
      );

  LocationSearchBloc({
    @required this.searchLocation,
    @required this.loadPreviousLocations,
    @required this.savePreviousLocation,
  })  : assert(searchLocation != null),
        assert(loadPreviousLocations != null),
        assert(savePreviousLocation != null),
        super(initialState);

  @override
  Stream<LocationSearchState> mapEventToState(LocationSearchEvent event) async* {
    if (event is PerformLocationSearchEvent) {
      yield* _mapPerformLocationSearch(event);
    } else if (event is LoadPreviousLocationsEvent) {
      yield* _mapLoadPreviousLocations(event);
    } else if (event is SavePreviousLocationEvent) {
      yield* _mapSavePreviousLocation(event);
    } else {
      throw UnsupportedError('Event $event is not supported');
    }
  }

  Stream<LocationSearchState> _mapPerformLocationSearch(PerformLocationSearchEvent event) async* {
    if (event.query.isNotEmpty) {
      yield LoadingLocationSearchState(
        previouslySelectedLocations: state.previouslySelectedLocations,
      );
      final result = await searchLocation(event.query);
      yield* result.fold(
        onSuccess: (List<Location> locations) async* {
          yield LoadedLocationSearchState(
            locations: locations,
            previouslySelectedLocations: state.previouslySelectedLocations,
          );
        },
        onFailure: (Failure failure) async* {
          yield FailureLocationSearchState(
            failure: failure,
            previouslySelectedLocations: state.previouslySelectedLocations,
          );
        },
      );
    } else {
      yield UninitializedLocationSearchState(
        previouslySelectedLocations: state.previouslySelectedLocations,
      );
    }
  }

  Stream<LocationSearchState> _mapLoadPreviousLocations(LoadPreviousLocationsEvent event) async* {
    final previousState = state;
    yield LoadingLocationSearchState(
      previouslySelectedLocations: state.previouslySelectedLocations,
    );
    final result = await loadPreviousLocations();
    yield* result.fold(
      onSuccess: (List<Location> locations) async* {
        _sortBySelectedAt(locations);
        yield previousState.copyWith(
          previouslySelectedLocations: locations,
        );
      },
      onFailure: (Failure failure) async* {
        yield previousState;
      },
    );
  }

  Stream<LocationSearchState> _mapSavePreviousLocation(SavePreviousLocationEvent event) async* {
    final result = await savePreviousLocation(event.location.copyWith(selectedAt: DateTime.now()));
    yield* result.fold(onSuccess: (List<Location> locations) async* {
      _sortBySelectedAt(locations);
      yield state.copyWith(
        previouslySelectedLocations: locations,
      );
    }, onFailure: (Failure failure) async* {
      yield state;
    });
  }

  void _sortBySelectedAt(List<Location> locations) {
    locations.sort((l1, l2) => l2.selectedAt.millisecondsSinceEpoch - l1.selectedAt.millisecondsSinceEpoch);
  }
}
