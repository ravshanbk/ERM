import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:roxcrm/config/env.dart';
import 'package:roxcrm/hive/userhive_hive.dart';
import 'package:roxcrm/models/user/sign_up_user_model.dart';
import 'package:roxcrm/pppp.dart';

class UserService {
  Future<SignUpUser> signUpUser(
      String name, String email, String parol, bool isAdmin) async {
    try {
      Response res = await Dio().post(
        Secret.api_user,
        data: {
          "name": name,
          "email": email,
          "password": parol,
          "isAdmin": isAdmin
        },
      );
      debugPrint("StatusMessage: " + res.statusMessage.toString());
      debugPrint("StatusMessage: " + res.statusCode.toString());
      if (res.statusCode == 201) {
        return SignUpUser.fromJson(res.data);
      } else {
        return SignUpUser(email: res.data.toString());
      }
    } catch (e) {
      return SignUpUser(email: "Mavjud bo'lgan foydalanuvchi");
    }
  }

  signInUser(
    String email,
    String parol,
  ) async {
    try {
      Response res = await Dio().post(
        Secret.api_auth,
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
    } on DioError catch (e) {
      p(e.response!.data);

      throw Exception("UserService signInUser: " + e.toString());
    }
  }
}
