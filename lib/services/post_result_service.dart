import 'package:dio/dio.dart';
import 'package:roxcrm/models/result_model.dart';

class ResultService {
  // static String localhost = "192.168.1.29";
static String localhost="192.168.1.6";
  Future<bool> postResult(Result data) async {
    try {
      Response res = await Dio()
          .post("http://$localhost:5000/api/checking_result", data: data);


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
        "http://$localhost:5000/api/checking_result/since?since=${date.millisecondsSinceEpoch}&who=$who",
      );
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
        "http://$localhost:5000/api/checking_result/getByNameAll?who=$who",
      );

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }

  Future<List<Result>> getResultAll() async {
    try {
      Response res =
          await Dio().get("http://$localhost:5000/api/checking_result/all");

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }
  Future<List<Result>> getResultByNameInterval(DateTime from,DateTime to) async {
    try {
      Response res =
          await Dio().get("http://$localhost:5000/api/checking_result/getByName/interval?from=${from.millisecondsSinceEpoch}&to=${to.millisecondsSinceEpoch}");

      return ((res.data as List).map((e) => Result.fromJson(e)).toList());
    } catch (e) {
      throw Exception("ResultService getResultSince:" + e.toString());
    }
  }
}