import 'dart:convert';

abstract class IExternalApi {
  static String defaultBaseUrl;

  Future<dynamic> makeRequest({
    int id,
    Map<String, String> queryParams,
    Map<String, String> headers,
    Map<String, String> body,
    Encoding encoding,
  });
}
