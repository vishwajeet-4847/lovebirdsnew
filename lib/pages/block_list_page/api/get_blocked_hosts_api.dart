import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/block_list_page/model/get_blocked_hosts_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class GetBlockedHostsApi {
  static GetBlockedHostsModel? getBlockedHostsModel;
  static int startPagination = 1;
  static int limitPagination = 20;

  static Future<GetBlockedHostsModel?> callApi(
      {required String token, required String uid}) async {
    Utils.showLog("Get Blocked Host Api Calling...");

    final uri = Uri.parse(
        "${Api.getBlockedHostForUser}?start=$startPagination&limit=$limitPagination");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };
    log("Get Blocked Host Api headers => $headers");
    log("Get Blocked Host Api Uri => $uri");

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog("Get Blocked Host Api Response => ${response.headers}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Get Blocked Host Api Response => ${response.body}");

        getBlockedHostsModel = GetBlockedHostsModel.fromJson(jsonResponse);
        return getBlockedHostsModel;
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Get Blocked Host Api Response Error => $jsonResponse");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Blocked Host Api Error => $e");
      return null;
    }
  }
}
