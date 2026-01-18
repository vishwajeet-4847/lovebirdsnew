import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/random_match_page/model/get_available_host_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class GetAvailableHostApi {
  static GetAvailableHostModel? getAvailableHostModel;

  static Future<GetAvailableHostModel?> callApi(
      {required String gender,
      required String token,
      required String uid}) async {
    Utils.showLog("Get Available Host Api Calling...");
    try {
      final uri =
          Uri.parse("${Api.getAvailableHostForRandomMatch}?gender=$gender");
      log("Get Available Host Api Uri => $uri");

      final headers = {
        Api.key: Api.secretKey,
        Api.tokenKey: "Bearer $token",
        Api.uidKey: uid
      };
      log("Get Available Host Api headers => $headers");

      final response = await http.get(uri, headers: headers);
      log("Get Available Host Api StatusCode => ${response.statusCode}");
      log("Get Available Host Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        getAvailableHostModel = GetAvailableHostModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Available Host Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Available Host Error => $e");
      return null;
    }
    return getAvailableHostModel;
  }
}
