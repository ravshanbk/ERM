import 'package:flutter/cupertino.dart';

class HomePageProvider extends ChangeNotifier {
  int valur = 5;
  increment() {
    valur++;
    notifyListeners();
  }

  decrement() {
    valur--;
    notifyListeners();
  }
}
