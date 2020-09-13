import 'package:flutter/material.dart';
import 'package:metaweather/common/environment/environment.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';
import 'package:url_launcher/url_launcher.dart';

class MetaweatherAttributionLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchMetaweather,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppMargin.vertical,
        ),
        child: Text(
          AppTexts.current.attributionInfo(),
          style: AppTextStyles.subtitle(context),
        ),
      ),
    );
  }

  void _launchMetaweather() {
    launch(Environment.current.attributionUrl);
  }
}
