import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/edit_profile_page/model/edit_profile_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class EditProfileApi {
  static Future<EditProfileModel?> callApi({
    required String token,
    required String uid,
    required String loginUserId,
    required String name,
    required String country,
    required String bio,
    required String countryFlagImage,
    required String? image,
    required String date,
  }) async {
    Utils.showLog("Edit Profile Api Calling...");
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse("${Api.editUserProfile}?userId=$loginUserId"),
      );
      Utils.showLog("Edit Profile Api URL => ${request.url}");

      var headers = {'key': Api.secretKey, 'authorization': 'Bearer $token', 'x-user-uid': uid, 'Content-Type': 'application/json'};
      Utils.showLog("Edit Profile Api Headers => $headers");

      request.fields.addAll({
        'name': name,
        'bio': bio,
        'country': country,
        'countryFlagImage': countryFlagImage,
        'dob': date,
      });
      Utils.showLog("Edit Profile Api body => ${request.fields}");

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', image));
      }

      request.headers.addAll(headers);
      log("Edit Profile Api Request => ${request.fields}");

      final response = await request.send();
      log("Edit Profile Api Response => ${response.statusCode}");
      log("Edit Profile Api Status => ${response.statusCode}");

      final responseBody = await response.stream.bytesToString();
      final jsonResult = jsonDecode(responseBody);
      Utils.showLog("Edit Profile Api Response => $jsonResult");

      return EditProfileModel.fromJson(jsonResult);
    } catch (e) {
      Utils.showLog("Edit Profile Api Error => $e");
      return null;
    }
  }
}
