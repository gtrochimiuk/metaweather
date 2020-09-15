import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/network/network_service.dart';
import 'package:metaweather/common/result/failure_result.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/common/result/success_result.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/data/repository/location_repository.dart';
import 'package:metaweather/domain/network/search_location_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepositoryImpl extends LocationRepository {
  static const String _previouslySelectedLocationsKey = 'previouslySelectedLocations';

  final NetworkService networkService;

  LocationRepositoryImpl({@required this.networkService}) : assert(networkService != null);

  @override
  Future<Result<List<Location>, Failure>> searchLocation(String query) {
    final request = SearchLocationRequest(query);
    return networkService.make(request);
  }

  @override
  Future<Result<List<Location>, Failure>> getPreviouslySelected() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final locationsString = sharedPreferences.getString(_previouslySelectedLocationsKey);
    if (locationsString == null) {
      return SuccessResult([]);
    }
    try {
      final jsonList = json.decode(locationsString);
      final List<Location> locations =
          jsonList.map<Location>((locationJson) => Location.fromJson(locationJson)).toList();
      return SuccessResult(locations);
    } on Exception {
      return FailureResult(UnexpectedFailure());
    }
  }

  @override
  Future<Result<List<Location>, Failure>> savePreviouslySelected(Location location) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final previouslySelectedResult = await getPreviouslySelected();
    return previouslySelectedResult.fold(
      onSuccess: (List<Location> locations) {
        return _savePreviousLocation(
          location: location,
          locations: locations,
          sharedPreferences: sharedPreferences,
        );
      },
    );
  }

  Future<Result<List<Location>, Failure>> _savePreviousLocation({
    List<Location> locations,
    Location location,
    SharedPreferences sharedPreferences,
  }) async {
    try {
      final newLocations = locations.where((element) => element.id != location.id).toList();
      newLocations.add(location);
      final jsonList = json.encode(newLocations.map((e) => e.toJson()).toList());
      await sharedPreferences.setString(_previouslySelectedLocationsKey, jsonList);
      return SuccessResult(newLocations);
    } on Exception {
      return FailureResult(UnexpectedFailure());
    }
  }
}
