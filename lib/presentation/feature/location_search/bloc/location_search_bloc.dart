import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/domain/use_case/search_location.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_event.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_state.dart';

class LocationSearchBloc extends Bloc<LocationSearchEvent, LocationSearchState> {
  final SearchLocation searchLocation;

  static LocationSearchState get initialState => UninitializedLocationSearchState();

  LocationSearchBloc({@required this.searchLocation})
      : assert(searchLocation != null),
        super(
          initialState,
        );

  @override
  Stream<LocationSearchState> mapEventToState(LocationSearchEvent event) async* {
    if (event is PerformLocationSearchEvent) {
      yield* _mapPerformLocationSearch(event);
    } else {
      throw UnsupportedError('Event $event is not supported');
    }
  }

  Stream<LocationSearchState> _mapPerformLocationSearch(PerformLocationSearchEvent event) async* {
    if (event.query.isNotEmpty) {
      yield LoadingLocationSearchState();
      final result = await searchLocation(event.query);
      yield* result.fold(
        onSuccess: (List<Location> locations) async* {
          yield LoadedLocationSearchState(locations: locations);
        },
        onFailure: (Failure failure) async* {
          yield FailureLocationSearchState(failure: failure);
        },
      );
    } else {
      yield UninitializedLocationSearchState();
    }
  }
}
