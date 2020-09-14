import 'package:flutter/material.dart';
import 'package:metaweather/common/utils/device.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

class InfoView extends StatelessWidget {
  final String information;
  final void Function() onRetry;

  const InfoView({
    Key key,
    @required this.information,
    this.onRetry,
  })  : assert(information != null),
        super(key: key);

  String get informationText => information + (onRetry != null ? '\n${AppTexts.current.tapToRetry()}' : '');

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secondaryBackground(context),
      child: InkWell(
        splashColor: AppColors.background(context),
        onTap: onRetry,
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppMargin.horizontal,
        vertical: AppMargin.vertical,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height - Device.appBarHeight,
      child: Center(
        child: Text(
          informationText,
          style: AppTextStyles.subtitle(context),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
