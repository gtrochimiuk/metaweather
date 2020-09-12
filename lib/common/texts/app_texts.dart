import 'package:metaweather/common/dependency_injection/injector.dart';

abstract class AppTexts {
  static AppTexts get current => Injector.resolve();

  String noInternetConnection();

  String unexpectedError();
}
