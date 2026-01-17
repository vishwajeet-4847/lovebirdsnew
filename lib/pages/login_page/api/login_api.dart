import 'dart:convert';

import 'package:figgy/pages/login_page/model/login_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<LoginModel?> callApi({
    required String name,
    required String image,
    required String email,
    required String identity,
    required String fcmToken,
    required String token,
    required String uid,
    required int loginType,
    required String country,
    required String countryFlagImage,
  }) async {
    Utils.showLog("Login Api Calling...");

    final uri = Uri.parse(Api.signInOrSignUp);

    final headers = {
      Api.key: Api.secretKey,
      "Content-Type": "application/json",
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };

    final body = json.encode({
      'loginType': loginType,
      "fcmToken": fcmToken,
      'identity': identity,
      'email': email,
      'name': name,
      'image': image,
      'country': country,
      'countryFlagImage': countryFlagImage,
      'dob': '12/06/2025',
    });

    try {
      Utils.showLog("Login Api Uri => $uri");
      Utils.showLog("Login Api Headers => $headers");
      Utils.showLog("Login Api Body => $body");

      final response = await http.post(uri, headers: headers, body: body);
      Utils.showLog("Login Api Response => ${response.body}");

      final jsonResponse = json.decode(response.body);
      return LoginModel.fromJson(jsonResponse);
    } catch (error) {
      Utils.showToast("Something went wrong");
      Utils.showLog("Login Api Error => $error");
    }
    return null;
  }
}
