import 'package:flutter/material.dart';
import 'package:metaweather/presentation/feature/settings/page/settings_page.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';

class SettingsAppBarButton extends StatelessWidget {
  const SettingsAppBarButton({Key key}) : super(key: key);

  _openSettings(BuildContext context) {
    Navigator.of(context).push(SettingsPage.pageRoute());
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.settings,
        color: AppColors.primaryContent(context),
      ),
      onPressed: () => _openSettings(context),
    );
  }
}
