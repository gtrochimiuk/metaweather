import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:metaweather/presentation/style/app_margin.dart';
import 'package:metaweather/presentation/style/app_text_styles.dart';
import 'package:metaweather/presentation/widgets/loading_indicator.dart';

mixin RefreshIndicatorMixin {
  Widget buildRefreshIndicator(
    BuildContext context, {
    @required Widget child,
    @required IndicatorController controller,
    @required String label,
    @required double width,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Stack(
          children: [
            if (!controller.isIdle) _buildRefreshIndicator(context, controller, label, width),
            _buildTransformedChild(controller, child),
          ],
        );
      },
    );
  }

  Widget _buildRefreshIndicator(
    BuildContext context,
    IndicatorController controller,
    String label,
    double width,
  ) {
    return Positioned(
      top: 50 * controller.value - 20,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProgressIndicator(controller),
          _buildInfoLabel(context, label),
        ],
      ),
    );
  }

  Widget _buildTransformedChild(
    IndicatorController controller,
    Widget child,
  ) {
    return Transform.translate(
      offset: Offset(0, 30 * controller.value),
      child: child,
    );
  }

  Widget _buildInfoLabel(BuildContext context, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.horizontal),
      child: Text(
        label,
        style: AppTextStyles.subtitle(context),
      ),
    );
  }

  Widget _buildProgressIndicator(IndicatorController controller) {
    return SizedBox(
      width: 20,
      height: 20,
      child: LoadingIndicator(
        value: controller.value.clamp(0.0, 1.0),
        strokeWidth: 3,
      ),
    );
  }
}
