import 'package:equatable/equatable.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/data/model/weather/weather_state.dart';

class Forecast extends Equatable {
  final Location location;
  final DateTime createdAt;
  final DateTime date;
  final int predictability;
  final WeatherState weatherState;

  Forecast.fromJson(Map<String, dynamic> json)
      : location = Location.fromJson(json),
        createdAt = DateTime.tryParse(json['created']),
        date = DateTime.tryParse(json['applicable_date']),
        predictability = json['predictability'],
        weatherState = WeatherState.fromJson(json);

  @override
  List<Object> get props => [location, createdAt, date, predictability, weatherState];
}
