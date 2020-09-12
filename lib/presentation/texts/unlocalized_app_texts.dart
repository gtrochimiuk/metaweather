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
}
