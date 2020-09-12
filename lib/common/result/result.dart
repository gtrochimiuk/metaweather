import 'package:metaweather/common/failure/failure.dart';

abstract class Result<S, F extends Failure> {
  R fold<R>({R Function(S) onSuccess, R Function(F) onFailure});
}
