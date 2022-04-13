import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:roxcrm/hive/userhive_hive.dart';
import 'package:roxcrm/models/user_model.dart';

class UserService {
  static String localhost = "192.168.1.6";

  Future<User> signUpUser(
      String name, String email, String parol, bool isAdmin) async {
    try {
      Response res = await Dio().post(
        "http://$localhost:5000/api/users",
        data: {
          "name": name,
          "email": email,
          "password": parol,
          "isAdmin": isAdmin
        },
      );
      return User.fromJson(res.data);
    } catch (e) {
      throw Exception("UserService signUpUser: " + e.toString());
    }
  }

  signInUser(
    String email,
    String parol,
  ) async {
    try {
      Response res = await Dio().post(
        "http://$localhost:5000/api/auth/user",
        data: {
          "email": email,
          "password": parol,
        },
      );
      if (res.statusCode == 200) {
        debugPrint("AUTH-TOKEN: " + res.headers['x-auth-token'].toString());
        UserHiveHive().authToken(res.headers["x-auth-token"].toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("UserService signInUser: " + e.toString());
    }
  }
}
