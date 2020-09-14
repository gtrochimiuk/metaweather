import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/dependency_injection/injector.dart';
import 'package:metaweather/data/model/settings/length_unit.dart';
import 'package:metaweather/data/model/settings/temperature_unit.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_bloc.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_event.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_state.dart';
import 'package:metaweather/presentation/feature/settings/page/settings_page_body.dart';
import 'package:metaweather/presentation/feature/settings/widgets/settings_app_bar.dart';

class SettingsPage extends StatefulWidget {
  static PageRoute pageRoute() => MaterialPageRoute(
        builder: (context) => SettingsPage(),
      );

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsBloc get settingsBloc => Injector.resolve();

  void _onSettingChanged({
    ThemeMode themeMode,
    TemperatureUnit temperatureUnit,
    LengthUnit lengthUnit,
  }) {
    final oldSettings = settingsBloc.state.settings;
    final newSettings = oldSettings.copyWith(
      themeMode: themeMode,
      temperatureUnit: temperatureUnit,
      lengthUnit: lengthUnit,
    );
    settingsBloc.add(SaveSettingsEvent(settings: newSettings));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildAppBar() {
    return SettingsAppBar();
  }

  Widget _buildContent() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      cubit: settingsBloc,
      builder: (context, state) {
        return _buildPageBody(state);
      },
    );
  }

  Widget _buildPageBody(SettingsState state) {
    return SettingsPageBody(
      settings: state.settings,
      onSettingChanged: _onSettingChanged,
    );
  }
}
