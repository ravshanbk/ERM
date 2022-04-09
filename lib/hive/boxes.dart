import 'package:hive_flutter/hive_flutter.dart';
import 'package:roxcrm/models/creteria_model.dart';
import 'package:roxcrm/models/employee_model.dart';

class Boxes {
  static Box<Criteria> getCriterias() => Hive.box<Criteria>("criteria");
  static Box<Employee> getEmployee() => Hive.box<Employee>("employee");
}
