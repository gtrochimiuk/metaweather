import 'package:flutter/material.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';

class LocationListItem extends StatelessWidget {
  final Location location;
  final void Function(Location) onSelected;

  const LocationListItem({
    Key key,
    @required this.location,
    @required this.onSelected,
  })  : assert(location != null),
        assert(onSelected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSelected(location),
      title: Text(
        location.name,
        style: AppTextStyles.body(context),
      ),
    );
  }
}
