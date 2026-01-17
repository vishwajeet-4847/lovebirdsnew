import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/host_request_page/model/host_request_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class HostRequestApi {
  static Future<HostRequestModel?> callApi({
    required String fcmToken,
    required String token,
    required String uid,
    required String name,
    required String email,
    required String bio,
    required String dob,
    required String gender,
    required String country,
    required String countryFlagImage,
    required String agencyCode,
    required String language,
    required String identityProofType,
    required String impression,
    required List<dynamic> photoGallery,
    required List<dynamic> identityProof,
    required List<dynamic> profileVideo,
  }) async {
    Utils.showLog("Host Request Api Calling...");

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Api.createHostRequest),
      );

      final headers = {Api.key: Api.secretKey, "Content-Type": "application/json", Api.tokenKey: "Bearer $token", Api.uidKey: uid};

      request.fields.addAll({
        'fcmToken': fcmToken,
        "email": email,
        'name': name,
        'bio': bio,
        'dob': dob,
        'gender': gender,
        'countryFlagImage': countryFlagImage,
        'country': country,
        'impression': impression,
        'agencyCode': agencyCode,
        'language': language,
        'identityProofType': identityProofType
      });

      for (int i = 0; i < photoGallery.length; i++) {
        final path = photoGallery[i];
        if (path != null && path.isNotEmpty) {
          request.files.add(await http.MultipartFile.fromPath('photoGallery', path));
        }
      }

      for (int i = 0; i < identityProof.length; i++) {
        final path = identityProof[i];
        log("path => $path");
        if (path.isNotEmpty) {
          request.files.add(
            await http.MultipartFile.fromPath('identityProof', path),
          );
        }
      }

      for (int i = 0; i < profileVideo.length; i++) {
        final profileVideoPath = profileVideo[i];
        if (profileVideoPath.isNotEmpty) {
          request.files.add(
            await http.MultipartFile.fromPath('profileVideo', profileVideoPath),
          );
        }
      }

      request.files.add(await http.MultipartFile.fromPath('image', photoGallery[0] ?? ""));
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Utils.showLog("Host Request Api Status => ${response.statusCode}");
      Utils.showLog("Host Request Api response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(response.body); // ✅ directly use response.body
        Utils.showLog("Host Request Api Response => $jsonResult");
        return HostRequestModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Host Request Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Host Request Api Error => ${e.toString()}");
    }
    return null;
  }
}
