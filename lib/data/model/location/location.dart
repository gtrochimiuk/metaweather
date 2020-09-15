import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Location extends Equatable {
  final int id;
  final String name;
  final DateTime selectedAt;

  const Location({
    @required this.id,
    @required this.name,
    this.selectedAt,
  })  : assert(id != null),
        assert(name != null);

  Location.fromJson(Map<String, dynamic> json)
      : id = json['woeid'],
        name = json['title'],
        selectedAt = json['selectedAt'] != null ? DateTime.tryParse(json['selectedAt']) : null;

  Map<String, dynamic> toJson() => {
        'woeid': id,
        'title': name,
        'selectedAt': selectedAt?.toIso8601String(),
      };

  Location copyWith({DateTime selectedAt}) => Location(
        id: id,
        name: name,
        selectedAt: selectedAt ?? this.selectedAt,
      );

  @override
  List<Object> get props => [id, name, selectedAt];
}
