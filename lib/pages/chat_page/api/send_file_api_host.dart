import 'dart:convert';
import 'dart:developer';

import 'package:figgy/pages/chat_page/model/host_send_file_api_model.dart';
import 'package:http/http.dart' as http;

import '../../../utils/api.dart';
import '../../../utils/utils.dart';

class HostSendFileApi {
  static Future<HostSendFileApiModel?> callApi({
    required String chatTopicId,
    required String receiverId,
    required String senderId,
    required int messageType,
    required String filePath,
    required String token,
    required String uid,
  }) async {
    Utils.showLog("Host Send File Api Calling...");

    try {
      final headers = {
        Api.key: Api.secretKey,
        Api.tokenKey: "Bearer $token",
        Api.uidKey: uid,
      };

      var request = http.MultipartRequest('POST', Uri.parse(Api.hostSendFile));

      request.fields['chatTopicId'] = chatTopicId;
      request.fields['receiverId'] = receiverId;
      request.fields['senderId'] = senderId;
      request.fields['messageType'] = messageType.toString();

      log("filePath======================= $filePath");

      if (messageType == 2) {
        request.files.add(await http.MultipartFile.fromPath('image', filePath));
      } else {
        request.files.add(await http.MultipartFile.fromPath('audio', filePath));
      }

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        Utils.showLog("Host Send File Api Response => $responseBody");

        final jsonResult = jsonDecode(responseBody);
        return HostSendFileApiModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Host Send File Api Response Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      Utils.showLog("Host Send File Api Error => $e");
      return null;
    }
  }
}
