import 'package:metaweather/common/network/request.dart';
import 'package:metaweather/data/model/weather/forecast.dart';

class ForecastRequest extends Request<List<Forecast>> {
  ForecastRequest(int locationId) : super(path: 'api/location/$locationId');

  @override
  List<Forecast> createResponse(dynamic json) => json['consolidated_weather']
      .map<Forecast>(
        (forecast) => Forecast.fromJson(forecast),
      )
      .toList();
}
