import 'package:flutter/cupertino.dart';

class SignInProvider extends ChangeNotifier {
  final  GlobalKey<FormState> formKey =GlobalKey<FormState>();
 final TextEditingController emailController = TextEditingController();
 final TextEditingController passwordController = TextEditingController();

 
  clear() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }
}


