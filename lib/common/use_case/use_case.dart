import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/result.dart';

abstract class UseCase<T, P> {
  Future<Result<T, Failure>> call(P parameters);
}
