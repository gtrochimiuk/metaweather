import 'package:metaweather/presentation/texts/app_texts.dart';

class UnlocalizedAppTexts extends AppTexts {
  @override
  String noInternetConnection() => 'No Internet connection found.';

  @override
  String unexpectedError() => 'An unexpected error occurred.';

  @override
  String location() => 'Location';

  @override
  String findYourLocation() => 'Find your location';

  @override
  String noLocationsFound() => 'No locations found';

  @override
  String tapToRetry() => 'Tap to retry.';

  @override
  String temperature(int value) => '$value°';

  @override
  String speedKmh(double value) => '$value km/h';

  @override
  String speedMph(double value) => '$value mph';

  @override
  String attributionInfo() => 'Weather data provided by MetaWeather.com';

  @override
  String today() => 'Today';

  @override
  String tomorrow() => 'Tomorrow';

  @override
  String yesterday() => 'Yesterday';

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
  String visibilityKilometers(double visibility) => '$visibility km';

  @override
  String visibilityMiles(double visibility) => '$visibility miles';

  @override
  String forecastCreated(String formattedDate) => 'Forecast created $formattedDate';

  @override
  String settings() => 'Settings';

  @override
  String theme() => 'Theme';

  @override
  String system() => 'System';

  @override
  String light() => 'Light';

  @override
  String dark() => 'Dark';

  @override
  String temperatureUnit() => 'Temperature';

  @override
  String celsius() => 'Celsius';

  @override
  String fahrenheit() => 'Fahrenheit';

  @override
  String lengthUnit() => 'Length';

  @override
  String mile() => 'Mile';

  @override
  String kilometer() => 'Kilometer';

  @override
  String appearance() => 'Appearance';

  @override
  String units() => 'Units';

  @override
  String previousLocations() => 'Previously selected';
}
