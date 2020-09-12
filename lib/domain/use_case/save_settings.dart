import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/common/use_case/use_case.dart';
import 'package:metaweather/data/model/settings.dart';
import 'package:metaweather/data/repository/settings_repository.dart';

class SaveSettings extends UseCase<void, Settings> {
  final SettingsRepository settingsRepository;

  SaveSettings({@required this.settingsRepository}) : assert(settingsRepository != null);

  @override
  Future<Result<void, Failure>> call([Settings settings]) {
    return settingsRepository.saveSettings(settings);
  }
}
