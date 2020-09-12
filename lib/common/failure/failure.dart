import 'package:equatable/equatable.dart';
import 'package:metaweather/common/texts/app_texts.dart';

abstract class Failure extends Equatable {
  String toLocalizedMessage();

  @override
  List<Object> get props => [];
}

class ConnectionFailure extends Failure {
  @override
  String toLocalizedMessage() => AppTexts.current.noInternetConnection();
}

class UnexpectedFailure extends Failure {
  @override
  String toLocalizedMessage() => AppTexts.current.unexpectedError();
}
