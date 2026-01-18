import 'dart:convert';

import 'package:LoveBirds/pages/discover_host_for_user_page/model/discover_host_for_user_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class DiscoverHostForUserApi {
  static DiscoverHostForUserModel? discoverHostForUserModel;

  static Future<DiscoverHostForUserModel?> callApi({
    required String country,
    required String uid,
    required String token,
    String? userId,
    int start = 1,
    int limit = 10,
  }) async {
    Utils.showLog("Discover Host For User Api Calling...");

    final uri = Uri.parse(
        "${Api.discoverHostForUser}?country=${country.toLowerCase()}&start=$start&limit=$limit&userId=$userId");
    Utils.showLog("Discover Host For User Uri => $uri");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };
    Utils.showLog("Discover Host For User Header => $headers");

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog(
          "Discover Host For User Api StatusCode => ${response.statusCode}");
      Utils.showLog("Discover Host For User Api Body => ${response.body}");

      if (response.statusCode == 200) {
        discoverHostForUserModel =
            DiscoverHostForUserModel?.fromJson(jsonDecode(response.body));
        return discoverHostForUserModel;
      }
    } catch (e) {
      Utils.showLog("Discover Host For User Api Error => $e");
      return null;
    }
    return null;
  }
}
