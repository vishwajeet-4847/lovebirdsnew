import 'dart:convert';

import 'package:figgy/pages/host_live_stream/model/create_host_live_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class CreateHostLiveApi {
  static CreateHostLiveModel? createHostLiveModel;

  static Future<CreateHostLiveModel?> callApi({
    required String hostId,
    required String channel,
    required String agoraUID,
  }) async {
    final uri = Uri.parse("${Api.createHostLive}?hostId=$hostId&channel=$channel&agoraUID=$agoraUID");

    Utils.showLog("Create Host Live Response => $uri");

    final headers = {
      Api.key: Api.secretKey,
      // Api.tokenKey: "Bearer $token",
      // Api.uidKey: uid,
    };

    try {
      final response = await http.post(uri, headers: headers);
      Utils.showLog("Create Host Live Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Create Host Live Response => ${response.body}");

        createHostLiveModel = CreateHostLiveModel.fromJson(jsonResponse);
        return createHostLiveModel;
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showToast(jsonResponse["message"]);
      }
    } catch (e) {
      Utils.showLog("Create Host Live Api Error => $e");
    }

    return null;
  }
}
