import 'package:http/http.dart';
import 'package:jap_magic/models/User.dart';
import 'package:jap_magic/network/ExternalApi.dart';

import 'BaseProvider.dart';

class UsersProvider extends BaseProvider<User> {
  final viewSet = ViewSets.users;
  User mainUser;

  retrieveSessionUser() async {
    final Response response = await this.fetchApi.makeRequest();

    final resBody = ExternalApi.decodeResponseBody(response);

    if (resBody["results"] is List) {
      mainUser = User.fromJson(resBody["results"][0]);
    }

    return 200;
  }
}
