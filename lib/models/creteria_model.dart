import 'package:hive/hive.dart';

part 'creteria_model.g.dart';

@HiveType(typeId: 0)
class Criteria extends HiveObject {

  @HiveField(0)
 late String criteriaLetter;

  @HiveField(1)
 late String criteriaText;
 
}
