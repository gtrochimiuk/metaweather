import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/network/http_method.dart';
import 'package:metaweather/common/network/network_service.dart';
import 'package:metaweather/common/network/request.dart';
import 'package:metaweather/common/result/failure_result.dart';
import 'package:metaweather/common/result/result.dart';
import 'package:metaweather/common/result/success_result.dart';

class DioNetworkService extends NetworkService {
  final Dio dio;

  DioNetworkService({@required this.dio}) : assert(dio != null);

  @override
  Future<Result<T, Failure>> make<T>(Request<T> request) async {
    try {
      final response = await dio.request(
        request.path,
        data: request.body?.toJson(),
        queryParameters: request.queryParameters,
        options: Options(
          method: request.method.rawValue,
        ),
      );
      return _handleResponse<T>(request, response);
    } on DioError catch (error) {
      return _handleError(error);
    }
  }

  Result<T, Failure> _handleResponse<T>(Request<T> request, Response response) {
    if (_responseSuccessful(response.statusCode)) {
      return SuccessResult(request.createResponse(response.data));
    }
    return FailureResult(UnexpectedFailure());
  }

  Result<T, Failure> _handleError<T>(DioError error) {
    if (error.type == DioErrorType.CONNECT_TIMEOUT) {
      return FailureResult(ConnectionFailure());
    } else {
      return FailureResult(UnexpectedFailure());
    }
  }

  bool _responseSuccessful(int statusCode) => statusCode >= 200 && statusCode < 300;
}
