import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/common/extensions/double_extensions.dart';
import 'package:metaweather/data/model/settings/length_unit.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

class Wind extends Equatable {
  final double speed;
  final double direction;

  const Wind({
    @required this.speed,
    @required this.direction,
  })  : assert(speed != null),
        assert(direction != null);

  Wind.fromJson(Map<String, dynamic> json)
      : speed = json['wind_speed'],
        direction = json['wind_direction'];

  @override
  List<Object> get props => [speed, direction];

  String formatSpeed(LengthUnit unit) {
    switch (unit) {
      case LengthUnit.kilometer:
        return AppTexts.current.speedKmh(speed.milesToKilometers().roundAsFixed(1));
      case LengthUnit.mile:
        return AppTexts.current.speedMph(speed.roundAsFixed(1));
    }
    throw UnsupportedError('Unit $unit is not supported');
  }
}
