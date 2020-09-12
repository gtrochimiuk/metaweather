import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metaweather/common/failure/failure.dart';
import 'package:metaweather/common/network/dio_network_service.dart';
import 'package:metaweather/common/network/http_method.dart';
import 'package:metaweather/common/network/request.dart';
import 'package:metaweather/common/result/failure_result.dart';
import 'package:metaweather/common/result/success_result.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

class RequestMock extends Mock implements Request<String> {}

class ResponseMock extends Mock implements Response {}

Dio dioMock;
RequestMock request;
ResponseMock response;

DioNetworkService networkService;

void main() {
  setUp(() {
    dioMock = DioMock();
    request = RequestMock();
    response = ResponseMock();
    networkService = DioNetworkService(dio: dioMock);

    when(request.createResponse(any)).thenAnswer((_) => _TestData.parsedResponse);
    when(request.method).thenReturn(HttpMethod.get);
  });

  test('Should return successful result', () async {
    _givenDioResponse(statusCode: 200);

    final result = await networkService.make(request);

    expect(result, SuccessResult<String, Failure>(_TestData.parsedResponse));
  });

  test('Should return UnexpectedFailure', () async {
    _givenDioResponse(statusCode: 400);

    final result = await networkService.make(request);

    expect(result, FailureResult<String, Failure>(UnexpectedFailure()));
  });

  test('Should handle DioError and return ConnectionFailure', () async {
    _givenDioError(DioErrorType.CONNECT_TIMEOUT);

    final result = await networkService.make(request);

    expect(result, FailureResult<String, Failure>(ConnectionFailure()));
  });

  test('Should handle DioError and return UnexpectedFailure', () async {
    _givenDioError(DioErrorType.RESPONSE);

    final result = await networkService.make(request);

    expect(result, FailureResult<String, Failure>(UnexpectedFailure()));
  });
}

void _givenDioResponse({@required int statusCode}) {
  when(dioMock.request(
    any,
    data: anyNamed('data'),
    queryParameters: anyNamed('queryParameters'),
    options: anyNamed('options'),
  )).thenAnswer((_) async => response);
  when(response.statusCode).thenReturn(statusCode);
}

void _givenDioError(DioErrorType type) {
  when(dioMock.request(
    any,
    data: anyNamed('data'),
    queryParameters: anyNamed('queryParameters'),
    options: anyNamed('options'),
  )).thenThrow(
    DioError(type: type),
  );
}

abstract class _TestData {
  static const String parsedResponse = 'response';
}
