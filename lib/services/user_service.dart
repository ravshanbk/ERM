import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:roxcrm/config/env.dart';
import 'package:roxcrm/hive/userhive_hive.dart';
import 'package:roxcrm/models/response_model.dart';
import 'package:roxcrm/models/user/sign_up_user_model.dart';
import 'package:roxcrm/models/user/user_auth_model.dart';


class UserService {
  Future<SignedUpUser> signUpUser(UserToSignUp user) async {
    try {
      Response res = await Dio().post(
        "${Secret.api_url}/user",
        data: user.toJson(),
      );
      SignedUpUser data = SignedUpUser.fromJson(res.data);

      return data;
    } catch (e) {
      return SignedUpUser(email: "Mavjud bo'lgan foydalanuvchi");
    }
  }

  Future<ResModel> signInUser(
    String email,
    String parol,
  ) async {
    try {
      Response res = await Dio().post(
        "${Secret.api_url}/auth",
        data: {
          "email": email,
          "password": parol,
        },
      );
      UserAuth data = UserAuth.fromJson(res.data);

     
      UserHiveService().saveUser(
        authToken: res.headers["x-auth-token"]
            .toString()
            .substring(1, res.headers["x-auth-token"].toString().length - 1),
        email: data.email!,
        name: data.name!,
      );
      return ResModel(success: true, text: "Muvaffaqiyat!!");
    } on DioError catch (e) {
      return ResModel(success: false, text: e.response!.data.toString());
    }
  }

  Future<ResModel> deleteUser(String who) async {
    try {
      // ignore: unused_local_variable
      Response res =
          await Dio().delete("${Secret.api_url}/user/one?who=$who");

      return ResModel(success: true, text: "Muvaffaqiyat!!!");
    } on DioError catch (e) {
      return ResModel(success: false, text: e.response!.data!.toString());
    }
  }
}
