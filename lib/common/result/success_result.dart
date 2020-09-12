import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/result.dart';

class SuccessResult<S, F extends Failure> extends Result<S, F> {
  final S _value;

  SuccessResult(this._value);

  @override
  R fold<R>({R Function(S) onSuccess, R Function(F) onFailure}) => onSuccess?.call(_value) ?? this;

  @override
  bool operator ==(Object other) => other is SuccessResult && other._value == _value;

  @override
  int get hashCode => _value.hashCode;
}
