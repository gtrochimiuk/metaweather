import 'package:metaweather/common/failure/failure.dart';

import 'result.dart';

class FailureResult<S, F extends Failure> extends Result<S, F> {
  final F _value;

  FailureResult(this._value);

  @override
  R fold<R>({R Function(S) onSuccess, R Function(F) onFailure}) => onFailure?.call(_value) ?? this;

  @override
  bool operator ==(Object other) => other is FailureResult && other._value == _value;

  @override
  int get hashCode => _value.hashCode;
}
