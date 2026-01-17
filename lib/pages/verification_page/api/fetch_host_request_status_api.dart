import 'dart:convert';

import 'package:figgy/pages/verification_page/model/fetch_host_request_status_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class FetchHostRequestStatusApi {
  static FetchHostRequestStatusModel? fetchHostRequestStatusModel;

  static Future<FetchHostRequestStatusModel?> callApi({
    required String token,
    required String uid,
  }) async {
    Utils.showLog("Fetch Host Request Api Calling...");

    final uri = Uri.parse(Api.getHostRequestStatus);
    Utils.showLog("Fetch Host Request Uri => $uri");

    final headers = {Api.key: Api.secretKey, Api.tokenKey: "Bearer $token", Api.uidKey: uid};
    Utils.showLog("Fetch Host Request Headers => $headers");

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog("Fetch Host Request Status Code => ${response.statusCode}");
      Utils.showLog("Fetch Host Request Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        fetchHostRequestStatusModel = FetchHostRequestStatusModel.fromJson(jsonResponse);

        return fetchHostRequestStatusModel;
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Fetch Host Request Response Error => $jsonResponse");
        return null;
      }
    } catch (e) {
      Utils.showLog("Fetch Host Request Api Error => $e");
      return null;
    }
  }
}
