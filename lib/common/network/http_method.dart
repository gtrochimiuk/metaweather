enum HttpMethod { get, post, put, patch, delete }

extension HttpMethodExtension on HttpMethod {
  String get rawValue {
    switch (this) {
      case HttpMethod.get:
        return 'GET';
      case HttpMethod.post:
        return 'POST';
      case HttpMethod.put:
        return 'PUT';
      case HttpMethod.patch:
        return 'PATCH';
      case HttpMethod.delete:
        return 'DELETE';
    }
    throw UnsupportedError('Method $this is not supported');
  }
}
