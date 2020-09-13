import 'dart:math';

extension DoubleExtensions on double {
  double toRadians() => this * pi / 180.0;

  double roundAsFixed(int fractionDigits) {
    final roundFactor = pow(10, fractionDigits);
    return (this * roundFactor).toInt() / roundFactor;
  }
}
