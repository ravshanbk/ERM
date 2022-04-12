import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roxcrm/models/result_model.dart';

class ResultService {
  Future<bool> postResult(Result data) async {
    for (var item in data.result!) {
      debugPrint("letter: ${item.letter!}, ${item.context}, ${item.done} ");
    }
    try {
      Response res = await Dio()
          .post("http://192.168.1.6:5000/api/checking_result", data: data);

      debugPrint(res.statusCode.toString());

      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("ResultService postResult:" + e.toString());
    }
  }

  Future<List<Result>> getResultsSince(DateTime date, String who) async {
    try {
      Response res = await Dio().get(
        "http://192.168.1.6:5000/api/checking_result/since?since=${date.millisecondsSinceEpoch}&who=F",
      );
      List<Result> a =
          (res.data as List).map((e) => Result.fromJson(e)).toList();
      debugPrint(a[0].id);
      return a;
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }

  Future<List<Result>> getResultAllByName(String who) async {
    try {
      Response res = await Dio().post(
        "http://192.168.1.6:5000/api/checking_result/since?&who=$who",
      );

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }

  Future<List<Result>> getResultAll() async {
    try {
      Response res =
          await Dio().post("http://192.168.1.6:5000/api/checking_result/all");

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }
}
