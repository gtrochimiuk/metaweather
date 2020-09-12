import 'package:equatable/equatable.dart';
import 'package:metaweather/data/model/temperature.dart';
import 'package:metaweather/data/model/wind.dart';

class WeatherState extends Equatable {
  final String name;
  final String abbreviation;
  final Temperature temperature;
  final Wind wind;
  final double airPressure;
  final double humidity;
  final double visibility;

  WeatherState.fromJson(Map<String, dynamic> json)
      : name = json['weather_state_name'],
        abbreviation = json['weather_state_abbr'],
        temperature = Temperature.fromJson(json),
        wind = Wind.fromJson(json),
        airPressure = json['air_pressure'],
        humidity = json['humidity'],
        visibility = json['visibility'];

  @override
  List<Object> get props => [name, abbreviation, temperature, wind, airPressure, humidity, visibility];
}
