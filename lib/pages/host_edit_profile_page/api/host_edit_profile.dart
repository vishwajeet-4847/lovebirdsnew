import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:figgy/pages/host_edit_profile_page/model/host_edit_profile_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/utils.dart';
import 'package:http/http.dart' as http;

class HostEditProfileApi {
  static Future<HostEditProfileModel?> callApi({
    required String token,
    required String uid,
    required String? image,
    required String name,
    required String country,
    required String bio,
    required String countryFlagImage,
    required String randomCallRate,
    required String randomCallFemaleRate,
    required String randomCallMaleRate,
    required String privateCallRate,
    required String audioCallRate,
    required String chatRate,
    required String gender,
    required String dob,
    required List<dynamic> impression,
    required List<String> language,
    required List<dynamic> photoGallery,
    required List<String> newProfileVideoPaths,
    required List<dynamic> removeProfileVideoIndex,
    required List<dynamic> removePhotoGalleryIndex,
  }) async {
    Utils.showLog("Host Edit Profile Api Calling...");
    try {
      var headers = {'key': Api.secretKey, Api.tokenKey: "Bearer $token", Api.uidKey: uid, 'Content-Type': 'application/json'};
      Utils.showLog("Edit Profile Api Headers => $headers");

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(Api.hostEditProfile),
      );
      Utils.showLog("Edit Profile Api URL => $request");

      request.fields.addAll({
        'name': name,
        'bio': bio,
        'country': country,
        'countryFlagImage': countryFlagImage,
        'randomCallRate': randomCallRate,
        'randomCallFemaleRate': randomCallFemaleRate,
        'randomCallMaleRate': randomCallMaleRate,
        'privateCallRate': privateCallRate,
        'audioCallRate': audioCallRate,
        'chatRate': chatRate,
        'gender': gender,
        'dob': dob,
        'hostId': Database.hostId,
        'impression': impression.join(','),
        'language': language.join(','),
      });

      if (removeProfileVideoIndex.isNotEmpty) {
        request.fields['removeProfileVideoIndex'] = jsonEncode(removeProfileVideoIndex);
      }

      if (removePhotoGalleryIndex.isNotEmpty) {
        request.fields['removePhotoGalleryIndex'] = jsonEncode(removePhotoGalleryIndex);
      }

      if (image != null && image.isNotEmpty && await File(image).exists()) {
        request.files.add(await http.MultipartFile.fromPath('image', image));
      }

      if (photoGallery.isNotEmpty) {
        for (final path in photoGallery) {
          if (path != null && path.isNotEmpty && await File(path).exists()) {
            request.files.add(await http.MultipartFile.fromPath('photoGallery', path));
          }
        }
      }

      if (newProfileVideoPaths.isNotEmpty) {
        for (final path in newProfileVideoPaths) {
          if (await File(path).exists()) {
            request.files.add(await http.MultipartFile.fromPath('profileVideo', path));
          }
        }
      }

      request.headers.addAll(headers);

      final response = await request.send();

      log("Host Edit Profile Api request.fields => ${request.fields}");
      log("Host Edit Profile Api request.files => ${request.files}");
      log("Host Edit Profile Api Status Code => ${response.statusCode}");
      log("Host Edit Profile Api Response => $response");

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResult = jsonDecode(responseBody);
        Utils.showLog("Host Edit Profile Api Response => $jsonResult");
        return HostEditProfileModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Host Edit Profile Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Host Edit Profile Api Error => $e");
      return null;
    }
  }
}
