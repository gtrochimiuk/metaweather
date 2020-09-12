import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/data/model/location.dart';
import 'package:metaweather/domain/use_case/search_location.dart';
import 'package:metaweather/presentation/location_search/bloc/location_search_event.dart';
import 'package:metaweather/presentation/location_search/bloc/location_search_state.dart';

class LocationSearchBloc extends Bloc<LocationSearchEvent, LocationSearchState> {
  final SearchLocation searchLocation;

  static LocationSearchState get initialState => LoadedLocationSearchState(locations: []);

  LocationSearchBloc({@required this.searchLocation})
      : assert(searchLocation != null),
        super(
          initialState,
        );

  @override
  Stream<LocationSearchState> mapEventToState(LocationSearchEvent event) async* {
    if (event is PerformLocationSearchEvent) {
      yield* _mapPerformLocationSearch(event);
    }
  }

  Stream<LocationSearchState> _mapPerformLocationSearch(PerformLocationSearchEvent event) async* {
    final result = await searchLocation(event.query);
    yield* result.fold(
      onSuccess: (List<Location> locations) async* {
        yield LoadedLocationSearchState(locations: locations);
      },
      onFailure: (Failure failure) async* {
        yield FailureLocationSearchState(failure: failure);
      },
    );
  }
}
