import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/data/model/forecast.dart';

abstract class ForecastRepository {
  Future<Result<Forecast, Failure>> loadForecast(int locationId);
}
