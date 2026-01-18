import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/profile_page/model/get_daily_reward_coin_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class GetDailyRewardCoinApi {
  static GetDailyRewardCoinModel? getDailyRewardCoinModel;

  static Future<GetDailyRewardCoinModel?> callApi(
      {required String token, required String uid}) async {
    Utils.showLog("Get Daily Reward Coin Api Calling...");
    final uri = Uri.parse(Api.getDailyRewardCoin);
    log("Get Daily Reward Coin Api URL => $uri");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };
    log("Get Daily Reward Coin Api headers => $headers");

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog(
          "Get Daily Reward Coin Api Status code => ${response.statusCode}");
      Utils.showLog("Get Daily Reward Coin Api Response => ${response.body}");

      final jsonResponse = json.decode(response.body);
      getDailyRewardCoinModel = GetDailyRewardCoinModel.fromJson(jsonResponse);

      return getDailyRewardCoinModel;
    } catch (e) {
      Utils.showLog("Get Daily Reward Coin Api Error => $e");
      return null;
    }
  }
}
