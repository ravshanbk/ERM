import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  

  GlobalKey<FormState>? formKey = GlobalKey();
  List<TextEditingController> controllers =
      List.generate(3, (index) => TextEditingController());

  clear() {

   
    for (var item in controllers) {
      item.clear();
    }
    notifyListeners();
  }

  bool isInProgress = false;
  changeIsInProgress(bool v) {
    isInProgress = v;
    notifyListeners();
  }
}
