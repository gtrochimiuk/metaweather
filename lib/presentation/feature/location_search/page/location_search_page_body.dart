import 'package:flutter/material.dart';
import 'package:metaweather/data/model/location/location.dart';
import 'package:metaweather/presentation/feature/location_search/widgets/location_list_item.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';
import 'package:metaweather/presentation/widgets/info_view.dart';

class LocationSearchPageBody extends StatelessWidget {
  final String subtitle;
  final List<Location> locations;
  final void Function(Location) onLocationSelected;

  bool get hasSubtitle => subtitle != null;

  const LocationSearchPageBody({
    Key key,
    @required this.locations,
    @required this.onLocationSelected,
    this.subtitle,
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

  Widget _buildSubtitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.horizontal,
        vertical: 20,
      ),
      child: Text(
        subtitle,
        style: AppTextStyles.body(
          context,
          color: AppColors.secondaryContent(context),
        ),
      ),
    );
  }

  Widget _buildContentList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      itemCount: hasSubtitle ? locations.length + 1 : locations.length,
      itemBuilder: _buildLocationListItem,
      separatorBuilder: _buildSeparator,
    );
  }

  Widget _buildLocationListItem(BuildContext context, int index) {
    if (hasSubtitle && index == 0) {
      return _buildSubtitle(context);
    }
    final locationIndex = hasSubtitle ? index - 1 : index;
    return LocationListItem(
      location: locations[locationIndex],
      onSelected: onLocationSelected,
    );
  }

  Widget _buildSeparator(BuildContext context, int index) {
    if (hasSubtitle && index == 0) return Container();
    return Divider(color: AppColors.secondaryContent(context));
  }
}
