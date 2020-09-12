import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/network/request.dart';
import 'package:metaweather/common/result/result.dart';

abstract class NetworkService {
  Future<Result<T, Failure>> make<T>(Request<T> request);
}
