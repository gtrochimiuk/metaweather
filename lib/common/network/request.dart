import 'package:flutter/foundation.dart';
import 'package:metaweather/common/network/http_method.dart';
import 'package:metaweather/common/network/request_body.dart';

abstract class Request<T> {
  final String path;
  final HttpMethod method;
  final RequestBody body;
  final Map<String, dynamic> queryParameters;

  T createResponse(dynamic json);

  Request({
    @required this.path,
    this.method = HttpMethod.get,
    this.body,
    this.queryParameters,
  })  : assert(path != null),
        assert(method != null);
}
