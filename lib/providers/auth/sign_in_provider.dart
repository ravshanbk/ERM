import 'package:flutter/cupertino.dart';

class SignInProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  clear() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  bool isInProgress = false;
  changeIsInProgress(bool v) {
    isInProgress = v;
    notifyListeners();
  }
}
