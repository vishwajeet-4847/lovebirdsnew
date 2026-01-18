import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/chat_page/model/user_send_file_api_model.dart';
import 'package:http/http.dart' as http;

import '../../../utils/api.dart';
import '../../../utils/utils.dart';

class UserSendFileApi {
  static Future<UserSendFileApiModel?> callApi({
    required String chatTopicId,
    required String receiverId,
    required int messageType,
    required String filePath,
    required String token,
    required String uid,
  }) async {
    Utils.showLog("Send File Api Calling...");

    try {
      final headers = {
        Api.key: Api.secretKey,
        Api.tokenKey: "Bearer $token",
        Api.uidKey: uid,
      };

      var request = http.MultipartRequest('POST', Uri.parse(Api.userSendFile));

      request.fields['chatTopicId'] = chatTopicId;
      request.fields['receiverId'] = receiverId;
      request.fields['messageType'] = messageType.toString();

      log("filePath======================= $filePath");

      if (messageType == 2) {
        request.files.add(await http.MultipartFile.fromPath('image', filePath));
      } else {
        request.files.add(await http.MultipartFile.fromPath('audio', filePath));
      }
      log("request.fields======================= ${request.fields}");

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        Utils.showLog("Send File Api Response => $responseBody");

        final jsonResult = jsonDecode(responseBody);
        return UserSendFileApiModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Send File Api Response Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      Utils.showLog("Send File Api Error => $e");
      return null;
    }
  }
}
