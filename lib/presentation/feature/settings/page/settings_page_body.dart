import 'package:flutter/material.dart';
import 'package:metaweather/data/model/settings/length_unit.dart';
import 'package:metaweather/data/model/settings/settings.dart';
import 'package:metaweather/data/model/settings/temperature_unit.dart';
import 'package:metaweather/data/model/settings/theme_mode.dart';
import 'package:metaweather/presentation/feature/settings/widgets/settings_expandable_item.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

class SettingsPageBody extends StatelessWidget {
  final Settings settings;

  final void Function({
    ThemeMode themeMode,
    TemperatureUnit temperatureUnit,
    LengthUnit lengthUnit,
  }) onSettingChanged;

  const SettingsPageBody({
    Key key,
    @required this.settings,
    @required this.onSettingChanged,
  })  : assert(settings != null),
        assert(onSettingChanged != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildThemeModeItem(context),
          _buildTemperatureUnitItem(context),
          _buildLengthUnitItem(context),
        ],
      ),
    );
  }

  Widget _buildThemeModeItem(BuildContext context) {
    final options = ThemeModeExtensions.getSettingsOptions();
    return SettingsExpandableItem(
      label: AppTexts.current.theme(),
      options: options,
      selectedOption: options.firstWhere((option) => option.value == settings.themeMode),
      onOptionSelected: (themeMode) => onSettingChanged(themeMode: themeMode),
    );
  }

  Widget _buildTemperatureUnitItem(BuildContext context) {
    final options = TemperatureUnitExtensions.getSettingsOptions();
    return SettingsExpandableItem(
      label: AppTexts.current.temperatureUnit(),
      options: options,
      selectedOption: options.firstWhere((option) => option.value == settings.temperatureUnit),
      onOptionSelected: (temperatureUnit) => onSettingChanged(temperatureUnit: temperatureUnit),
    );
  }

  Widget _buildLengthUnitItem(BuildContext context) {
    final options = LengthUnitExtensions.getSettingsOptions();
    return SettingsExpandableItem(
      label: AppTexts.current.lengthUnit(),
      options: options,
      selectedOption: options.firstWhere((option) => option.value == settings.lengthUnit),
      onOptionSelected: (lengthUnit) => onSettingChanged(lengthUnit: lengthUnit),
    );
  }
}
