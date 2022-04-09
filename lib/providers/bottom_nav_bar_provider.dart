import 'package:flutter/cupertino.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int currentIndex = 0;
  onPressed(v) {
    currentIndex = v;
    notifyListeners();
  }
}
