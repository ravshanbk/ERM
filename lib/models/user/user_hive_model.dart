

import 'package:hive/hive.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: 7)
class UserHive extends HiveObject {
  @HiveField(0)
  late String authToken;

  @HiveField(1)
  late String name;
  @HiveField(2)
  late String email;

 
}
