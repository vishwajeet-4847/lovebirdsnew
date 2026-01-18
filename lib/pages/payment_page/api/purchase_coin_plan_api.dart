import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/pages/top_up_page/model/purchase_coin_plan_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PurchaseCoinPlanApi {
  static PurchaseCoinPlanModel? purchaseCoinPlanModel;
  static Future<PurchaseCoinPlanModel?> callApi({
    required String token,
    required String uid,
    required String coinPlanId,
    required String paymentGateway,
  }) async {
    Utils.showLog("Purchase Coin Plan Api Calling......");
    final uri = Uri.parse(
        "${Api.purchaseCoinPlan}?coinPlanId=$coinPlanId&paymentGateway=$paymentGateway");
    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };
    log("Purchase Coin Plan Api headers => $headers");
    log("Purchase Coin Plan Api Uri => $uri");
    try {
      final response = await http.post(uri, headers: headers);
      Utils.showLog("Purchase Coin Plan Api Response => ${response.headers}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Purchase Coin Plan Api Response => ${response.body}");

        purchaseCoinPlanModel = PurchaseCoinPlanModel.fromJson(jsonResponse);

        Utils.showToast(purchaseCoinPlanModel?.message ?? "");
        Utils.showLog("Purchase Coin Plan Api Response => ${response.body}");
        600.milliseconds.delay();
        await CustomFetchUserCoin.init();
        return purchaseCoinPlanModel;
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Purchase Coin Plan Api Response Error => $jsonResponse");
        return null;
      }
    } catch (e) {
      Utils.showLog("Purchase Coin Plan Api Error => $e");
      return null;
    }
  }
}
