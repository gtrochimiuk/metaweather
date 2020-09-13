import 'package:flutter/material.dart';
import 'package:metaweather/data/model/location.dart';
import 'package:metaweather/presentation/feature/location_search/widgets/location_list_item.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';
import 'package:metaweather/presentation/widgets/info_view.dart';

class LocationSearchPageBody extends StatelessWidget {
  final List<Location> locations;
  final void Function(Location) onLocationSelected;

  const LocationSearchPageBody({
    Key key,
    @required this.locations,
    @required this.onLocationSelected,
  })  : assert(locations != null),
        assert(onLocationSelected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (locations.isNotEmpty) {
      return _buildContentList(context);
    }
    return InfoView(
      information: AppTexts.current.noLocationsFound(),
    );
  }

  Widget _buildContentList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      itemCount: locations.length,
      itemBuilder: _buildLocationListItem,
      separatorBuilder: _buildSeparator,
    );
  }

  Widget _buildLocationListItem(BuildContext context, int index) {
    return LocationListItem(
      location: locations[index],
      onSelected: onLocationSelected,
    );
  }

  Widget _buildSeparator(BuildContext context, int index) {
    return Divider(color: AppColors.secondaryContent(context));
  }
}
