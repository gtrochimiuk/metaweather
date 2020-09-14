import 'package:flutter/material.dart';
import 'package:metaweather/common/utils/device.dart';
import 'package:metaweather/presentation/feature/location_search/widgets/search_bar.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';

class LocationSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String) onSearchQueryChanged;
  final void Function() onSearchQueryCleared;

  const LocationSearchAppBar({
    Key key,
    this.onSearchQueryChanged,
    this.onSearchQueryCleared,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, Device.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Theme.of(context).brightness,
      backgroundColor: AppColors.background(context),
      titleSpacing: 0,
      centerTitle: false,
      title: _buildSearchBar(context),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return SearchBar(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.horizontal, vertical: 10),
      onChanged: onSearchQueryChanged,
      onCleared: onSearchQueryCleared,
    );
  }
}
