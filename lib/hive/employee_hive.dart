import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/models/employee_model.dart';

class EmployeeHive {
  addEmployee(
    String name,
    String age,
    String since,
  ) {
    final employee = Employee()
      ..name = name
      ..age = age
      ..phoneNumber = since;

    final box = Boxes.getEmployee();

    box.add(employee);
  }

  editEmployee(int index, String name, String age, String phone) async {
    final box = Boxes.getEmployee();

    final employee = Employee()
      ..name = name
      ..age = age
      ..phoneNumber =phone;

    await box.putAt(index, employee);
  }

  deleteEmployee(int index) async {
    final box = Boxes.getEmployee();

    box.deleteAt(index);
  }

}
