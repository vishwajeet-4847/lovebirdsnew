import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/utils/api.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class FakeLiveChatGiftApi {
  static Future callApi({
    required String token,
    required String uid,
    required String senderId,
    required String receiverId,
    required String giftId,
    required String type,
    required String giftCount,
  }) async {
    Utils.showLog("Fake live chat gift Api Calling...");
    try {
      final uri = Uri.parse(Api.fakeLiveChatGift);
      final headers = {
        Api.key: Api.secretKey,
        Api.tokenKey: "Bearer $token",
        Api.uidKey: uid,
        "Content-Type": "application/json; charset=UTF-8",
      };

      final body = json.encode({
        'senderId': senderId,
        "receiverId": receiverId,
        'giftId': giftId,
        'giftCount': giftCount,
        'type': type,
      });

      log("Fake live chat gift Api headers => $headers");
      log("Fake live chat gift Api body => $body");
      log("Fake live chat gift Api Uri => $uri");

      final response = await http.post(uri, headers: headers, body: body);

      log("Fake live chat gift Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // createWithdrawRequestModel = CreateWithdrawRequestModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fake live chat gift Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Fake live chat gift Api Error => $e");
      return null;
    }
    return null;
  }
}
