import 'package:equatable/equatable.dart';
import 'package:metaweather/common/extensions/double_extensions.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

class Wind extends Equatable {
  final double speed;
  final double direction;

  Wind.fromJson(Map<String, dynamic> json)
      : speed = json['wind_speed'],
        direction = json['wind_direction'];

  @override
  List<Object> get props => [speed, direction];

  String formatSpeed() => AppTexts.current.speed(speed.roundAsFixed(1));
}
