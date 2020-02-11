import 'dart:io';

class OmdbApiError extends HttpException {
  final int code;
  final String method;
  final String body;

  OmdbApiError({
    String message = "OmdbApiError",
    this.method,
    Uri uri,
    this.body,
    this.code,
  }) : super(message, uri: uri);

  String toString() {
    var b = new StringBuffer()..write("OmdbApiError: ")..write(message);
    if (method != null) {
      b.write(", method = $method");
    }
    if (uri != null) {
      b.write(", url = $uri");
    }
    if (body != null) {
      b.write(", body = $body");
    }
    return b.toString();
  }
}