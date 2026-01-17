import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/withdraw_page/model/create_withdraw_request_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/database.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class WithdrawalRequestApi {
  static CreateWithdrawRequestModel? createWithdrawRequestModel;

  static Future<CreateWithdrawRequestModel?> callApi({
    required String token,
    required String uid,
    required String coin,
    required String paymentGateway,
    required Map<String, String> paymentDetails, // ✅ parameter name added
  }) async {
    Utils.showLog("Withdrawal Request Api Calling...");
    try {
      final uri = Uri.parse("${Api.createWithdrawalRequest}?hostId=${Database.hostId}");
      final headers = {
        Api.key: Api.secretKey,
        Api.tokenKey: "Bearer $token",
        Api.uidKey: uid,
        "Content-Type": "application/json; charset=UTF-8",
      };

      final body = json.encode({
        'paymentGateway': paymentGateway,
        "paymentDetails": paymentDetails,
        'coin': int.parse(coin), // ✅ coin as int
      });

      log("Withdrawal Request Api headers => $headers");
      log("Withdrawal Request Api body => $body");
      log("Withdrawal Request Api Uri => $uri");

      final response = await http.post(uri, headers: headers, body: body);

      log("Withdrawal Request Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        createWithdrawRequestModel = CreateWithdrawRequestModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Withdrawal Request Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Withdrawal Request Api Error => $e");
      return null;
    }
    return createWithdrawRequestModel;
  }
}
