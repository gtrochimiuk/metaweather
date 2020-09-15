import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/common/use_case/use_case.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/data/repository/location_repository.dart';

class SavePreviousLocation extends UseCase<List<Location>, Location> {
  final LocationRepository locationRepository;

  SavePreviousLocation({@required this.locationRepository}) : assert(locationRepository != null);

  @override
  Future<Result<List<Location>, Failure>> call([Location location]) {
    return locationRepository.savePreviouslySelected(location);
  }
}
