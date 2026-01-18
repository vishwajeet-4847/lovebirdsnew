import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/chat_page/model/gift_category_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:http/http.dart' as http;

import '../../../utils/utils.dart';

class AllGiftCategoriesApi {
  static GiftCategoryModel? giftCategoryModel;
  static Future<GiftCategoryModel?> callApi(
      {required String token, required String uid}) async {
    Utils.showLog("All Gift Categories Api Calling...");
    try {
      final uri = Uri.parse(Api.getGiftCategories);
      final headers = {
        Api.key: Api.secretKey,
        Api.tokenKey: "Bearer $token",
        Api.uidKey: uid
      };
      log("Get All Gift Categories Api headers => $headers");
      log("Get All Gift Categories Api Uri => $uri");
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log("Get All Gift Categories Api Response => ${response.body}");
        giftCategoryModel = GiftCategoryModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("All Gift Categories Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("All Gift Categories Api Error => $e");
      return null;
    }
    return giftCategoryModel;
  }
}
