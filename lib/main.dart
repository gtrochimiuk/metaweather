import 'package:flutter/material.dart';
import 'package:metaweather/application.dart';
import 'package:metaweather/common/dependency_injection/injector.dart';
import 'package:metaweather/common/environment/environment.dart';
import 'package:metaweather/common/environment/production_environment.dart';

void main() {
  Environment.setCurrent(ProductionEnvironment());
  Injector.setUp();
  runApp(Application());
}
