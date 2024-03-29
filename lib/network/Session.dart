import 'package:http/http.dart' as http;
import 'package:jap_magic/interfaces/ISession.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session implements ISession {
  Session._privateConstructor();

  static final Session _instance = Session._privateConstructor();

  factory Session() {
    return _instance;
  }

  bool _orderPageAnimations = false;

  set orderPageAnimations(bool value) {
    if (_orderPageAnimations) return;

    updateSharedPreferences((sharedPreferences) {
      sharedPreferences.setBool('orderPageAnimations', true);
    });
    
    _orderPageAnimations = value;
  }

  get orderPageAnimations => _orderPageAnimations;

  Map<String, String> defaultHeaders = {'requesting-client': 'flutter-mobile'};

  SharedPreferences sharedPreferences;

  RegExp sessionIdRegex = RegExp(r'sessionid=[\w|\d]*;');

  Future<void> checkOrderPageAnimations() async {
    await updateSharedPreferences((sharedPreferences) {
      if (sharedPreferences.containsKey('orderPageAnimations')) {
        orderPageAnimations = true;
      }
    });

    return 200;
  }
  
  Future<void> updateSharedPreferences(Function(SharedPreferences sharedPreferences) cb) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    
    cb(sharedPreferences);
  }

  Future<String> get sessionId async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }

    return sharedPreferences.getString('sessionId');
  }

  Future<void> updateCookie(http.Response response) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }

    String rawCookie = response.headers['set-cookie'];

    if (rawCookie != null) {
      var sessionId = sessionIdRegex.stringMatch(rawCookie);

      if (sessionId != null) {
        sharedPreferences.setString('sessionId', sessionId);
      }

//      int index = rawCookie.indexOf(';');
//      headers['cookie'] =
//          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
