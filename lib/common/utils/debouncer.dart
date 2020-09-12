import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  final Duration duration;
  void Function() action;
  Timer _timer;

  Debouncer({@required this.duration}) : assert(duration != null);

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(duration, action);
  }
}
