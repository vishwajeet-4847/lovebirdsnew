import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/chat_page/model/fetch_chat_history_from_host_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class FetchChatHistoryFromHostApi {
  static FetchChatHistoryFromHostModel? fetchChatHistoryFromHostModel;

  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchChatHistoryFromHostModel?> callApi({
    required String receiverId,
    required String? senderId,
    required String token,
    required String uid,
  }) async {
    Utils.showLog("Fetch Chat History From Host Api Calling...");
    startPagination++;
    log("startPagination => $startPagination");
    final hostUri = Uri.parse("${Api.getOldChatForHost}?senderId=$senderId&receiverId=$receiverId&start=$startPagination&limit=$limitPagination");

    log("hostUri => $hostUri");

    final hostHeaders = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      // Api.uidKey: uid,
    };
    try {
      final response = await http.get(hostUri, headers: hostHeaders);
      Utils.showLog("Fetch Chat History From Host Response => $hostHeaders");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        fetchChatHistoryFromHostModel = FetchChatHistoryFromHostModel.fromJson(jsonResponse);
        Utils.showLog("Fetch Chat History From Host Response => ${response.body}");
        return fetchChatHistoryFromHostModel;
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Fetch Chat History From Host Response Error => $jsonResponse");
        return null;
      }
    } catch (e) {
      Utils.showLog("Fetch Chat History From Host Error => $e");
      return null;
    }
  }
}
