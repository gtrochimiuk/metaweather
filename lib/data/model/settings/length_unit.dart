import 'package:metaweather/data/model/settings/settings_option.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

enum LengthUnit { kilometer, mile }

extension LengthUnitExtensions on LengthUnit {
  String getName() {
    switch (this) {
      case LengthUnit.mile:
        return AppTexts.current.mile();
      case LengthUnit.kilometer:
        return AppTexts.current.kilometer();
    }
    throw UnsupportedError('Unit $this is not supported');
  }

  static List<SettingsOption<LengthUnit>> getSettingsOptions() => LengthUnit.values
      .map(
        (value) => SettingsOption(
          name: value.getName(),
          value: value,
        ),
      )
      .toList();
}
