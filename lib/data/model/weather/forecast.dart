import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/data/model/weather/weather_state.dart';

class Forecast extends Equatable {
  final Location location;
  final DateTime createdAt;
  final DateTime date;
  final int predictability;
  final WeatherState weatherState;

  const Forecast({
    @required this.location,
    @required this.createdAt,
    @required this.date,
    @required this.predictability,
    @required this.weatherState,
  })  : assert(location != null),
        assert(createdAt != null),
        assert(date != null),
        assert(predictability != null),
        assert(weatherState != null);

  Forecast.fromJson(Map<String, dynamic> json)
      : location = Location.fromJson(json),
        createdAt = DateTime.tryParse(json['created']),
        date = DateTime.tryParse(json['applicable_date']),
        predictability = json['predictability'],
        weatherState = WeatherState.fromJson(json);

  @override
  List<Object> get props => [location, createdAt, date, predictability, weatherState];
}
