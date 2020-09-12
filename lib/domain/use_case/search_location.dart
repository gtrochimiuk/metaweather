import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/common/use_case/use_case.dart';
import 'package:metaweather/data/model/location.dart';
import 'package:metaweather/data/repository/location_repository.dart';

class SearchLocation extends UseCase<List<Location>, String> {
  final LocationRepository locationRepository;

  SearchLocation({@required this.locationRepository}) : assert(locationRepository != null);

  @override
  Future<Result<List<Location>, Failure>> call([String query]) {
    return locationRepository.searchLocation(query);
  }
}
