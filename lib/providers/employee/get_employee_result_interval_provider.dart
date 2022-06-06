import 'package:flutter/cupertino.dart';

class GetEmployeeResultIntervalProvider extends ChangeNotifier {
  bool expanded = false;
  changeExpanded(bool v) {
    expanded = v;
    notifyListeners();
  }

  DateTime? from;
  DateTime? to;

  clear() {
   
    from = null;
    to = null;
    notifyListeners();
  }

  initTo(DateTime date) {
    to = date;
    notifyListeners();
  }

  initFrom(DateTime date) {
    from = date;
    notifyListeners();
  }

  bool isInProgress = false;
  changeIsInProgress(bool v) {
    isInProgress = v;
    notifyListeners();
  }
}
