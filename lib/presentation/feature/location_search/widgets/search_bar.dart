import 'package:flutter/material.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  static const double height = 35;

  final void Function(String) onSubmitted;
  final void Function(String) onChanged;
  final EdgeInsets margin;

  const SearchBar({
    Key key,
    this.onSubmitted,
    this.onChanged,
    this.margin,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, height);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      child: TextField(
        style: AppTextStyles.body(context),
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        decoration: _buildDecoration(context),
        autocorrect: false,
      ),
    );
  }

  InputDecoration _buildDecoration(BuildContext context) {
    return InputDecoration(
      fillColor: AppColors.secondaryBackground(context),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          const Radius.circular(20),
        ),
        borderSide: BorderSide.none,
      ),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: AppMargin.horizontal),
      suffixIcon: Icon(Icons.search),
      hintText: AppTexts.current.location(),
      hintStyle: AppTextStyles.subtitle(context),
    );
  }
}
