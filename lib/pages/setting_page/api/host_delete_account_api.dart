import 'dart:convert';
import 'dart:developer';

import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/pages/setting_page/model/host_delete_account_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class HostDeleteAccountApi {
  static Future<HostDeleteAccountModel?> callApi({
    required String hostId,
    required String uid,
  }) async {
    final token = await FirebaseAccessToken.onGet() ?? "";

    Utils.showLog("Host delete account Api Calling...");

    // String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse("${Api.userDeleteAccount}?hostId=$hostId");
    final headers = {Api.key: Api.secretKey, Api.tokenKey: "Bearer $token", Api.uidKey: uid};
    log("Host delete account Api URL ::$uri");

    try {
      final response = await http.delete(uri, headers: headers);

      Utils.showLog("Host delete account Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return HostDeleteAccountModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Host delete account Api StateCode Error");
      }
    } catch (e) {
      Utils.showLog("Host delete account Api Response => ${e.toString()}");
    }
    return null;
  }
}
