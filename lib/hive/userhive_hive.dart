import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/models/user/user_hive_model.dart';

class UserHiveService {
  saveUser({
    required String authToken,
    required String name,
    required String email,
  }) {
    final user = UserHive()
      ..authToken = authToken
      ..email = email
      ..name = name;

    final box = Boxes.getUserHive();
    if (box.values.isNotEmpty) {
      box.putAt(0, user);
    } else {
      box.add(user);
    }

    box.putAt(0, user);
  }

  deleteAll() {
    final box = Boxes.getUserHive();
    box.clear();
  }
}
