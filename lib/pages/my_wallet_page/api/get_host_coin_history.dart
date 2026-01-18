import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/my_wallet_page/model/fetch_host_coin_history_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class GetHostCoinHistoryApi {
  static FetchHostCoinHistoryModel? fetchHostCoinHistoryModel;
  static int startPagination = 1;
  static int limitPagination = 20;
  static String hostId = Database.hostId;

  static Future<FetchHostCoinHistoryModel?> callApi({
    required String token,
    required String uid,
    required String startDate,
    required String endDate,
  }) async {
    Utils.showLog("Fetch Host Coin History Api Calling...");
    try {
      final uri = Uri.parse(
          "${Api.getWalletHistoryForHost}?start=$startPagination&limit=$limitPagination&hostId=$hostId&startDate=$startDate&endDate=$endDate");

      final headers = {
        Api.key: Api.secretKey,
        Api.tokenKey: "Bearer $token",
        Api.uidKey: uid
      };
      log("Fetch Host Coin History Api headers => $headers");
      log("Fetch Host Coin History Api Uri => $uri");
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log("Fetch Host Coin History Api Response => ${response.body}");
        fetchHostCoinHistoryModel =
            FetchHostCoinHistoryModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Host Coin History Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Fetch Host Coin History Api Error => $e");
      return null;
    }
    return fetchHostCoinHistoryModel;
  }
}
