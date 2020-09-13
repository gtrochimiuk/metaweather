import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/dependency_injection/injector.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/data/model/forecast.dart';
import 'package:metaweather/data/model/location.dart';
import 'package:metaweather/presentation/feature/forecast/bloc/forecast_bloc.dart';
import 'package:metaweather/presentation/feature/forecast/bloc/forecast_event.dart';
import 'package:metaweather/presentation/feature/forecast/bloc/forecast_state.dart';
import 'package:metaweather/presentation/feature/forecast/page/forecast_page_body.dart';
import 'package:metaweather/presentation/feature/forecast/widgets/forecast_app_bar.dart';
import 'package:metaweather/presentation/widgets/error_view.dart';
import 'package:metaweather/presentation/widgets/loading_indicator.dart';

class ForecastPage extends StatefulWidget {
  final Location location;

  const ForecastPage({Key key, @required this.location})
      : assert(location != null),
        super(key: key);

  static PageRoute pageRoute(Location location) => MaterialPageRoute(
        builder: (context) => ForecastPage(location: location),
      );

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final ForecastBloc forecastBloc = Injector.resolve();

  @override
  void initState() {
    super.initState();
    _loadForecast();
  }

  void _loadForecast() {
    forecastBloc.add(LoadForecastEvent(locationId: widget.location.id));
  }

  void _selectForecast(Forecast forecast) {
    forecastBloc.add(SelectForecastEvent(forecast: forecast));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildAppBar() {
    return ForecastAppBar(title: widget.location.name);
  }

  Widget _buildContent() {
    return BlocBuilder<ForecastBloc, ForecastState>(
      cubit: forecastBloc,
      builder: (context, state) {
        if (state is LoadingForecastState) {
          return _buildLoadingIndicator();
        } else if (state is LoadedForecastState) {
          return _buildPageBody(state);
        } else if (state is FailureForecastState) {
          return _buildErrorView(state.failure);
        }
        throw UnsupportedError('State $state is not supported');
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return LoadingIndicator();
  }

  Widget _buildPageBody(LoadedForecastState state) {
    return ForecastPageBody(
      forecasts: state.forecasts,
      selectedForecast: state.selectedForecast,
      onForecastSelected: _selectForecast,
    );
  }

  Widget _buildErrorView(Failure failure) {
    return ErrorView(
      message: failure.getMessage(),
      onRetry: _loadForecast,
    );
  }

  @override
  void dispose() {
    forecastBloc.close();
    super.dispose();
  }
}
