import 'package:flutter/material.dart';
import 'package:metaweather/data/model/location.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';

class ForecastPage extends StatefulWidget {
  final Location location;

  const ForecastPage({Key key, @required this.location})
      : assert(location != null),
        super(key: key);

  static PageRoute pageRoute(Location location) => MaterialPageRoute(
        builder: (context) => ForecastPage(location: location),
      );

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            widget.location.name,
            style: AppTextStyles.headline(context),
          ),
        ),
      ),
    );
  }
}
