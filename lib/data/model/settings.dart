import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Settings extends Equatable {
  final ThemeMode themeMode;

  const Settings({@required this.themeMode}) : assert(themeMode != null);

  Settings copyWith({
    ThemeMode themeMode,
  }) =>
      Settings(
        themeMode: themeMode ?? this.themeMode,
      );

  const Settings.defaultSettings() : themeMode = ThemeMode.system;

  @override
  List<Object> get props => [themeMode];
}
