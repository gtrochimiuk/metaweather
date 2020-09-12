import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/data/model/forecast.dart';
import 'package:metaweather/domain/use_case/load_forecast.dart';
import 'package:metaweather/presentation/forecast/bloc/forecast_event.dart';
import 'package:metaweather/presentation/forecast/bloc/forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final LoadForecast loadForecast;

  static ForecastState get initialState => LoadingForecastState();

  ForecastBloc({@required this.loadForecast})
      : assert(loadForecast != null),
        super(initialState);

  @override
  Stream<ForecastState> mapEventToState(ForecastEvent event) async* {
    if (event is LoadForecastEvent) {
      yield* _mapLoadForecast(event);
    }
    throw UnsupportedError('Event $event is not supported');
  }

  Stream<ForecastState> _mapLoadForecast(LoadForecastEvent event) async* {
    yield LoadingForecastState();
    final result = await loadForecast(event.locationId);
    yield* result.fold(
      onSuccess: (Forecast forecast) async* {
        yield LoadedForecastState(forecast: forecast);
      },
      onFailure: (Failure failure) async* {
        yield FailureForecastState(failure: failure);
      },
    );
  }
}
