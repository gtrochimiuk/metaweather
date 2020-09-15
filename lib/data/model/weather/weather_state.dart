import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/common/environment/environment.dart';
import 'package:metaweather/common/extensions/double_extensions.dart';
import 'package:metaweather/data/model/settings/length_unit.dart';
import 'package:metaweather/data/model/weather/temperature.dart';
import 'package:metaweather/data/model/weather/wind.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

class WeatherState extends Equatable {
  final String name;
  final String imageUrl;
  final Temperature temperature;
  final Wind wind;
  final double airPressure;
  final int humidity;
  final double visibility;

  const WeatherState({
    @required this.name,
    @required this.imageUrl,
    @required this.temperature,
    @required this.wind,
    @required this.airPressure,
    @required this.humidity,
    @required this.visibility,
  })  : assert(name != null),
        assert(imageUrl != null),
        assert(temperature != null),
        assert(wind != null),
        assert(airPressure != null),
        assert(humidity != null),
        assert(visibility != null);

  WeatherState.fromJson(Map<String, dynamic> json)
      : name = json['weather_state_name'],
        imageUrl = Environment.current.baseUrl + '/static/img/weather/${json['weather_state_abbr']}.svg',
        temperature = Temperature.fromJson(json),
        wind = Wind.fromJson(json),
        airPressure = json['air_pressure'],
        humidity = json['humidity'],
        visibility = json['visibility'];

  @override
  List<Object> get props => [name, imageUrl, temperature, wind, airPressure, humidity, visibility];

  String formatAirPressure() => AppTexts.current.airPressureHpa(airPressure);

  String formatHumidity() => AppTexts.current.humidityPercent(humidity);

  String formatVisibility(LengthUnit unit) {
    switch (unit) {
      case LengthUnit.kilometer:
        return AppTexts.current.visibilityKilometers(visibility.milesToKilometers().roundAsFixed(1));
      case LengthUnit.mile:
        return AppTexts.current.visibilityMiles(visibility.roundAsFixed(1));
    }
    throw UnsupportedError('Unit $unit is not supported');
  }
}
