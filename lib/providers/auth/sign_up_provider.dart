import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = JosKeys.josKeys1;
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
class JosKeys {
  static final josKeys1 = GlobalKey<FormState>();
  static final josKeys2 = GlobalKey<FormState>();
}