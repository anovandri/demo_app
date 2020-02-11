import 'dart:convert';

import 'package:http/http.dart';
import 'package:indoxx1/common/error/indoxxi_common_error.dart';

abstract class IndoxxiWsClient extends BaseClient {}

typedef _PendingRequest = Future<Response> Function();

class IndoxxiWsClientImpl extends IndoxxiWsClient {
  final Client _client;

  IndoxxiWsClientImpl(this._client);

  Future<StreamedResponse> send(BaseRequest request) {
    return _client.send(request);
  }

  @override
  Future<Response> post(url, {Map<String, String> headers, body, Encoding encoding}) {
    return _handleResponse(() => super.post(url, headers: headers, body: body, encoding: encoding));
  }

  @override
  Future<Response> put(url, {Map<String, String> headers, body, Encoding encoding}) {
    return _handleResponse(() => super.put(url, headers: headers, body: body, encoding: encoding));
  }

  @override
  Future<Response> delete(url, {Map<String, String> headers, body, Encoding encoding}) {
    return _handleResponse(() => super.delete(url, headers: headers));
  }

  Future<Response> _handleResponse(_PendingRequest request) async {
    Response response = await request();
    if (response.statusCode >= 200 && response.statusCode < 300 ) {
      return response;
    }
    throw IndoxxiApiError(
      uri: response.request.url,
      code: response.statusCode,
      body: response.body,
      method: response.request.method,
    );
  }
}