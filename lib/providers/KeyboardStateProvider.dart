import 'package:flutter/material.dart';

class KeyboardStateProvider with ChangeNotifier {
  double height = 0.0;
  bool isOpen = false;

  setHeight(double val) {
    if (height != val) {
      height = val;
      isOpen = val == 0 ? false : true;

      notifyListeners();
    }
  }
}
