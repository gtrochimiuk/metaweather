import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/dependency_injection/injector.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/utils/debouncer.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/presentation/feature/forecast/page/forecast_page.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_bloc.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_event.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_state.dart';
import 'package:metaweather/presentation/feature/location_search/page/location_search_page_body.dart';
import 'package:metaweather/presentation/feature/location_search/widgets/location_search_app_bar.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';
import 'package:metaweather/presentation/widgets/error_view.dart';
import 'package:metaweather/presentation/widgets/info_view.dart';
import 'package:metaweather/presentation/widgets/loading_indicator.dart';

class LocationSearchPage extends StatefulWidget {
  @override
  _LocationSearchPageState createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  final LocationSearchBloc locationSearchBloc = Injector.resolve();
  final Debouncer queryDebouncer = Debouncer(duration: const Duration(milliseconds: 200));
  String lastQuery;

  void _onQueryChanged(String query) {
    queryDebouncer.run(() {
      lastQuery = query;
      locationSearchBloc.add(PerformLocationSearchEvent(query: query));
    });
  }

  void _onQueryCleared() {
    locationSearchBloc.add(PerformLocationSearchEvent(query: ''));
  }

  void _retrySearch() {
    if (lastQuery != null) {
      locationSearchBloc.add(PerformLocationSearchEvent(query: lastQuery));
    }
  }

  void _onLocationSelected(Location location) {
    Navigator.of(context).push(ForecastPage.pageRoute(location));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildAppBar() {
    return LocationSearchAppBar(
      onSearchQueryChanged: _onQueryChanged,
      onSearchQuerySubmitted: _onQueryChanged,
      onSearchQueryCleared: _onQueryCleared,
    );
  }

  Widget _buildContent() {
    return BlocBuilder<LocationSearchBloc, LocationSearchState>(
        cubit: locationSearchBloc,
        builder: (context, state) {
          if (state is LoadedLocationSearchState) {
            return _buildLoadedPageBody(state);
          } else if (state is UninitializedLocationSearchState) {
            return _buildInfoView();
          } else if (state is LoadingLocationSearchState) {
            return _buildLoadingIndicator();
          } else if (state is FailureLocationSearchState) {
            return _buildErrorView(state.failure);
          }
          throw UnsupportedError('State $state is not supported');
        });
  }

  Widget _buildInfoView() {
    return InfoView(
      information: AppTexts.current.findYourLocation(),
    );
  }

  Widget _buildLoadedPageBody(LoadedLocationSearchState state) {
    return LocationSearchPageBody(
      locations: state.locations,
      onLocationSelected: _onLocationSelected,
    );
  }

  Widget _buildLoadingIndicator() {
    return LoadingIndicator();
  }

  Widget _buildErrorView(Failure failure) {
    return ErrorView(
      message: failure.getMessage(),
      onRetry: _retrySearch,
    );
  }

  @override
  void dispose() {
    locationSearchBloc.close();
    super.dispose();
  }
}
