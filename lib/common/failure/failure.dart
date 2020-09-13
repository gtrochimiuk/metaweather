import 'package:equatable/equatable.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

abstract class Failure extends Equatable {
  String getMessage();

  @override
  List<Object> get props => [];
}

class ConnectionFailure extends Failure {
  @override
  String getMessage() => AppTexts.current.noInternetConnection();
}

class UnexpectedFailure extends Failure {
  @override
  String getMessage() => AppTexts.current.unexpectedError();
}
