import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/vip_page/model/vip_plan_privilege_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class VipPlanPrivilegeApi {
  static VipPlanPrivilegeModel? vipPlanPrivilegeModel;

  static Future<VipPlanPrivilegeModel?> callApi() async {
    Utils.showLog("Get Vip Privilege Api Calling...");
    try {
      final uri = Uri.parse(Api.getVipPrivilege);
      log("Get Vip Privilege Api Uri => $uri");

      final headers = {Api.key: Api.secretKey};
      log("Get Vip Privilege Api headers => $headers");

      final response = await http.get(uri, headers: headers);
      log("Get Vip Privilege Api StatusCode => ${response.statusCode}");
      log("Get Vip Privilege Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log("Get Vip Privilege Api Response => ${response.body}");
        vipPlanPrivilegeModel = VipPlanPrivilegeModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Vip Privilege Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Get Vip Privilege Api Error => $e");
      return null;
    }
    return vipPlanPrivilegeModel;
  }
}
