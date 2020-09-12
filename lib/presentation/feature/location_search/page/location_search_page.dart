import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaweather/common/dependency_injection/injector.dart';
import 'package:metaweather/common/utils/debouncer.dart';
import 'package:metaweather/data/model/location.dart';
import 'package:metaweather/presentation/feature/forecast/page/forecast_page.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_bloc.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_event.dart';
import 'package:metaweather/presentation/feature/location_search/bloc/location_search_state.dart';
import 'package:metaweather/presentation/feature/location_search/page/location_search_page_body.dart';
import 'package:metaweather/presentation/feature/location_search/widgets/location_search_app_bar.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';
import 'package:metaweather/presentation/widgets/empty_view.dart';

class LocationSearchPage extends StatefulWidget {
  @override
  _LocationSearchPageState createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  final LocationSearchBloc locationSearchBloc = Injector.resolve();
  final Debouncer queryDebouncer = Debouncer(duration: const Duration(milliseconds: 300));

  void _onQueryChanged(String query) {
    queryDebouncer.run(() {
      locationSearchBloc.add(PerformLocationSearchEvent(query: query));
    });
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
    );
  }

  Widget _buildContent() {
    return BlocBuilder<LocationSearchBloc, LocationSearchState>(
        cubit: locationSearchBloc,
        builder: (context, state) {
          if (state is LoadedLocationSearchState) {
            return _buildLoadedPageBody(context, state);
          } else if (state is UninitializedLocationSearchState) {
            return _buildInfoView(context);
          } else if (state is LoadingLocationSearchState) {
            return _buildLoadingIndicator(context);
          }
          throw UnsupportedError('State $state is not supported');
        });
  }

  Widget _buildInfoView(BuildContext context) {
    return EmptyView(
      information: AppTexts.current.findYourLocation(),
    );
  }

  Widget _buildLoadedPageBody(BuildContext context, LoadedLocationSearchState state) {
    return LocationSearchPageBody(
      locations: state.locations,
      onLocationSelected: _onLocationSelected,
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    locationSearchBloc.close();
    super.dispose();
  }
}
