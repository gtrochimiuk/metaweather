import 'package:metaweather/presentation/texts/app_texts.dart';

class UnlocalizedAppTexts extends AppTexts {
  @override
  String noInternetConnection() => 'No Internet connection found';

  @override
  String unexpectedError() => 'An unexpected error occurred';

  @override
  String location() => 'Location';

  @override
  String findYourLocation() => 'Find your location';

  @override
  String noLocationsFound() => 'Sorry, we didn\'t find the location you are looking for';

  @override
  String tapToRetry() => 'Tap to retry';

  @override
  String temperature(int value) => '$value°';

  @override
  String speed(double value) => '$value mph';

  @override
  String attributionInfo() => 'Weather data provided by MetaWeather.com';

  @override
  String today() => 'Today';

  @override
  String tomorrow() => 'Tomorrow';

  @override
  String humidity() => 'Humidity';

  @override
  String airPressure() => 'Air pressure';

  @override
  String wind() => 'Wind';

  @override
  String visibility() => 'Visibility';

  @override
  String airPressureHpa(double airPressure) => '$airPressure hPa';

  @override
  String humidityPercent(int humidity) => '$humidity%';

  @override
  String visibilityMiles(double visibility) => '$visibility miles';
}
