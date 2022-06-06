import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/models/employee_model.dart';

class EmployeeHive {
  addEmployee(
    String sellerId,
    String name,
    String age,
    String phoneNumber,
  ) {
    final employee = Employee()
      ..name = name
      ..age = age
      ..phoneNumber = phoneNumber
      ;

    final box = Boxes.getEmployee();

    box.add(employee);
  }

  editEmployee(int index, String name, String age, String phone) async {
    final box = Boxes.getEmployee();

    final employee = Employee()
      ..name = name
      ..age = age
      ..phoneNumber = phone;

    await box.putAt(index, employee);
  }

  deleteEmployee(int index) async {
    final box = Boxes.getEmployee();

    box.deleteAt(index);
  }
}
