import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/host_detail_page/model/get_user_profile_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class GetHostProfileApi {
  static GetHostProfileModel? getHostProfileModel;

  static Future<GetHostProfileModel?> callApi({required String hostId}) async {
    Utils.showLog("Get Host Profile Api Calling...");

    final uri = Uri.parse("${Api.getHostProfile}?hostId=$hostId");
    final headers = {
      Api.key: Api.secretKey,
    };

    log("Get host profile headers => $headers");
    log("Get host profile Uri => $uri");

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog("Get Host Profile Response => ${response.headers}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Host Profile Response => ${response.body}");

        getHostProfileModel = GetHostProfileModel.fromJson(jsonResponse);

        log("impression: ${Database.impression}");
        return getHostProfileModel;
      } else {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Host Profile Response Error => $jsonResponse");

        return null;
      }
    } catch (e) {
      Utils.showLog("Get Host Profile Api Error => $e");

      return null;
    }
  }
}
