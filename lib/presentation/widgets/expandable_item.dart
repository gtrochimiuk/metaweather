import 'package:flutter/material.dart';

abstract class ExpandableItem extends StatefulWidget {
  final bool initiallyExpanded;

  const ExpandableItem({
    Key key,
    this.initiallyExpanded = true,
  })  : assert(initiallyExpanded != null),
        super(key: key);
}

abstract class ExpandableItemState<T extends ExpandableItem> extends State<T> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> heightFactor;
  bool isExpanded;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    isExpanded = widget.initiallyExpanded;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    heightFactor = animationController.drive(CurveTween(curve: Curves.easeIn));
    if (isExpanded) {
      animationController.value = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Column(
          children: <Widget>[
            buildHeader(),
            _buildExpandableContent(),
          ],
        );
      },
    );
  }

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
    if (isExpanded) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  Widget _buildExpandableContent() {
    return ClipRect(
      child: Align(
        heightFactor: heightFactor.value,
        child: buildExpandableContent(),
      ),
    );
  }

  Widget buildHeader();

  Widget buildExpandableContent();

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
