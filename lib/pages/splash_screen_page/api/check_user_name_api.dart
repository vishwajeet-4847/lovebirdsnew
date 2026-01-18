import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/splash_screen_page/model/check_user_name_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class CheckUserApi {
  static Future<CheckUserModel?> callApi({
    required String identity,
  }) async {
    Utils.showLog("Check User Name Api Calling...");

    final uri = Uri.parse(
      "${Api.checkUserNameExit}?identity=$identity",
    );
    Utils.showLog("Check User identity => $identity");

    Utils.showLog("Check User Name Api Response => $uri");

    final headers = {
      Api.key: Api.secretKey,
      'authorization': 'Bearer ${Database.fcmToken}',
    };

    try {
      final response = await http.post(uri, headers: headers);
      log("Check User  Api Response => ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Check User StateCode => ${response.body}");

        return CheckUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Check User Name Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Check User Name Api Error => $error");
    }
    return null;
  }
}
