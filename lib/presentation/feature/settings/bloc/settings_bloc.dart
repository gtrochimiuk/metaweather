import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_event.dart';
import 'package:metaweather/presentation/feature/settings/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static SettingsState get initialState => const InitialSettingsState();

  SettingsBloc() : super(initialState);

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

  Stream<SettingsState> _mapLoadSettings(LoadSettingsEvent event) async* {}

  Stream<SettingsState> _mapSaveSettings(SaveSettingsEvent event) async* {}
}
