import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/failure_result.dart';
import 'package:metaweather/common/result/success_result.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/data/model/weather/forecast.dart';
import 'package:metaweather/data/model/weather/temperature.dart';
import 'package:metaweather/data/model/weather/weather_state.dart';
import 'package:metaweather/data/model/weather/wind.dart';
import 'package:metaweather/domain/use_case/load_forecast.dart';
import 'package:metaweather/presentation/feature/forecast/bloc/forecast_bloc.dart';
import 'package:metaweather/presentation/feature/forecast/bloc/forecast_event.dart';
import 'package:metaweather/presentation/feature/forecast/bloc/forecast_state.dart';
import 'package:mockito/mockito.dart';

class LoadForecastMock extends Mock implements LoadForecast {}

ForecastBloc forecastBloc;

LoadForecast loadForecastMock;

void main() {
  setUp(() {
    loadForecastMock = LoadForecastMock();
    forecastBloc = ForecastBloc(loadForecast: loadForecastMock);
  });

  blocTest(
    'Should load forecast and emit loaded state',
    build: () {
      _givenLoadForecastSuccess();
      return forecastBloc;
    },
    act: (bloc) => bloc.add(LoadForecastEvent(locationId: _TestData.locationId1)),
    expect: [
      LoadingForecastState(),
      LoadedForecastState(
        forecasts: _TestData.forecasts,
        selectedForecast: _TestData.forecasts.first,
      ),
    ],
    verify: (_) {
      verify(loadForecastMock.call(_TestData.locationId1)).called(1);
    },
  );

  blocTest(
    'Should load forecast and emit failure state',
    build: () {
      _givenLoadForecastFailure();
      return forecastBloc;
    },
    act: (bloc) => bloc.add(LoadForecastEvent(locationId: _TestData.locationId1)),
    expect: [
      LoadingForecastState(),
      FailureForecastState(failure: _TestData.failure),
    ],
    verify: (_) {
      verify(loadForecastMock.call(_TestData.locationId1)).called(1);
    },
  );

  blocTest(
    'Should select forecast and emit loaded state',
    build: () {
      _givenLoadForecastSuccess();
      return forecastBloc;
    },
    act: (bloc) => bloc
      ..add(LoadForecastEvent(locationId: _TestData.locationId1))
      ..add(SelectForecastEvent(forecast: _TestData.forecasts[1])),
    expect: [
      LoadingForecastState(),
      LoadedForecastState(
        forecasts: _TestData.forecasts,
        selectedForecast: _TestData.forecasts.first,
      ),
      LoadedForecastState(
        forecasts: _TestData.forecasts,
        selectedForecast: _TestData.forecasts[1],
      )
    ],
    verify: (_) {
      verify(loadForecastMock.call(_TestData.locationId1)).called(1);
    },
  );
}

void _givenLoadForecastSuccess() {
  when(loadForecastMock.call(_TestData.locationId1)).thenAnswer(
    (_) async => SuccessResult<List<Forecast>, Failure>(_TestData.forecasts),
  );
}

void _givenLoadForecastFailure() {
  when(loadForecastMock.call(_TestData.locationId1)).thenAnswer(
    (_) async => FailureResult<List<Forecast>, Failure>(_TestData.failure),
  );
}

abstract class _TestData {
  static const int locationId1 = 1;
  static const int locationId2 = 2;
  static final Failure failure = UnexpectedFailure();
  static final List<Forecast> forecasts = [
    Forecast(
      date: DateTime.now(),
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      location: Location(
        id: locationId1,
        name: 'locationName1',
      ),
      predictability: 55,
      weatherState: WeatherState(
        name: 'stateName1',
        imageUrl: 'imageUrl1',
        temperature: Temperature(
          current: 20,
          min: 12,
          max: 24,
        ),
        wind: Wind(speed: 8.3, direction: 234.7),
        airPressure: 1024.5,
        humidity: 78,
        visibility: 12.4,
      ),
    ),
    Forecast(
      date: DateTime.now(),
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      location: Location(
        id: locationId2,
        name: 'locationName1',
      ),
      predictability: 50,
      weatherState: WeatherState(
        name: 'stateName1',
        imageUrl: 'imageUrl1',
        temperature: Temperature(
          current: 21,
          min: 13,
          max: 25,
        ),
        wind: Wind(speed: 8.2, direction: 234.6),
        airPressure: 1024.1,
        humidity: 71,
        visibility: 12.1,
      ),
    ),
  ];
}
