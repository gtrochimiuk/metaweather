import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:metaweather/common/environment/environment.dart';
import 'package:metaweather/common/network/dio_network_service.dart';
import 'package:metaweather/common/network/network_service.dart';
import 'package:metaweather/common/texts/app_texts.dart';
import 'package:metaweather/common/texts/unlocalized_app_texts.dart';
import 'package:metaweather/data/repository/forecast_repository.dart';
import 'package:metaweather/data/repository/impl/forecast_repository_imlp.dart';
import 'package:metaweather/data/repository/impl/location_repository_impl.dart';
import 'package:metaweather/data/repository/location_repository.dart';
import 'package:metaweather/domain/use_case/load_forecast.dart';
import 'package:metaweather/domain/use_case/search_location.dart';

abstract class Injector {
  static KiwiContainer _container;

  static T Function<T>([String name]) get resolve => _container.resolve;

  static void setUp() {
    // Use cases
    _container.registerSingleton(
      (c) => SearchLocation(
        locationRepository: c.resolve(),
      ),
    );
    _container.registerSingleton(
      (c) => LoadForecast(
        forecastRepository: c.resolve(),
      ),
    );

    // Repositories
    _container.registerSingleton<ForecastRepository>(
      (c) => ForecastRepositoryImpl(
        networkService: c.resolve(),
      ),
    );
    _container.registerSingleton<LocationRepository>(
      (c) => LocationRepositoryImpl(
        networkService: c.resolve(),
      ),
    );

    // Network
    _container.registerSingleton(
      (c) => Dio(BaseOptions(
        baseUrl: Environment.current.baseUrl,
      )),
    );
    _container.registerSingleton<NetworkService>(
      (c) => DioNetworkService(
        dio: c.resolve(),
      ),
    );

    // Texts
    _container.registerSingleton<AppTexts>(
      (c) => UnlocalizedAppTexts(),
    );
  }
}
