import 'package:flutter/cupertino.dart';

class CriteriaAddPageProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController letterController = TextEditingController();
  final TextEditingController criteriaTextController = TextEditingController();
}