import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final int id;
  final String name;

  Location.fromJson(Map<String, dynamic> json)
      : id = json['woeid'],
        name = json['title'];

  @override
  List<Object> get props => [id, name];
}
