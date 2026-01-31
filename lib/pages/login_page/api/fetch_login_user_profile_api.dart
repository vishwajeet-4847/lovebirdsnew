import 'dart:convert';

import 'package:LoveBirds/pages/login_page/model/fetch_login_user_profile_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class FetchLoginUserProfileApi {
  static FetchLoginUserProfileModel? fetchLoginUserProfileModel;

  static Future<FetchLoginUserProfileModel?> callApi({
    required String token,
    required String uid,
  }) async {
    Utils.showLog("Get Login User Profile Api Calling...");

    final uri = Uri.parse(Api.getUserProfile);

    Utils.showLog("Get Login User Profile Response => $uri");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };

    Utils.showLog("headers::::::::::::::::::::::${headers}");
    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Get Login User Profile Response => ${response.body}");

        fetchLoginUserProfileModel =
            FetchLoginUserProfileModel.fromJson(jsonResponse);
        Utils.showLog(
            "User Object => ${jsonEncode(fetchLoginUserProfileModel?.user?.toJson())}");

        Database.onSetHost(fetchLoginUserProfileModel?.user?.isHost ?? false);
        Database.onSetHostId(fetchLoginUserProfileModel?.user?.hostId ?? "");
        Database.onSetVip(fetchLoginUserProfileModel?.user?.isVip ?? false);

        if (fetchLoginUserProfileModel?.hasHostRequest == true) {
          Database.onSetVerification(true);
        } else {
          Database.onSetVerification(false);
        }

        return fetchLoginUserProfileModel;
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showToast(jsonResponse["message"]);
      }
    } catch (e) {
      Utils.showLog("Get Login User Profile Api Error => $e");
    }

    return null;
  }
}
