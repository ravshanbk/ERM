import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/models/response_model.dart';
import 'package:roxcrm/models/result_model.dart';

class ResultService {
  // String localhost = "http://192.168.1.2:5000/api";
  static String localhost = "https://roxerm.herokuapp.com/api";
  String token = Boxes.getUserHive().getAt(0)!.authToken;

  Future<ResModel> postResult(Result data) async {
    try {
      Response res = await Dio().post(
        "$localhost/checking_results",
        options: Options(headers: {"x-auth-token":token}),
        data: data.toJson(),
      );
      debugPrint(res.data.toString());
      return ResModel(success: true, text: "Muvaffaqiyat!!!");
    }on DioError catch (e) {
      return ResModel(success: false, text:e.response!.data!.toString());
    }
  }

  Future<List<Result>> getResultsSinceByName(DateTime date, String who) async {
    try {
      Response res = await Dio().get(
          "$localhost/checking_results/since?since=${DateTime(date.year,date.month,date.day).millisecondsSinceEpoch}&who=$who",
          options: Options(
              headers: {"x-auth-token": token.substring(1, token.length - 1)}));
      List<Result> a =
          (res.data as List).map((e) => Result.fromJson(e)).toList();
      return a;
      // return List.generate(
      //     5,
      //     (index) => Result(
      //         id: "Id",
      //         result: List.generate(
      //             5,
      //             (index) => ResultElement(
      //                 context: "context",
      //                 done: index % 2 == 0,
      //                 letter: "$index")),
      //         v: 12,
      //         when: 12,
      //         who: "who"));
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }

  Future<List<Result>> getResultAllByName(String who) async {
    try {
      Response res = await Dio().get(
          "$localhost/checking_results/getByNameAll?who=$who",
          options: Options(
              headers: {"x-auth-token": token.substring(1, token.length - 1)}));

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());

      // return List.generate(
      //     5,
      //     (index) => Result(
      //         id: "Id",
      //         result: List.generate(
      //             5,
      //             (index) => ResultElement(
      //                 context: "context",
      //                 done: index % 2 == 0,
      //                 letter: "$index")),
      //         v: 12,
      //         when: 12,
      //         who: "who"));
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }

  Future<List<Result>> getResultAll() async {
    try {
      Response res = await Dio().get("$localhost/checking_results/all",
          options: Options(
              headers: {"x-auth-token": token.substring(1, token.length - 1)}));

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());
      // return List.generate(
      //     5,
      //     (index) => Result(
      //         id: "Id",
      //         result: List.generate(
      //             5,
      //             (index) => ResultElement(
      //                 context: "context",
      //                 done: index % 2 == 0,
      //                 letter: "$index")),
      //         v: 12,
      //         when: 12,
      //         who: "who"));
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }

  Future<List<Result>> getResultByNameInterval(
     {required DateTime from, required DateTime to,
      required String who}) async {
     try {
      Response res = await Dio().get(
          "$localhost/checking_results/getByName/interval?from=${DateTime(from.year,from.month,from.day,).millisecondsSinceEpoch}&to=${DateTime(to.year,to.month,to.day+1).millisecondsSinceEpoch}&who=$who",
          options: Options(
              headers: {"x-auth-token": token.substring(1, token.length - 1)}));

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());
      // return List.generate(
      //     5,
      //     (index) => Result(
      //         id: "Id",
      //         result: List.generate(
      //             5,
      //             (index) => ResultElement(
      //                 context: "context",
      //                 done: index % 2 == 0,
      //                 letter: "$index")),
      //         v: 12,
      //         when: 12,
      //         who: "who"));
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }
}
