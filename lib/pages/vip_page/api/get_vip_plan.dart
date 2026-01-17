import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/vip_page/model/get_vip_plan.dart';
import 'package:http/http.dart' as http;

import '../../../utils/api.dart';
import '../../../utils/utils.dart';

class GetVipPlanApi {
  static GetVipPlanModel? getVipPlanModel;

  static Future<GetVipPlanModel?> callApi({
    required String token,
    required String uid,
  }) async {
    Utils.showLog("Get Vip Plan Api Calling...");
    try {
      final uri = Uri.parse("${Api.getVipPlan}?start=1&limit=20");
      log("Get Vip Plan Api Uri => $uri");

      final headers = {
        Api.key: Api.secretKey,
        Api.tokenKey: "Bearer $token",
        Api.uidKey: uid,
      };
      log("Get Vip Plan Api headers => $headers");

      final response = await http.get(uri, headers: headers);
      log("Get Vip Plan Api StatusCode => ${response.statusCode}");
      log("Get Vip Plan Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        getVipPlanModel = GetVipPlanModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Vip Plan Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Vip Plan Api Error => $e");
      return null;
    }
    return getVipPlanModel;
  }
}
