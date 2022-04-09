import 'package:flutter/cupertino.dart';

class EmployeeAddPageProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  clearControllers() {
    nameController.clear();
    ageController.clear();
    phoneNumberController.clear();
    notifyListeners();
  }
}
