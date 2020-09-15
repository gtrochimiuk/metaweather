import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/common/use_case/use_case.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/data/repository/location_repository.dart';

class LoadPreviousLocations extends UseCase<List<Location>, void> {
  final LocationRepository locationRepository;

  LoadPreviousLocations({@required this.locationRepository}) : assert(locationRepository != null);

  @override
  Future<Result<List<Location>, Failure>> call([_]) {
    return locationRepository.getPreviouslySelected();
  }
}
