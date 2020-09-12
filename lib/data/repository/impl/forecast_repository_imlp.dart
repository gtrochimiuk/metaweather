import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/network/network_service.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/data/model/forecast.dart';
import 'package:metaweather/data/repository/forecast_repository.dart';
import 'package:metaweather/domain/network/forecast_request.dart';

class ForecastRepositoryImpl extends ForecastRepository {
  final NetworkService networkService;

  ForecastRepositoryImpl({@required this.networkService}) : assert(networkService != null);

  @override
  Future<Result<Forecast, Failure>> loadForecast(String locationId) {
    final request = ForecastRequest(locationId);
    return networkService.make(request);
  }
}
