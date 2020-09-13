import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/common/use_case/use_case.dart';
import 'package:metaweather/data/model/forecast.dart';
import 'package:metaweather/data/repository/forecast_repository.dart';

class LoadForecast extends UseCase<List<Forecast>, int> {
  final ForecastRepository forecastRepository;

  LoadForecast({@required this.forecastRepository}) : assert(forecastRepository != null);

  @override
  Future<Result<List<Forecast>, Failure>> call([int locationId]) {
    return forecastRepository.loadForecast(locationId);
  }
}
