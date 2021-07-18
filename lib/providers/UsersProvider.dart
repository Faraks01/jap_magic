import 'package:http/http.dart';
import 'package:jap_magic/models/User.dart';
import 'package:jap_magic/network/ExternalApi.dart';

import 'BaseProvider.dart';

class UsersProvider extends BaseProvider<User> {
  final viewSet = ViewSets.users;
  User mainUser;

  retrieveSessionUser() async {
    final Response response = await this.fetchApi.makeRequest(customViewSet: '/authorization/get');

    final resBody = ExternalApi.decodeResponseBody(response);

    if (response.statusCode == 200) {
      mainUser = User.fromJson(resBody);
    }

    return 200;
  }

  login({String phoneNumber, String password}) async {
    try {
      final Response response = await this.createApi.makeRequest(customViewSet: '/authorization/login', body: {
        "phone": phoneNumber,
        "password": password
      });

      if (response.statusCode == 200) {
        final resBody = ExternalApi.decodeResponseBody(response);
        mainUser = User.fromJson(resBody);
        notifyListeners();
        return null;
      } else {
        return response.body;
      }
    } catch (e) {
      return "Неизвестная ошибка";
    }
  }
}
