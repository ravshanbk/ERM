import 'package:flutter/material.dart';
import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/ui/add_edit_pages/criteria/add_criteria.dart';
import 'package:roxcrm/ui/add_edit_pages/criteria/edit_criteria.dart';
import 'package:roxcrm/ui/add_edit_pages/employee/add_employee.dart';
import 'package:roxcrm/ui/add_edit_pages/employee/edit_employee_page.dart';
import 'package:roxcrm/ui/auth/sign_in_page.dart';
import 'package:roxcrm/ui/body_page.dart';
import 'package:roxcrm/ui/settings/criteria_settings.dart';
import 'package:roxcrm/ui/settings/employee_settings.dart';
import 'package:roxcrm/ui/settings_page.dart';

class RouteManager {
  static generaRouter(RouteSettings settings) {
    // ignore: unused_local_variable
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => Boxes.getUserHive().values.isEmpty
                ? const SignInPage()
                : const BodyPage());
      case "/settings":
        return MaterialPageRoute(builder: (_) => const SettingsPage());
         case "/body":
        return MaterialPageRoute(builder: (_) => const BodyPage());
    
      case "/criterias":
        return MaterialPageRoute(builder: (_) => const CriteriaSettingsPage());
      case "/employee":
        return MaterialPageRoute(builder: (_) => const EmployeeSettingsPage());

      case "/editEmployee":
        return MaterialPageRoute(builder: (_) => const EditEmployeePage());
      case "/addEmployee":
        return MaterialPageRoute(builder: (_) => const AddEmployeePage());
      case "/addCriteria":
        return MaterialPageRoute(builder: (_) => const AddCriteriaPage());
      case "/editCriteria":
        return MaterialPageRoute(builder: (_) => const EditCriteriaPage());
    }
  }
}
