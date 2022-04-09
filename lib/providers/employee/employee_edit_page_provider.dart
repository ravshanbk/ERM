import 'package:flutter/cupertino.dart';

class EmployeeEditingPageProvider extends ChangeNotifier {
  late int currentIndex;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  makeInitialValued(String name, String age, String phone, int index) {
    currentIndex = index;
    nameController.text = name;
    ageController.text = age;
    phoneNumberController.text = phone;
    notifyListeners();
  }
}
