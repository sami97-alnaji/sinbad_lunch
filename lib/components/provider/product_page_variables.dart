// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';

class ProductPageVariables with ChangeNotifier {
  TextEditingController? controllerCountItems = TextEditingController();

  // ignore: non_constant_identifier_names
  int _CountItems = 1;

  set CountItems(int value) {
    _CountItems = value;
    notifyListeners();
  }



  reVariables() {
    //   controllerCountItems = TextEditingController();
    //

      CountItems = 1;
    controllerCountItems!.text = _CountItems.toString();
    // print('provider');
      notifyListeners();
  }

  minuss() {
    if (_CountItems > 1) {
      _CountItems--;
      controllerCountItems!.text = _CountItems.toString();
      print(controllerCountItems!.text);
    }
    notifyListeners();

  }

  pulss() {
    if (_CountItems < 60) {
      _CountItems++;
      controllerCountItems!.text = _CountItems.toString();
      print(controllerCountItems!.text);
    }
    notifyListeners();
  }

}
