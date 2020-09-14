import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:metaweather/data/model/settings/length_unit.dart';
import 'package:metaweather/data/model/settings/temperature_unit.dart';

class Settings extends Equatable {
  final ThemeMode themeMode;
  final TemperatureUnit temperatureUnit;
  final LengthUnit lengthUnit;

  const Settings({
    @required this.themeMode,
    @required this.temperatureUnit,
    @required this.lengthUnit,
  })  : assert(themeMode != null),
        assert(temperatureUnit != null),
        assert(lengthUnit != null);

  Settings copyWith({
    ThemeMode themeMode,
    TemperatureUnit temperatureUnit,
    LengthUnit lengthUnit,
  }) =>
      Settings(
        themeMode: themeMode ?? this.themeMode,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        lengthUnit: lengthUnit ?? this.lengthUnit,
      );

  const Settings.defaultSettings()
      : themeMode = ThemeMode.system,
        temperatureUnit = TemperatureUnit.celsius,
        lengthUnit = LengthUnit.kilometer;

  @override
  List<Object> get props => [themeMode, temperatureUnit, lengthUnit];
}
