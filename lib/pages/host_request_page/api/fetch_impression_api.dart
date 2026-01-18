import 'dart:convert';

import 'package:LoveBirds/pages/host_request_page/model/fetch_impression_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class FetchImpressionApi {
  static FetchImpressionModel? fetchImpressionModel;

  static Future<FetchImpressionModel?> callApi() async {
    final uri = Uri.parse(Api.getImpressionForHost);
    final headers = {
      Api.key: Api.secretKey,
    };

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog("Get Impression Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Get Impression Response => ${response.body}");
        fetchImpressionModel = FetchImpressionModel.fromJson(jsonResponse);
        return fetchImpressionModel;
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showToast(jsonResponse["message"]);
      }
    } catch (e) {
      Utils.showLog("Get Impression Error => $e");
    }
    return null;
  }
}
