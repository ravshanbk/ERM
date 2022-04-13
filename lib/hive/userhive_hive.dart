import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/models/user_hive_model.dart';

class UserHiveHive {
  authToken(
    String authToken,
  ) {
    final token = UserHive()..authToken = authToken;

    final box = Boxes.getUserHive();
    if (box.values.isNotEmpty) {
      box.putAt(0, token);
    } else {
      box.add(token);
    }

    box.putAt(0, token);
  }

  deleteAll() {
    final box = Boxes.getUserHive();
    box.clear();
  }
}
