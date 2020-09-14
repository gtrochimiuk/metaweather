import 'package:flutter/foundation.dart';

class SettingsOption<T> {
  final String name;
  final T value;

  SettingsOption({
    @required this.name,
    @required this.value,
  })  : assert(name != null),
        assert(value != null);
}
