

import 'dart:convert';

import 'package:figgy/pages/splash_screen_page/model/get_policy_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class GetPolicyApi {
  static GetPolicyModel? getPolicyModel;

  static Future<GetPolicyModel?> callApi() async {
    Utils.showLog("Get Policy And Conditions Api Calling...");
    try {
      final uri = Uri.parse(Api.getPolicyAndCondition);

      final headers = {
        Api.key: Api.secretKey,
      };

      Utils.showLog("Get Policy Api headers => $headers");
      Utils.showLog("Get Policy Api Uri => $uri");

      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Get Policy Api Response => ${response.body}");
        getPolicyModel = GetPolicyModel.fromJson(jsonResponse);

        return getPolicyModel;
      } else {
        Utils.showLog("Get Policy Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Policy Error => $e");
      return null;
    }
  }
}
