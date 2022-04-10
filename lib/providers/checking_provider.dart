import 'package:flutter/cupertino.dart';
import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/models/creteria_model.dart';

class CheckingProvider extends ChangeNotifier {
  List<bool> criteries = List.generate(
      Boxes.getCriterias().values.cast<Criteria>().toList().length,
      (index) => false);
  submitFunction(int index) {
    criteries[index] = !criteries[index];

    notifyListeners();
  }

  clearCriterial() {
    criteries = List.generate(criteries.length, (index) => false);
    notifyListeners();
  }
}
