import 'package:flutter/material.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';

class ForecastAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double height = 60;
  final String title;

  const ForecastAppBar({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _buildLeading(context),
      brightness: Theme.of(context).brightness,
      backgroundColor: AppColors.background(context),
      titleSpacing: 0,
      title: _buildTitle(context),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.horizontal),
      child: Text(
        title,
        style: AppTextStyles.headline(context),
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
}
