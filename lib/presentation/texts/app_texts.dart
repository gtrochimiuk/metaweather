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

  String speedKmh(double value);

  String speedMph(double value);

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

  String visibilityKilometers(double visibility);

  String visibilityMiles(double visibility);

  String forecastCreated(String formattedDate);

  String settings();

  String theme();

  String system();

  String light();

  String dark();

  String temperatureUnit();

  String celsius();

  String fahrenheit();

  String lengthUnit();

  String mile();

  String kilometer();

  String appearance();

  String units();

  String previousLocations();
}
