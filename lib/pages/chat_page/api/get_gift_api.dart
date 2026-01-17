import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/chat_page/model/get_gift_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class GetGiftApi {
  static GetGiftModel? getGiftModel;
  static Future<GetGiftModel?> callApi({required String token, required String uid, required String giftCategoryId}) async {
    Utils.showLog("Get Gift Api Calling...");
    try {
      final uri = Uri.parse("${Api.getGifts}?giftCategoryId=$giftCategoryId");
      final headers = {Api.key: Api.secretKey, Api.tokenKey: "Bearer $token", Api.uidKey: uid};
      log("Get Gift Api headers => $headers");
      log("Get Gift Api Uri => $uri");
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log("Get Gift Api Response => ${response.body}");
        getGiftModel = GetGiftModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Gift Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Gift Api Error => $e");
      return null;
    }
    return getGiftModel;
  }
}
