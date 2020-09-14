import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/data/model/settings/settings.dart';

abstract class SettingsState extends Equatable {
  final Settings settings;

  const SettingsState({@required this.settings}) : assert(settings != null);

  @override
  List<Object> get props => [settings];
}

class InitialSettingsState extends SettingsState {
  const InitialSettingsState() : super(settings: const Settings.defaultSettings());
}

class LoadedSettingsState extends SettingsState {
  const LoadedSettingsState(Settings settings) : super(settings: settings);
}

class FailureSettingsState extends SettingsState {
  final Failure failure;

  FailureSettingsState.fromState({
    @required this.failure,
    @required SettingsState state,
  }) : super(settings: state.settings);
}
