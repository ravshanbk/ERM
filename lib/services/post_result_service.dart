import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roxcrm/models/result_model.dart';

class ResultService {
  Future<Result> postResult(Result data) async {
    debugPrint("Post Result Serverga Kirdi");
    try {
      Response res =
          await Dio().post("http://192.168.1.6:5000/api/checking_result", data: data);

      return Result.fromJson(res.data);
    } catch (e) {
      throw Exception("ResultService postResult:" + e.toString());
    }
  }

  Future<List<Result>> getResultsSince(DateTime date) async {
    try {
      Response res = await Dio().post(
        "http://192.168.1.6:5000/api/checking_result/since?since=1639530800000&who=go",
      );

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }
}
