import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/chat_page/model/usre_block_host_api.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class UserBlockHostApi {
  static UserBlockHostApiModel? userBlockHostApiModel;

  static Future<UserBlockHostApiModel?> callApi({required String hostId, required String token, required String uid}) async {
    Utils.showLog("User Block Host Api Calling...");

    final uri = Uri.parse("${Api.userBlockHost}?hostId=$hostId");
    log("User Block Host Api URL => $uri");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };
    log("User BlockHost Api headers => $headers");

    try {
      final response = await http.post(uri, headers: headers);
      Utils.showLog("User BlockHost Api Status Code => ${response.statusCode}");
      Utils.showLog("User BlockHost Api Response => ${response.body}");

      final jsonResponse = json.decode(response.body);
      userBlockHostApiModel = UserBlockHostApiModel.fromJson(jsonResponse);

      return userBlockHostApiModel;
    } catch (e) {
      Utils.showLog("User Block Host Api Error => $e");
      return null;
    }
  }
}
