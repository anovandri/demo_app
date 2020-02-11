import 'dart:io';

class IndoxxiApiError extends HttpException {
  final int code;
  final String method;
  final String body;

  IndoxxiApiError({
    String message = "IndoxxiApiError",
    this.method,
    Uri uri,
    this.body,
    this.code,
  }) : super(message, uri: uri);

  String toString() {
    var b = new StringBuffer()..write("IndoxxiApiError: ")..write(message);
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