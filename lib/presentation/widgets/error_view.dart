import 'package:flutter/material.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';
import 'package:metaweather/presentation/widgets/info_view.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final void Function() onRetry;

  const ErrorView({
    Key key,
    @required this.message,
    this.onRetry,
  })  : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRetry,
      child: InfoView(information: '$message\n${AppTexts.current.tapToRetry()}'),
    );
  }
}
