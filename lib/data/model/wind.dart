import 'package:equatable/equatable.dart';

class Wind extends Equatable {
  final double speed;
  final double direction;

  Wind.fromJson(Map<String, dynamic> json)
      : speed = json['wind_speed'],
        direction = json['wind_direction'];

  @override
  List<Object> get props => [speed, direction];
}
