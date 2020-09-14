import 'package:metaweather/common/dependency_injection/injector.dart';

abstract class AppTexts {
  static AppTexts get current => Injector.resolve();

  String noInternetConnection();

  String unexpectedError();

  String location();

  String findYourLocation();

  String noLocationsFound();

  String tapToRetry();

  String temperature(int value);

  String speed(double value);

  String attributionInfo();

  String today();

  String tomorrow();

  String yesterday();

  String humidity();

  String airPressure();

  String visibility();

  String wind();

  String airPressureHpa(double airPressure);

  String humidityPercent(int humidity);

  String visibilityMiles(double visibility);

  String forecastCreated(String formattedDate);
}
