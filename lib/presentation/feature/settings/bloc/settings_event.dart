import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/data/model/settings/settings.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {}

class SaveSettingsEvent extends SettingsEvent {
  final Settings settings;

  SaveSettingsEvent({@required this.settings}) : assert(settings != null);

  @override
  List<Object> get props => [settings];
}
