import 'dart:math';

import 'package:flutter/material.dart';
import 'package:metaweather/data/model/settings/settings_option.dart';
import 'package:metaweather/presentation/feature/settings/widgets/settings_option_list_item.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/style/color/app_colors.dart';
import 'package:metaweather/presentation/widgets/expandable_item.dart';

class SettingsExpandableItem<T> extends ExpandableItem {
  final String label;
  final List<SettingsOption<T>> options;
  final SettingsOption<T> selectedOption;
  final void Function(T) onOptionSelected;

  SettingsExpandableItem({
    Key key,
    @required this.label,
    @required this.options,
    @required this.selectedOption,
    @required this.onOptionSelected,
  })  : assert(label != null),
        assert(options != null),
        assert(selectedOption != null),
        assert(onOptionSelected != null),
        super(
          key: key,
          initiallyExpanded: false,
        );

  @override
  State<StatefulWidget> createState() => _SettingsExpandableItemState<T>();
}

class _SettingsExpandableItemState<T> extends ExpandableItemState<SettingsExpandableItem> {
  void _onOptionSelected(T value) {
    widget.onOptionSelected(value);
    toggleExpansion();
  }

  @override
  Widget buildExpandableContent() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.options.length,
      itemBuilder: _buildItem,
    );
  }

  @override
  Widget buildHeader() {
    return InkWell(
      onTap: toggleExpansion,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppMargin.horizontal),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          _buildContentRow(),
          _buildExpansionIcon(),
        ],
      ),
    );
  }

  Widget _buildContentRow() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLabel(),
          _buildSelectedValueLabel(),
        ],
      ),
    );
  }

  Widget _buildExpansionIcon() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: -pi * heightFactor.value,
            child: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.secondaryContent(context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final option = widget.options[index];
    return SettingsOptionListItem<T>(
      option: option,
      isSelected: option == widget.selectedOption,
      onSelected: _onOptionSelected,
    );
  }

  Widget _buildLabel() {
    return Flexible(
      child: Text(
        widget.label,
        style: AppTextStyles.body(context),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildSelectedValueLabel() {
    return Expanded(
      child: Text(
        widget.selectedOption.name,
        style: AppTextStyles.body(
          context,
          color: AppColors.secondaryContent(context),
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}
