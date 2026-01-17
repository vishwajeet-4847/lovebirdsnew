import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/host_request_page/model/get_identity_proof_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class GetIdentityProof {
  static GetIdentityProofModel? getIdentityProofModel;
  static Future<GetIdentityProofModel?> callApi() async {
    try {
      final uri = Uri.parse(Api.getIdentityProofTypesForHost);

      final headers = {Api.key: Api.secretKey};

      log("Get Identity Proof Api headers => $headers");

      log("Get Identity Proof Api Uri => $uri");

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log("Get Identity Proof Api Response => ${response.body}");

        getIdentityProofModel = GetIdentityProofModel.fromJson(jsonResponse);
        return getIdentityProofModel;
      } else {
        final jsonResponse = json.decode(response.body);
        log("Get Identity Proof Api Response Error => $jsonResponse");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Identity Proof Api Error => $e");
      return null;
    }
  }
}
