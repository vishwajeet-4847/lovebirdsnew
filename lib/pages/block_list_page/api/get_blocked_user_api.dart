import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/block_list_page/model/get_blocked_user_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class GetBlockedUserApi {
  static GetBlockedUserModel? getBlockedUserModel;
  static int startPagination = 1;
  static int limitPagination = 20;
  static Future<GetBlockedUserModel?> callApi({required String hostId}) async {
    Utils.showLog("Get Blocked User Api Calling...");

    final uri = Uri.parse("${Api.getBlockedUserForHost}?start=$startPagination&limit=$limitPagination&hostId=$hostId");
    final headers = {
      Api.key: Api.secretKey,
    };
    log("Get Blocked User Api headers => $headers");
    log("Get Blocked User Api Uri => $uri");

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog("Get Blocked User Api Response => ${response.headers}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Get Blocked User Api Response => ${response.body}");
        getBlockedUserModel = GetBlockedUserModel.fromJson(jsonResponse);
        return getBlockedUserModel;
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Get Blocked User Api Response Error => $jsonResponse");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Blocked User Api Error => $e");
      return null;
    }
  }
}
