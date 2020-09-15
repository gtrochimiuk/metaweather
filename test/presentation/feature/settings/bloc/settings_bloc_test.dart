import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/failure_result.dart';
import 'package:metaweather/common/result/success_result.dart';
import 'package:metaweather/data/model/settings/length_unit.dart';
import 'package:metaweather/data/model/settings/settings.dart';
import 'package:metaweather/data/model/settings/temperature_unit.dart';
import 'package:metaweather/domain/use_case/load_settings.dart';
import 'package:metaweather/domain/use_case/save_settings.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_bloc.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_event.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_state.dart';
import 'package:mockito/mockito.dart';

class LoadSettingsMock extends Mock implements LoadSettings {}

class SaveSettingsMock extends Mock implements SaveSettings {}

SettingsBloc settingsBloc;

LoadSettings loadSettingsMock;
SaveSettings saveSettingsMock;

void main() {
  setUp(() {
    loadSettingsMock = LoadSettingsMock();
    saveSettingsMock = SaveSettingsMock();
    settingsBloc = SettingsBloc(
      loadSettings: loadSettingsMock,
      saveSettings: saveSettingsMock,
    );
  });

  test('Should contain default settings in initial state', () {
    expect(settingsBloc.state.settings, Settings.defaultSettings());
  });

  blocTest(
    'Should load settings and emit loaded state',
    build: () {
      _givenSettingsLoadSuccess();
      return settingsBloc;
    },
    act: (bloc) => bloc.add(LoadSettingsEvent()),
    expect: [
      LoadedSettingsState(_TestData.settings),
    ],
    verify: (_) {
      verify(loadSettingsMock.call()).called(1);
    },
  );
  blocTest(
    'Should load settings and emit failure state',
    build: () {
      _givenSettingsLoadFailure();
      return settingsBloc;
    },
    act: (bloc) => bloc.add(LoadSettingsEvent()),
    expect: [
      FailureSettingsState(
        failure: _TestData.failure,
        settings: Settings.defaultSettings(),
      ),
    ],
    verify: (_) {
      verify(loadSettingsMock.call()).called(1);
    },
  );

  blocTest(
    'Should save settings and emit loaded state',
    build: () {
      _givenSettingsSaveSuccess();
      return settingsBloc;
    },
    act: (bloc) => bloc.add(SaveSettingsEvent(settings: _TestData.settings)),
    expect: [
      LoadedSettingsState(_TestData.settings),
    ],
    verify: (_) {
      verify(saveSettingsMock.call(_TestData.settings)).called(1);
    },
  );

  blocTest(
    'Should save settings and emit failure state',
    build: () {
      _givenSettingsSaveFailure();
      return settingsBloc;
    },
    act: (bloc) => bloc.add(SaveSettingsEvent(settings: _TestData.settings)),
    expect: [
      FailureSettingsState(
        failure: _TestData.failure,
        settings: Settings.defaultSettings(),
      ),
    ],
    verify: (_) {
      verify(saveSettingsMock.call(_TestData.settings)).called(1);
    },
  );
}

void _givenSettingsLoadSuccess() {
  when(loadSettingsMock.call()).thenAnswer(
    (_) async => SuccessResult<Settings, Failure>(_TestData.settings),
  );
}

void _givenSettingsLoadFailure() {
  when(loadSettingsMock.call()).thenAnswer(
    (_) async => FailureResult<Settings, Failure>(_TestData.failure),
  );
}

void _givenSettingsSaveSuccess() {
  when(saveSettingsMock.call(_TestData.settings)).thenAnswer(
    (_) async => SuccessResult<Settings, Failure>(_TestData.settings),
  );
}

void _givenSettingsSaveFailure() {
  when(saveSettingsMock.call(_TestData.settings)).thenAnswer(
    (_) async => FailureResult<Settings, Failure>(_TestData.failure),
  );
}

abstract class _TestData {
  static final Failure failure = UnexpectedFailure();
  static const Settings settings = Settings(
    themeMode: ThemeMode.dark,
    temperatureUnit: TemperatureUnit.fahrenheit,
    lengthUnit: LengthUnit.mile,
  );
}
