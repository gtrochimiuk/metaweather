import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/common/use_case/use_case.dart';
import 'package:metaweather/data/model/settings/settings.dart';
import 'package:metaweather/data/repository/settings_repository.dart';

class LoadSettings extends UseCase<Settings, void> {
  final SettingsRepository settingsRepository;

  LoadSettings({@required this.settingsRepository}) : assert(settingsRepository != null);

  @override
  Future<Result<Settings, Failure>> call([_]) {
    return settingsRepository.loadSettings();
  }
}
