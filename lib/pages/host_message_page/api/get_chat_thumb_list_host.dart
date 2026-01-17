import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/host_message_page/model/get_chat_thumb_list_host_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:http/http.dart' as http;

class GetChatThumbListHostApi {
  static GetChatThumbListHostModel? getChatThumbListHostModel;
  static int startPagination = 1;
  static int limitPagination = 20;

  static Future<GetChatThumbListHostModel?> callApi({
    required String token,
    required String uid,
    required String hostId,
  }) async {
    log("startPagination => $startPagination");

    final uri = Uri.parse("${Api.getChatThumbListForHost}?start=$startPagination&limit=$limitPagination&hostId=$hostId");
    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };
    log("Get Chat Thumb List Host Api headers => $headers");
    log("Get Chat Thumb List Host Api Uri => $uri");
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log("Get Chat Thumb List Host Api Response => ${response.body}");
        getChatThumbListHostModel = GetChatThumbListHostModel.fromJson(jsonResponse);

        return getChatThumbListHostModel;
      } else {
        final jsonResponse = json.decode(response.body);
        log("Get Chat Thumb List Host Api Response Error => $jsonResponse");
        return null;
      }
    } catch (e) {
      {
        log("Get Chat Thumb List Host Api Error => $e");
        return null;
      }
    }
  }
}
