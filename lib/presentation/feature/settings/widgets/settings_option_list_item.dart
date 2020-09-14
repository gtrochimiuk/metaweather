import 'package:flutter/material.dart';
import 'package:metaweather/data/model/settings/settings_option.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';

class SettingsOptionListItem<T> extends StatelessWidget {
  final SettingsOption<T> option;
  final bool isSelected;
  final void Function(T) onSelected;

  const SettingsOptionListItem({
    Key key,
    @required this.option,
    @required this.isSelected,
    @required this.onSelected,
  })  : assert(option != null),
        assert(isSelected != null),
        assert(onSelected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          _buildContent(context),
          _buildSeparator(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListTile(
      onTap: () => onSelected(option.value),
      title: _buildTitle(context),
      trailing: _buildTrailing(context),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      option.name,
      style: AppTextStyles.body(
        context,
        color: AppColors.secondaryContent(context),
      ),
      textAlign: TextAlign.end,
    );
  }

  Widget _buildTrailing(BuildContext context) {
    const double width = 20;
    if (isSelected) {
      return Icon(
        Icons.check,
        color: AppColors.secondaryContent(context),
        size: width,
      );
    }
    return const SizedBox(width: width);
  }

  Widget _buildSeparator(BuildContext context) {
    return Divider(
      color: AppColors.secondaryBackground(context),
      height: 1,
    );
  }
}
