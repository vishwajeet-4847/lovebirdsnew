import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/host_detail_page/model/follow_unfollow_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class FollowUnfollowApi {
  static FollowFollowingModel? followFollowModel;

  static Future<FollowFollowingModel?> callApi({required String followingId, required String token, required String uid}) async {
    Utils.showLog("Follow & Unfollow Api Calling...");

    // ================ followingId = HostId ===============

    final uri = Uri.parse("${Api.followOrUnfollow}?followingId=$followingId");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };

    log("Get Follow & Unfollow Uri => $uri");
    try {
      final response = await http.post(uri, headers: headers);
      Utils.showLog("Get Follow & Unfollow Response => ${response.headers}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log("Get Follow & Unfollow jsonResponse => $jsonResponse");
        followFollowModel = FollowFollowingModel.fromJson(jsonResponse);

        Utils.showLog("Get Follow & Unfollow Response => ${response.body}");
        Utils.showToast(jsonResponse["message"]);
        return followFollowModel;
      } else {
        Utils.showLog("Get Follow & Unfollow Response => ${response.body}");

        final jsonResponse = json.decode(response.body);
        Utils.showLog("Get Follow & Unfollow Response => ${response.body}");
        Utils.showToast(jsonResponse["message"]);
        return null;
      }
    } catch (e) {
      Utils.showLog("Follow & Unfollow Api Error => $e");
    }
    return null;
  }
}
