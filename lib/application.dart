import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/dependency_injection/injector.dart';
import 'package:metaweather/presentation/feature/location_search/page/location_search_page.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_bloc.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_event.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_state.dart';
import 'package:metaweather/presentation/style/app_theme_data.dart';

class Application extends StatefulWidget {
  static const appName = 'MetaWeather';

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final SettingsBloc settingsBloc = Injector.resolve();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    settingsBloc.add(LoadSettingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      cubit: settingsBloc,
      builder: _settingsBlocBuilder,
    );
  }

  Widget _settingsBlocBuilder(BuildContext context, SettingsState state) {
    return MaterialApp(
      title: Application.appName,
      themeMode: state.settings.themeMode,
      theme: AppThemeData.light,
      darkTheme: AppThemeData.dark,
      home: LocationSearchPage(),
    );
  }

  @override
  void dispose() {
    settingsBloc.close();
    super.dispose();
  }
}
