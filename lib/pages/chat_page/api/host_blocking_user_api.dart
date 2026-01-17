import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/chat_page/model/host_block_user_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class HostBlockingUserApi {
  static HostBlockUserApiModel? hostBlockUserApiModel;

  static Future<HostBlockUserApiModel?> callApi({
    required String hostId,
    required String token,
    required String uid,
    required String userId,
  }) async {
    Utils.showLog("Host Block User Api Calling...");

    final uri = Uri.parse("${Api.hostBlockUser}?hostId=$hostId&userId=$userId");
    log("Host Block User Api URL => $uri");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };
    log("Host Block User Api headers => $headers");

    try {
      final response = await http.post(uri, headers: headers);
      Utils.showLog("Host Block User Api Status Code => ${response.statusCode}");
      Utils.showLog("Host Block User Api Response => ${response.body}");

      final jsonResponse = json.decode(response.body);
      hostBlockUserApiModel = HostBlockUserApiModel.fromJson(jsonResponse);

      return hostBlockUserApiModel;
    } catch (e) {
      Utils.showLog("Host Block User Api Error => $e");
      return null;
    }
  }
}
