import 'dart:io';

import 'package:indoxx1/common/model/response_data.dart';

class ApiError extends HttpException {
  final int code;
  final String method;
  final String body;
  final String requestBody;
  final ResponseError responseError;

  ApiError({
    String message,
    this.method,
    Uri uri, 
    this.body,
    this.code,
    this.requestBody,
    this.responseError,
  }) : super(message, uri: uri);

  String toString() {
    var b = StringBuffer()..write("ApiError: ")..write(message);
    if (method != null) {
      b.write(', method = $method');
    }
    if (uri != null) {
      b.write(', url = $uri');
    }
    if (requestBody != null) {
      b.write(', requestBody = $requestBody');
    }
    if (body != null) {
      b.write(', body = $body');
    }
    return b.toString();
  }

}