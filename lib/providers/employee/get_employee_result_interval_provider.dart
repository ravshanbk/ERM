import 'package:flutter/cupertino.dart';
import 'package:roxcrm/models/dfms_model.dart';

class GetEmployeeResultIntervalProvider extends ChangeNotifier {
  bool collapsed = false;
  changeCallapsed() {
    collapsed = !collapsed;
    notifyListeners();
  }

  String stringFrom = '';
  String stringTo = '';

  DateTime from = DateTime.now();
  DateTime to = DateTime.now();

  clear() {
    collapsed = false;
    stringFrom = "";
    stringTo = "";
    from = DateTime.now();
    to = DateTime.now();
    notifyListeners();
  }

  initTo(DateTime date) {
    stringTo = DTFM.maker(date.millisecondsSinceEpoch);
    to = date;
    notifyListeners();
  }

  initFrom(DateTime date) {
    stringFrom = DTFM.maker(date.millisecondsSinceEpoch);

    from = date;
    notifyListeners();
  }
   bool isInProgress = false;
  changeIsInProgress(bool v) {
    isInProgress = v;
    notifyListeners();
  }
}
