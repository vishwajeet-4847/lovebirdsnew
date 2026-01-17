import 'dart:convert';

import 'package:figgy/pages/message_page/model/get_chat_thumb_list_user_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class GetChatThumbListUser {
  static GetChatThumbListUserModel? getChatThumbListUserModel;
  static int startPagination = 1;
  static int limitPagination = 20;

  static Future<GetChatThumbListUserModel?> callApi({
    required String token,
    required String uid,
  }) async {
    final uri = Uri.parse("${Api.getChatThumbListForUser}?start=$startPagination&limit=$limitPagination");
    Utils.showLog("Get Chat Thumb List User Api Uri => $uri");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };
    Utils.showLog("Get Chat Thumb List User Api headers => $headers");

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Get Chat Thumb List User Api StatusCode => ${response.statusCode}");
      Utils.showLog("Get Chat Thumb List User Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        getChatThumbListUserModel = GetChatThumbListUserModel.fromJson(jsonResponse);

        return getChatThumbListUserModel;
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Get Chat Thumb List User Api Response Error => $jsonResponse");
        return null;
      }
    } catch (e) {
      {
        Utils.showLog("Get Chat Thumb List User Api Error => $e");
        return null;
      }
    }
  }
}
