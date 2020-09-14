import 'package:flutter/material.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  static const double height = 35;

  final void Function(String) onSubmitted;
  final void Function(String) onChanged;
  final void Function() onCleared;
  final EdgeInsets margin;

  const SearchBar({
    Key key,
    this.onSubmitted,
    this.onChanged,
    this.onCleared,
    this.margin,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, SearchBar.height);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: SearchBar.height,
      child: TextField(
        controller: controller,
        style: AppTextStyles.body(context),
        onSubmitted: widget.onSubmitted,
        onChanged: widget.onChanged,
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
      prefixIcon: _buildPrefixIcon(context),
      suffixIcon: _buildSuffixIcon(context),
      hintText: AppTexts.current.location(),
      hintStyle: AppTextStyles.subtitle(context),
    );
  }

  Widget _buildPrefixIcon(BuildContext context) {
    return Icon(
      Icons.search,
      color: AppColors.primaryContent(context),
    );
  }

  Widget _buildSuffixIcon(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 2),
      icon: Icon(
        Icons.clear,
        color: AppColors.primaryContent(context),
      ),
      onPressed: () {
        controller.clear();
        widget.onCleared();
      },
    );
  }
}
