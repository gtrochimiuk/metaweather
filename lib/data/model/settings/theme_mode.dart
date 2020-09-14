import 'package:flutter/material.dart';
import 'package:metaweather/data/model/settings/settings_option.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

extension ThemeModeExtensions on ThemeMode {
  String getName() {
    switch (this) {
      case ThemeMode.system:
        return AppTexts.current.system();
      case ThemeMode.dark:
        return AppTexts.current.dark();
      case ThemeMode.light:
        return AppTexts.current.light();
    }
    throw UnsupportedError('Theme mode $this is not supported');
  }

  static List<SettingsOption<ThemeMode>> getSettingsOptions() => ThemeMode.values.map(
        (value) => SettingsOption(
          name: value.getName(),
          value: value,
        ),
      ).toList();
}
