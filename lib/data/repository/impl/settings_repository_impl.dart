import 'package:flutter/material.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/failure_result.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/common/result/success_result.dart';
import 'package:metaweather/data/model/settings.dart';
import 'package:metaweather/data/repository/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  static const String _themeModeKey = 'themeMode';

  @override
  Future<Result<Settings, Failure>> loadSettings() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final settings = Settings.defaultSettings().copyWith(
        themeMode: _getThemeMode(sharedPreferences),
      );
      return SuccessResult(settings);
    } on Exception {
      return FailureResult(UnexpectedFailure());
    }
  }

  ThemeMode _getThemeMode(SharedPreferences sharedPreferences) {
    final themeModeString = sharedPreferences.getString(_themeModeKey);
    return ThemeMode.values.firstWhere((mode) => mode.toString() == themeModeString, orElse: () => null);
  }

  @override
  Future<Result<void, Failure>> saveSettings(Settings settings) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(_themeModeKey, settings.themeMode.toString());
      return SuccessResult(null);
    } on Exception {
      return FailureResult(UnexpectedFailure());
    }
  }
}
