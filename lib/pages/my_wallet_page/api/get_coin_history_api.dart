import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/my_wallet_page/model/fetch_coin_history_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class GetUserCoinHistoryApi {
  static FetchCoinHistoryModel? fetchCoinHistoryModel;

  static int startPagination = 1;
  static int limitPagination = 20;

  static Future<FetchCoinHistoryModel?> callApi({
    required String token,
    required String uid,
    required String startDate,
    required String endDate,
  }) async {
    Utils.showLog("Fetch Coin History Api Calling...");
    try {
      final uri = Uri.parse("${Api.getWalletHistoryForUser}?startDate=$startDate&endDate=$endDate&start=$startPagination&limit=$limitPagination");
      final headers = {Api.key: Api.secretKey, Api.tokenKey: "Bearer $token", Api.uidKey: uid};
      log("Fetch Coin History Api headers => $headers");
      log("Fetch Coin History Api Uri => $uri");
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log("Fetch Coin History Api Response => ${response.body}");
        fetchCoinHistoryModel = FetchCoinHistoryModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Coin History Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Fetch Coin History Api Error => $e");
      return null;
    }
    return fetchCoinHistoryModel;
  }
}
