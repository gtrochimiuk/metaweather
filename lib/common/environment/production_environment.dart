import 'package:metaweather/common/environment/environment.dart';

class ProductionEnvironment extends Environment {
  @override
  String get baseUrl => 'https://metaweather.com/api/';
}
