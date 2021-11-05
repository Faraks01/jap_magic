import 'package:http/http.dart';
import 'package:jap_magic/models/Address.dart';
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

  addAddress({
    String city,
    String street,
    String streetIndex,
    int streetBuilding,
    String apartment,
    int porch,
    int floor,
  }) async {
    assert(city != null);
    assert(street != null);
    assert(streetIndex != null);

    try {
      loading = true;

      final Response response = await this.createApi.makeRequest(customViewSet: '/users/address', body: {
        "city": city,
        "street": street,
        "street_index": streetIndex,
        "street_building": streetBuilding,
        "apartment": apartment,
        "porch": porch,
        "floor": floor
      });

      if (response.statusCode == 201) {
        final resBody = ExternalApi.decodeResponseBody(response);
        mainUser.addresses.add(Address.fromJson(resBody));

        notifyListeners();
        return null;
      } else {
        return response.reasonPhrase;
      }
    } catch (e) {
      return "Неизвестная ошибка";
    } finally {
      loading = true;
    }
  }

  updateAddress({
    int id,
    String city,
    String street,
    String streetIndex,
    int streetBuilding,
    String apartment,
    int porch,
    int floor,
  }) async {
    assert(id != null);
    assert(city != null);
    assert(street != null);
    assert(streetIndex != null);

    try {
      loading = true;

      final Response response = await this.updateApi.makeRequest(customViewSet: '/users/address', body: {
        "id": id,
        "city": city,
        "street": street,
        "street_index": streetIndex,
        "street_building": streetBuilding,
        "apartment": apartment,
        "porch": porch,
        "floor": floor
      });

      if (response.statusCode == 200) {
        final resBody = ExternalApi.decodeResponseBody(response);
        final updatedAddress = Address.fromJson(resBody);
        final oldAddressIndex = mainUser.addresses.indexWhere((address) => address.id == updatedAddress.id);
        mainUser.addresses[oldAddressIndex] = updatedAddress;

        notifyListeners();
        return null;
      } else {
        return response.reasonPhrase;
      }
    } catch (e) {
      return "Неизвестная ошибка";
    } finally {
      loading = true;
    }
  }

  removeAddress({
    int id
  }) async {
    assert(id != null);

    try {
      loading = true;

      final Response response = await this.deleteApi.makeRequest(customViewSet: '/users/address/$id');

      if (response.statusCode == 204) {
        mainUser.addresses.removeWhere((address) => address.id == id);
        notifyListeners();
        return null;
      } else {
        return response.reasonPhrase;
      }
    } catch (e) {
      return "Неизвестная ошибка";
    } finally {
      loading = true;
    }
  }
}
