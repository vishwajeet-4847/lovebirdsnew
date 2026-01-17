import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/profile_page/model/earn_coin_from_daily_check_in_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class EarnCoinFromDailyCheckInApi {
  static EarnCoinFromDailyCheckInModel? earnCoinFromDailyCheckInModel;

  static Future<EarnCoinFromDailyCheckInModel?> callApi({
    required String token,
    required String uid,
    required String dailyRewardCoin,
  }) async {
    Utils.showLog("Earn Coin From Daily Check In Api Calling......");

    final uri = Uri.parse("${Api.earnCoinFromDailyCheckIn}?dailyRewardCoin=$dailyRewardCoin");
    log("Earn Coin From Daily Check In Api Uri => $uri");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };
    log("Earn Coin From Daily Check In Api headers => $headers");

    try {
      final response = await http.post(uri, headers: headers);
      Utils.showLog("Earn Coin From Daily Check In Api Status Code :: ${response.statusCode}");
      Utils.showLog("Earn Coin From Daily Check In Api Response :: ${response.body}");

      final jsonResponse = json.decode(response.body);
      earnCoinFromDailyCheckInModel = EarnCoinFromDailyCheckInModel.fromJson(jsonResponse);

      Utils.showToast(earnCoinFromDailyCheckInModel?.message ?? "");

      return earnCoinFromDailyCheckInModel;
    } catch (e) {
      Utils.showLog("Earn Coin From Daily Check In Api Error => $e");
      return null;
    }
  }
}
