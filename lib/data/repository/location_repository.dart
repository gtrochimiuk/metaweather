import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/data/model/location.dart';

abstract class LocationRepository {
  Future<Result<List<Location>, Failure>> searchLocation(String query);
}
