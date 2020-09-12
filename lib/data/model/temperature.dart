import 'package:equatable/equatable.dart';

class Temperature extends Equatable {
  final double current;
  final double min;
  final double max;

  Temperature.fromJson(Map<String, dynamic> json)
      : current = json['the_temp'],
        min = json['min_temp'],
        max = json['max_temp'];

  @override
  List<Object> get props => [current, min, max];
}
