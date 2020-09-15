import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Location extends Equatable {
  final int id;
  final String name;

  const Location({
    @required this.id,
    @required this.name,
  })  : assert(id != null),
        assert(name != null);

  Location.fromJson(Map<String, dynamic> json)
      : id = json['woeid'],
        name = json['title'];

  @override
  List<Object> get props => [id, name];
}
