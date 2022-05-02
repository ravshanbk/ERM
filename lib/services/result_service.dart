import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roxcrm/config/env.dart';
import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/models/result_model.dart';

class ResultService {
 
  String token = Boxes.getUserHive().getAt(0)!.authToken;

  Future<bool> postResult(Result data) async {
    debugPrint("PostResult: " + token);
    try {
      Response res = await Dio().post(Secret.api_criteria,
          data: data,
          options: Options(
              headers: {"x-auth-token": token.substring(1, token.length - 1)}));

      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<Result>> getResultsSince(DateTime date, String who) async {
    try {
      Response res = await Dio().get(
          "${Secret.api_criteria}/since?since=${date.millisecondsSinceEpoch}&who=$who",
          options: Options(
              headers: {"x-auth-token": token.substring(1, token.length - 1)}));
      List<Result> a =
          (res.data as List).map((e) => Result.fromJson(e)).toList();
      return a;
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }

  Future<List<Result>> getResultAllByName(String who) async {
    try {
      Response res = await Dio().get(
          "${Secret.api_criteria}/getByNameAll?who=$who",
          options: Options(
              headers: {"x-auth-token": token.substring(1, token.length - 1)}));

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }

  Future<List<Result>> getResultAll() async {
    try {
      Response res = await Dio().get("${Secret.api_criteria}/all",
          options: Options(
              headers: {"x-auth-token": token.substring(1, token.length - 1)}));

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }

  Future<List<Result>> getResultByNameInterval(
      DateTime from, DateTime to, String who) async {
    try {
      Response res = await Dio().get(
          "${Secret.api_criteria}/getByName/interval?from=${from.millisecondsSinceEpoch}&to=${to.millisecondsSinceEpoch}&who=$who",
          options: Options(
              headers: {"x-auth-token": token.substring(1, token.length - 1)}));

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }
}
