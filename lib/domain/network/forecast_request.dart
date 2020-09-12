import 'package:metaweather/common/network/request.dart';
import 'package:metaweather/data/model/forecast.dart';

class ForecastRequest extends Request<Forecast> {
  ForecastRequest(int locationId) : super(path: 'location/$locationId');

  @override
  Forecast createResponse(dynamic json) => Forecast.fromJson(json);
}
