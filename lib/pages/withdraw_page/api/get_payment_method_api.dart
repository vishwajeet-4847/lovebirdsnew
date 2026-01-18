import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/withdraw_page/model/get_paymet_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class GetPaymentMethodApi {
  static GetPaymentModel? getPaymentModel;
  static Future<GetPaymentModel?> callApi(
      {required String token, required String uid}) async {
    Utils.showLog("Get Payment Method Api Calling...");
    try {
      final uri = Uri.parse(Api.getPaymentMethodsApi);
      final headers = {
        Api.key: Api.secretKey,
        Api.tokenKey: "Bearer $token",
        Api.uidKey: uid,
      };
      log("Get Payment Method Api headers => $headers");
      log("Get Payment Method Api Uri => $uri");
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log("Get Payment Method Api Response => ${response.body}");
        getPaymentModel = GetPaymentModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Payment Method Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Payment Method Api Error => $e");
      return null;
    }
    return getPaymentModel;
  }
}
