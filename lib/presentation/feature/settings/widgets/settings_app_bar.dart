import 'package:flutter/material.dart';
import 'package:metaweather/common/utils/device.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({Key key}) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, Device.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: AppColors.primaryContent(context)),
      brightness: Theme.of(context).brightness,
      backgroundColor: AppColors.background(context),
      titleSpacing: 0,
      centerTitle: true,
      title: _buildTitle(context),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      AppTexts.current.settings(),
      style: AppTextStyles.headline(context),
    );
  }
}
