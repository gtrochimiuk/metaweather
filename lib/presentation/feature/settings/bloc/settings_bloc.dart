import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/data/model/settings/settings.dart';
import 'package:metaweather/domain/use_case/load_settings.dart';
import 'package:metaweather/domain/use_case/save_settings.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_event.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final LoadSettings loadSettings;
  final SaveSettings saveSettings;

  static SettingsState get initialState => const InitialSettingsState();

  SettingsBloc({
    @required this.loadSettings,
    @required this.saveSettings,
  })  : assert(loadSettings != null),
        assert(saveSettings != null),
        super(initialState);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is LoadSettingsEvent) {
      yield* _mapLoadSettings(event);
    } else if (event is SaveSettingsEvent) {
      yield* _mapSaveSettings(event);
    } else {
      throw UnsupportedError('Event $event is not supported');
    }
  }

  Stream<SettingsState> _mapLoadSettings(LoadSettingsEvent event) async* {
    final result = await loadSettings();
    yield* result.fold(
      onSuccess: (Settings settings) async* {
        yield LoadedSettingsState(settings);
      },
      onFailure: (Failure failure) async* {
        yield FailureSettingsState.fromState(
          failure: failure,
          state: state,
        );
      },
    );
  }

  Stream<SettingsState> _mapSaveSettings(SaveSettingsEvent event) async* {
    final result = await saveSettings(event.settings);
    yield* result.fold(
      onSuccess: (_) async* {
        yield LoadedSettingsState(event.settings);
      },
      onFailure: (Failure failure) async* {
        yield FailureSettingsState.fromState(
          failure: failure,
          state: state,
        );
      },
    );
  }
}
