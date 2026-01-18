import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/host_detail_page/model/host_detail_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class HostDetailApi {
  static HostDetailModel? getHostProfileModel;

  static Future<HostDetailModel?> callApi({
    required String hostId,
    required String token,
    required String uid,
  }) async {
    Utils.showLog("Host Detail Api Calling...");

    final uri = Uri.parse("${Api.getHostDetail}?hostId=$hostId");
    log("Host Detail URL => $uri");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };

    log("Host Detail headers => $headers");
    log("Host Detail Uri => $uri");

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog("Host Detail Headers => ${response.headers}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Host Detail Response => ${response.body}");

        getHostProfileModel = HostDetailModel.fromJson(jsonResponse);
        return getHostProfileModel;
      } else {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Host Detail Response Error => $jsonResponse");

        return null;
      }
    } catch (e) {
      Utils.showLog("Host Detail Api Error => $e");

      return null;
    }
  }
}
