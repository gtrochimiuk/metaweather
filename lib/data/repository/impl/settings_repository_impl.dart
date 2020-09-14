import 'package:flutter/material.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/failure_result.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/common/result/success_result.dart';
import 'package:metaweather/data/model/settings/length_unit.dart';
import 'package:metaweather/data/model/settings/settings.dart';
import 'package:metaweather/data/model/settings/temperature_unit.dart';
import 'package:metaweather/data/repository/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  static const String _themeModeKey = 'themeMode';
  static const String _temperatureUnitKey = 'temperatureUnit';
  static const String _lengthUnitKey = 'lengthUnit';

  @override
  Future<Result<Settings, Failure>> loadSettings() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final settings = Settings.defaultSettings().copyWith(
        themeMode: _getEnumValue(
          values: ThemeMode.values,
          string: sharedPreferences.getString(_themeModeKey),
        ),
        temperatureUnit: _getEnumValue(
          values: TemperatureUnit.values,
          string: sharedPreferences.getString(_temperatureUnitKey),
        ),
        lengthUnit: _getEnumValue(
          values: LengthUnit.values,
          string: sharedPreferences.getString(_lengthUnitKey),
        ),
      );
      return SuccessResult(settings);
    } on Exception {
      return FailureResult(UnexpectedFailure());
    }
  }

  T _getEnumValue<T>({List<T> values, String string}) {
    return values.firstWhere(
      (value) => value.toString() == string,
      orElse: () => null,
    );
  }

  @override
  Future<Result<void, Failure>> saveSettings(Settings settings) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(_themeModeKey, settings.themeMode.toString());
      sharedPreferences.setString(_temperatureUnitKey, settings.temperatureUnit.toString());
      sharedPreferences.setString(_lengthUnitKey, settings.lengthUnit.toString());
      return SuccessResult(null);
    } on Exception {
      return FailureResult(UnexpectedFailure());
    }
  }
}
