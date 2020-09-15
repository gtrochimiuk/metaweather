import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/failure_result.dart';
import 'package:metaweather/common/result/success_result.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/domain/use_case/load_previous_locations.dart';
import 'package:metaweather/domain/use_case/save_previous_location.dart';
import 'package:metaweather/domain/use_case/search_location.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_bloc.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_event.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_state.dart';
import 'package:mockito/mockito.dart';

class SearchLocationMock extends Mock implements SearchLocation {}

class LoadPreviousLocationsMock extends Mock implements LoadPreviousLocations {}

class SavePreviousLocationsMock extends Mock implements SavePreviousLocation {}

LocationSearchBloc locationSearchBloc;

SearchLocation searchLocationMock;
LoadPreviousLocations loadPreviousLocationsMock;
SavePreviousLocation savePreviousLocationMock;

void main() {
  setUp(() {
    searchLocationMock = SearchLocationMock();
    loadPreviousLocationsMock = LoadPreviousLocationsMock();
    savePreviousLocationMock = SavePreviousLocationsMock();
    locationSearchBloc = LocationSearchBloc(
      searchLocation: searchLocationMock,
      loadPreviousLocations: loadPreviousLocationsMock,
      savePreviousLocation: savePreviousLocationMock,
    );
  });

  blocTest(
    'Should search location and emit loaded state',
    build: () {
      _givenLocationSearchSuccess();
      return locationSearchBloc;
    },
    act: (bloc) => bloc.add(PerformLocationSearchEvent(query: _TestData.query)),
    expect: [
      LoadingLocationSearchState(
        previouslySelectedLocations: [],
      ),
      LoadedLocationSearchState(
        previouslySelectedLocations: [],
        locations: _TestData.locations,
      ),
    ],
    verify: (_) {
      verify(searchLocationMock.call(_TestData.query)).called(1);
    },
  );
  blocTest(
    'Should and emit uninitialized state',
    build: () {
      return locationSearchBloc;
    },
    act: (bloc) => bloc.add(PerformLocationSearchEvent(query: _TestData.emptyQuery)),
    expect: [
      UninitializedLocationSearchState(
        previouslySelectedLocations: [],
      ),
    ],
    verify: (_) {
      verifyNever(searchLocationMock.call(_TestData.query));
    },
  );

  blocTest(
    'Should search location and emit failure state',
    build: () {
      _givenLocationSearchFailure();
      return locationSearchBloc;
    },
    act: (bloc) => bloc.add(PerformLocationSearchEvent(query: _TestData.query)),
    expect: [
      LoadingLocationSearchState(
        previouslySelectedLocations: [],
      ),
      FailureLocationSearchState(
        previouslySelectedLocations: [],
        failure: _TestData.failure,
      ),
    ],
    verify: (_) {
      verify(searchLocationMock.call(_TestData.query)).called(1);
    },
  );

  blocTest(
    'Should load previous locations and emit loaded state',
    build: () {
      _givenLoadPreviousLocationsSuccess();
      return locationSearchBloc;
    },
    act: (bloc) => bloc.add(LoadPreviousLocationsEvent()),
    expect: [
      LoadingLocationSearchState(
        previouslySelectedLocations: [],
      ),
      UninitializedLocationSearchState(
        previouslySelectedLocations: _TestData.previouslySelectedLocations,
      ),
    ],
    verify: (_) {
      verify(loadPreviousLocationsMock.call()).called(1);
    },
  );

  blocTest(
    'Should load previous locations and emit previous state',
    build: () {
      _givenLoadPreviousLocationsFailure();
      return locationSearchBloc;
    },
    act: (bloc) => bloc.add(LoadPreviousLocationsEvent()),
    expect: [
      LoadingLocationSearchState(
        previouslySelectedLocations: [],
      ),
      UninitializedLocationSearchState(
        previouslySelectedLocations: [],
      ),
    ],
    verify: (_) {
      verify(loadPreviousLocationsMock.call()).called(1);
    },
  );

  blocTest(
    'Should save previous location and emit previous state',
    build: () {
      _givenSavePreviousLocationSuccess();
      return locationSearchBloc;
    },
    act: (bloc) => bloc.add(SavePreviousLocationEvent(
      location: _TestData.locations[0],
    )),
    expect: [
      UninitializedLocationSearchState(
        previouslySelectedLocations: _TestData.previouslySelectedLocations,
      ),
    ],
    verify: (_) {
      verify(savePreviousLocationMock.call(_TestData.locations[0])).called(1);
    },
  );

  blocTest(
    'Should save previous location and  emit uninitialized state',
    build: () {
      _givenSavePreviousLocationFailure();
      return locationSearchBloc;
    },
    act: (bloc) => bloc.add(SavePreviousLocationEvent(
      location: _TestData.locations[0],
    )),
    expect: [
      UninitializedLocationSearchState(
        previouslySelectedLocations: [],
      )
    ],
    verify: (_) {
      verify(savePreviousLocationMock.call(_TestData.locations[0])).called(1);
    },
  );
}

void _givenLocationSearchSuccess() {
  when(searchLocationMock.call(_TestData.query)).thenAnswer(
    (_) async => SuccessResult<List<Location>, Failure>(_TestData.locations),
  );
}

void _givenLocationSearchFailure() {
  when(searchLocationMock.call(_TestData.query)).thenAnswer(
    (_) async => FailureResult<List<Location>, Failure>(_TestData.failure),
  );
}

void _givenLoadPreviousLocationsSuccess() {
  when(loadPreviousLocationsMock.call()).thenAnswer(
    (_) async => SuccessResult<List<Location>, Failure>(_TestData.previouslySelectedLocations),
  );
}

void _givenLoadPreviousLocationsFailure() {
  when(loadPreviousLocationsMock.call()).thenAnswer(
    (_) async => FailureResult<List<Location>, Failure>(_TestData.failure),
  );
}

void _givenSavePreviousLocationSuccess() {
  when(savePreviousLocationMock.call(_TestData.locations[0])).thenAnswer(
    (_) async => SuccessResult<List<Location>, Failure>(_TestData.previouslySelectedLocations),
  );
}

void _givenSavePreviousLocationFailure() {
  when(savePreviousLocationMock.call(_TestData.locations[0])).thenAnswer(
    (_) async => FailureResult<List<Location>, Failure>(_TestData.failure),
  );
}

abstract class _TestData {
  static const String query = 'query';
  static const String emptyQuery = '';
  static final Failure failure = UnexpectedFailure();
  static const List<Location> locations = [
    Location(id: 1, name: 'locationName1'),
    Location(id: 2, name: 'locationName2'),
  ];
  static final List<Location> previouslySelectedLocations = [
    Location(
      id: 3,
      name: 'locationName1',
      selectedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Location(
      id: 4,
      name: 'locationName2',
      selectedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];
}
