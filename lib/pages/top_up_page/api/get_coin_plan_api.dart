import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/top_up_page/model/get_coin_plan_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class GetCoinPlanApi {
  static GetCoinPlanModel? getCoinPlanModel;
  static Future<GetCoinPlanModel?> callApi({
    required String token,
    required String uid,
  }) async {
    Utils.showLog("Get Coin Plan Api Calling...");
    try {
      final uri = Uri.parse(Api.getCoinPlan);
      log("Get Coin Plan Api Uri => $uri");

      final headers = {
        Api.key: Api.secretKey,
        Api.tokenKey: "Bearer $token",
        Api.uidKey: uid,
      };
      log("Get Coin Plan Api headers => $headers");

      final response = await http.get(uri, headers: headers);
      log("Get Coin Plan Api StatusCode => ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log("Get Coin Plan Api Response => ${response.body}");
        getCoinPlanModel = GetCoinPlanModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Coin Plan Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Coin Plan Api Error => $e");
      return null;
    }
    return getCoinPlanModel;
  }
}
