import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/host_request_page/model/validate_agency_code_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class ValidateAgencyCodeApi {
  static ValidateAgencyCodeModel? validateAgencyCodeModel;

  static Future<ValidateAgencyCodeModel?> callApi(
      {required String? agencyCode}) async {
    Utils.showLog("Validate Agency Code Api Calling...");

    final uri =
        Uri.parse("${Api.validateAgencyCodeForHost}?agencyCode=$agencyCode");

    log("Validate Agency Code URL :: $uri");

    final headers = {Api.key: Api.secretKey};
    log("Validate Agency Code Headers :: $headers");

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog(
          "Validate Agency Code StatusCode => ${response.statusCode}");
      Utils.showLog("Validate Agency Code Body => ${response.body}");

      final jsonResponse = json.decode(response.body);
      validateAgencyCodeModel = ValidateAgencyCodeModel.fromJson(jsonResponse);

      return validateAgencyCodeModel;
    } catch (e) {
      Utils.showLog("Validate Agency Code Error => $e");
      return null;
    }
  }
}
