import 'package:metaweather/data/model/settings/settings_option.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

enum TemperatureUnit { celsius, fahrenheit }

extension TemperatureUnitExtensions on TemperatureUnit {
  String getName() {
    switch (this) {
      case TemperatureUnit.celsius:
        return AppTexts.current.celsius();
      case TemperatureUnit.fahrenheit:
        return AppTexts.current.fahrenheit();
    }
    throw UnsupportedError('Unit $this is not supported');
  }

  static List<SettingsOption<TemperatureUnit>> getSettingsOptions() => TemperatureUnit.values.map(
        (value) => SettingsOption(
          name: value.getName(),
          value: value,
        ),
      ).toList();
}
