import 'package:hive/hive.dart';

part 'employee_model.g.dart';

@HiveType(typeId: 1)
class Employee extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String age;

  @HiveField(2)
  late String phoneNumber;

  
}
