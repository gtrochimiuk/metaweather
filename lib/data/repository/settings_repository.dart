import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/data/model/settings/settings.dart';

abstract class SettingsRepository {
  Future<Result<Settings, Failure>> loadSettings();

  Future<Result<void, Failure>> saveSettings(Settings settings);
}
