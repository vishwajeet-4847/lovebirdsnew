import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/pages/top_up_page/model/purchase_coin_plan_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PurchaseVipPlanApi {
  static PurchaseCoinPlanModel? purchaseCoinPlanModel;
  static Future<PurchaseCoinPlanModel?> callApi({
    required String token,
    required String uid,
    required String vipPlanId,
    required String paymentGateway,
  }) async {
    Utils.showLog("Purchase Vip Plan Api Calling......");

    final uri = Uri.parse(
        "${Api.purchaseVipPlan}?vipPlanId=$vipPlanId&paymentGateway=$paymentGateway");
    log("Purchase Vip Plan Api Uri => $uri");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };
    log("Purchase Vip Plan Api headers => $headers");

    try {
      final response = await http.post(uri, headers: headers);
      Utils.showLog(
          "Purchase Vip Plan Api StatusCode => ${response.statusCode}");
      Utils.showLog("Purchase Vip Plan Api Response => ${response.body}");

      final jsonResponse = json.decode(response.body);

      purchaseCoinPlanModel = PurchaseCoinPlanModel.fromJson(jsonResponse);

      if (purchaseCoinPlanModel?.status == true) {
        Utils.showToast(purchaseCoinPlanModel?.message ?? "");

        600.milliseconds.delay();
        await CustomFetchUserCoin.init();
      } else {
        Utils.showToast(purchaseCoinPlanModel?.message ?? "");
      }

      return purchaseCoinPlanModel;
    } catch (e) {
      Utils.showLog("Purchase Vip Plan Api Error => $e");
      return null;
    }
  }
}
