import 'package:flutter/cupertino.dart';

class CheckingProvider extends ChangeNotifier {
  List<bool> criteries = _SubCheckingProvider().criteries;
  submitFunction(int index) {
    debugPrint(index.toString()+criteries[index].toString());
    criteries[index] = !criteries[index];
    debugPrint(index.toString()+criteries[index].toString());

    notifyListeners();
  }
}

class _SubCheckingProvider {
  List<bool> criteries = List.generate(5, (index) => false);
}
