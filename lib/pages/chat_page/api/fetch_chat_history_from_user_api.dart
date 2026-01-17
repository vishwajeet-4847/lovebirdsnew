import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/chat_page/model/fetch_chat_history_from_user_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class FetchChatHistoryFromUserApi {
  static FetchChatHistoryFromUserModel? fetchChatHistoryFromUserModel;
  static int startUserPagination = 0;
  static int limitUserPagination = 20;

  static Future<FetchChatHistoryFromUserModel?> callApi({
    required String receiverId,
    required String token,
    required String uid,
  }) async {
    Utils.showLog("Fetch Chat History FromUser Api Calling...");
    startUserPagination++;
    final userUri = Uri.parse("${Api.getOldChatForUser}?receiverId=$receiverId&start=$startUserPagination&limit=$limitUserPagination");

    final userHeaders = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };

    log("Fetch Chat History FromUser headers => $userHeaders");
    log("Fetch Chat History FromUser Uri => $userUri");
    try {
      final response = await http.get(userUri, headers: userHeaders);
      Utils.showLog("Fetch Chat History FromUser headers => ${response.headers}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        fetchChatHistoryFromUserModel = FetchChatHistoryFromUserModel.fromJson(jsonResponse);

        Utils.showLog("Fetch Chat History FromUser Response => ${response.body}");
        return fetchChatHistoryFromUserModel;
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Fetch Chat History FromUser Response Error => $jsonResponse");
        return null;
      }
    } catch (e) {
      Utils.showLog("Fetch Chat History FromUser Error => $e");
      return null;
    }
  }
}
