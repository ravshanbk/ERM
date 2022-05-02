import 'package:flutter/cupertino.dart';

class CriteriaEditingPageProvider extends ChangeNotifier {
  late int currentIndex;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController letterController = TextEditingController();
  final TextEditingController textController = TextEditingController();
   bool isInProgress = false;
  changeIsInProgress(bool v) {
    isInProgress = v;
    notifyListeners();
  }
}
