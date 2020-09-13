import 'package:equatable/equatable.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

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

  String _format(double value) => AppTexts.current.temperature(value.round());

  String formatCurrent() => _format(current);

  String formatMin() => _format(min);

  String formatMax() => _format(max);
}
