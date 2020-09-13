import 'package:flutter/material.dart';
import 'package:metaweather/presentation/feature/location_search/widgets/location_search_app_bar.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';

class InfoView extends StatelessWidget {
  final String information;

  const InfoView({Key key, @required this.information})
      : assert(information != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryBackground(context),
      padding: const EdgeInsets.symmetric(
        horizontal: AppMargin.horizontal,
        vertical: AppMargin.vertical,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height - LocationSearchAppBar.height,
      child: Center(
        child: Text(
          information,
          style: AppTextStyles.subtitle(context),
        ),
      ),
    );
  }
}
