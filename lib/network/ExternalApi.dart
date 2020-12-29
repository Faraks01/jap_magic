import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jap_magic/interfaces/IExternalApi.dart';

import 'Session.dart';

class OrderingFilters {
  static const dueDate = 'due_date';
}

class ViewSets {
  static const brands = '/brands';
  static const categories = '/categories';
  static const productLines = '/lines';
  static const products = '/products';
  static const subcategories = '/subcategories';
}

enum AllowedRequestMethods { get, patch, delete, post }

class ExternalApi implements IExternalApi {
  // static const defaultBaseUrl = 'https://staging.v3.riskhub.app/api';
  // static const defaultBaseUrl = 'https://rhv3.snivik.com/api';
  static const defaultBaseUrl = 'http://0.0.0.0:8000/api';

  static dynamic decodeResponseBody(http.Response response) =>
      jsonDecode(utf8.decode(response.bodyBytes));

  static Session session = Session();

  final String baseUrl;
  final AllowedRequestMethods method;
  final String viewSet;

  const ExternalApi(
      {this.baseUrl = ExternalApi.defaultBaseUrl, this.method, this.viewSet});

  Future<http.Response> makeRequest({
    int id,
    String customViewSet,
    Map<String, String> queryParams,
    Map<String, String> headers,
    Map<String, dynamic> body,
    Encoding encoding,
  }) async {
    Map<String, String> _headers = {
      ...session.defaultHeaders,
      'Content-Type': 'application/json',
      if (session.sessionId != null) 'Cookie': await session.sessionId,
      if (headers != null) ...headers
    };

    String url;

    if (customViewSet != null) {
      url = '$baseUrl$customViewSet/';
    } else {
      url = '$baseUrl$viewSet/';
      if (id != null) url = '$url$id/';
    }

    if (queryParams != null) {
      bool isFirst = true;

      queryParams.forEach((key, value) {
        if (isFirst) {
          isFirst = false;
          url = '$url?$key=$value';
        } else {
          url = '$url&$key=$value';
        }
      });
    }

    if (customViewSet != null) print(url);

    var response;

    switch (method) {
      case AllowedRequestMethods.get:
        response = await http.get(url, headers: _headers);
        break;

      case AllowedRequestMethods.patch:
        response = await http.patch(url,
            headers: _headers, body: json.encode(body), encoding: encoding);
        break;

      case AllowedRequestMethods.delete:
        response = await http.delete(url, headers: _headers);
        break;

      case AllowedRequestMethods.post:
        response = await http.post(url,
            headers: _headers, body: json.encode(body), encoding: encoding);
        break;
    }

    await session.updateCookie(response);

    return response;
  }
}
