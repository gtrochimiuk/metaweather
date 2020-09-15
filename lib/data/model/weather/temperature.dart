import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/common/extensions/double_extensions.dart';
import 'package:metaweather/data/model/settings/temperature_unit.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

class Temperature extends Equatable {
  final double current;
  final double min;
  final double max;

  const Temperature({
    @required this.current,
    @required this.min,
    @required this.max,
  })  : assert(current != null),
        assert(min != null),
        assert(max != null);

  Temperature.fromJson(Map<String, dynamic> json)
      : current = json['the_temp'],
        min = json['min_temp'],
        max = json['max_temp'];

  @override
  List<Object> get props => [current, min, max];

  String _format(double value, TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.celsius:
        return AppTexts.current.temperature(value.round());
      case TemperatureUnit.fahrenheit:
        return AppTexts.current.temperature(value.celsiusToFahrenheit().round());
    }
    throw UnsupportedError('Unit $unit is not supported');
  }

  String formatCurrent(TemperatureUnit unit) => _format(current, unit);

  String formatMin(TemperatureUnit unit) => _format(min, unit);

  String formatMax(TemperatureUnit unit) => _format(max, unit);
}
