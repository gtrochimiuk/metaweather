import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/failure_result.dart';
import 'package:metaweather/common/result/success_result.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/domain/use_case/search_location.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_bloc.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_event.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_state.dart';
import 'package:mockito/mockito.dart';

class SearchLocationMock extends Mock implements SearchLocation {}

LocationSearchBloc locationSearchBloc;

SearchLocation searchLocationMock;

void main() {
  setUp(() {
    searchLocationMock = SearchLocationMock();
    locationSearchBloc = LocationSearchBloc(searchLocation: searchLocationMock);
  });

  blocTest(
    'Should search location and emit loaded state',
    build: () {
      _givenLocationSearchSuccess();
      return locationSearchBloc;
    },
    act: (bloc) => bloc.add(PerformLocationSearchEvent(query: _TestData.query)),
    expect: [
      LoadingLocationSearchState(),
      LoadedLocationSearchState(locations: _TestData.locations),
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
      UninitializedLocationSearchState(),
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
      LoadingLocationSearchState(),
      FailureLocationSearchState(failure: _TestData.failure),
    ],
    verify: (_) {
      verify(searchLocationMock.call(_TestData.query)).called(1);
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

abstract class _TestData {
  static const String query = 'query';
  static const String emptyQuery = '';
  static final Failure failure = UnexpectedFailure();
  static const List<Location> locations = [
    Location(id: 1, name: 'locationName1'),
    Location(id: 2, name: 'locationName2'),
  ];
}
