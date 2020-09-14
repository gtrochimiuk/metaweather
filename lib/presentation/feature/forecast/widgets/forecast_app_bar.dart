import 'package:flutter/material.dart';
import 'package:metaweather/common/utils/device.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';
import 'package:metaweather/presentation/widgets/settings_app_bar_button.dart';

class ForecastAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ForecastAppBar({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, Device.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _buildLeading(context),
      actions: [_buildSettingsButton(context)],
      brightness: Theme.of(context).brightness,
      backgroundColor: AppColors.background(context),
      titleSpacing: 0,
      centerTitle: true,
      title: _buildTitle(context),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          title,
          style: AppTextStyles.headline(context),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    return InkResponse(
      onTap: () => Navigator.of(context).pop(),
      child: Icon(
        Icons.search,
        color: AppColors.primaryContent(context),
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return SettingsAppBarButton();
  }
}
