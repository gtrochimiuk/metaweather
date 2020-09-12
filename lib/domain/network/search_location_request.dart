import 'package:metaweather/common/network/request.dart';
import 'package:metaweather/data/model/location.dart';

class SearchLocationRequest extends Request<List<Location>> {
  SearchLocationRequest(String query)
      : super(
          path: 'location/search',
          queryParameters: {'query': query},
        );

  @override
  List<Location> createResponse(dynamic json) => json.map<Location>((location) => Location.fromJson(location)).toList();
}
