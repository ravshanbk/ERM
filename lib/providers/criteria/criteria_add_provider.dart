import 'package:flutter/cupertino.dart';

class CriteriaAddPageProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController letterController = TextEditingController();
  final TextEditingController criteriaTextController = TextEditingController();

  clearLetter() {
    letterController.clear();
    notifyListeners();
  }

  clear() {
    letterController.clear();
    criteriaTextController.clear();
    notifyListeners();
  }

  bool isInProgress = false;
  changeIsInProgress(bool v) {
    isInProgress = v;
    notifyListeners();
  }
}
