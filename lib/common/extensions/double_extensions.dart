import 'dart:math';

extension DoubleExtensions on double {
  double degreesToRadians() => this * pi / 180.0;

  double milesToKilometers() => this * 1.609344;

  double celsiusToFahrenheit() => this * 1.8 + 32;

  double roundAsFixed(int fractionDigits) {
    final roundFactor = pow(10, fractionDigits);
    return (this * roundFactor).toInt() / roundFactor;
  }
}
