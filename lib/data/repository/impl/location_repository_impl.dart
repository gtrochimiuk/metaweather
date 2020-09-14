import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/network/network_service.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/data/repository/location_repository.dart';
import 'package:metaweather/domain/network/search_location_request.dart';

class LocationRepositoryImpl extends LocationRepository {
  final NetworkService networkService;

  LocationRepositoryImpl({@required this.networkService}) : assert(networkService != null);

  @override
  Future<Result<List<Location>, Failure>> searchLocation(String query) {
    final request = SearchLocationRequest(query);
    return networkService.make(request);
  }
}
