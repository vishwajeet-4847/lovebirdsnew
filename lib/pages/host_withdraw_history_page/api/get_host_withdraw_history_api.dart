import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/host_withdraw_history_page/model/get_host_withdraw_history_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class GeHostWithdrawHistoryApi {
  static GetHostWithdrawHistoryModel? getHostWithdrawHistoryModel;
  static int startPagination = 1;
  static int limitPagination = 20;

  static Future<GetHostWithdrawHistoryModel?> callApi({
    required String hostId,
    required String startDate,
    required String endDate,
  }) async {
    Utils.showLog("Get Host Withdraw History Api Calling...");

    final uri = Uri.parse(
        "${Api.getHostWithdrawHistory}?hostId=$hostId&start=$startPagination&limit=$limitPagination&startDate=$startDate&endDate=$endDate&status=All");
    log("Get Host Withdraw History Api URL => $uri");

    final headers = {Api.key: Api.secretKey};
    log("Get Host Withdraw History Api headers => $headers");

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog(
          "Get Host Withdraw History Api Response => ${response.headers}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Utils.showLog(
            "Get Host Withdraw History Api Response => ${response.body}");

        getHostWithdrawHistoryModel =
            GetHostWithdrawHistoryModel.fromJson(jsonResponse);
        return getHostWithdrawHistoryModel;
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showLog(
            "Get Host Withdraw History Api Response Error => $jsonResponse");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Host Withdraw History Api Error => $e");
      return null;
    }
  }
}
