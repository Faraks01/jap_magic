import 'package:http/http.dart';

abstract class ISession {
  Future<String> get sessionId;
  Future<void> updateCookie(Response response);
}