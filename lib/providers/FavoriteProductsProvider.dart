import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProductsProvider with ChangeNotifier {
  static const deviceStorageKey = '##_favorite_products_##';

  final Set<int> _productIds = {};

  Future<int> getKeysFromDeviceStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final receivedIds = prefs.getStringList(deviceStorageKey);

    if (receivedIds is List) {
      _productIds.addAll(
          prefs.getStringList(deviceStorageKey).map((e) => int.parse(e)));
    }

    return 200;
  }

  Future updateDeviceStorageKeys() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList(
        deviceStorageKey, _productIds.map((e) => '$e').toList());
  }

  Set<int> get productIds => _productIds.toSet();

  removeId(int id, {bool notify = true}) {
    _productIds.remove(id);

    if (notify) {
      notifyListeners();
    }

    updateDeviceStorageKeys();
  }

  addId(int id, {bool notify = true}) {
    _productIds.add(id);

    if (notify) {
      notifyListeners();
    }

    updateDeviceStorageKeys();
  }
}
