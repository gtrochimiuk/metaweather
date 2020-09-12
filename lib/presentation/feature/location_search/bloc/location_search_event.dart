import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LocationSearchEvent extends Equatable {}

class PerformLocationSearchEvent extends LocationSearchEvent {
  final String query;

  PerformLocationSearchEvent({@required this.query}) : assert(query != null);

  @override
  List<Object> get props => [query];
}
