// import 'dart:convert';

// import 'package:LoveBirds/pages/splash_screen_page/model/get_setting_model.dart';
// import 'package:LoveBirds/utils/api.dart';
// import 'package:LoveBirds/utils/database.dart';
// import 'package:LoveBirds/utils/utils.dart';
// import 'package:http/http.dart' as http;

// class GetSettingApi {
//   static GetSettingModel? getSettingModel;

//   static Future<GetSettingModel?> getSettingApi({
//     required String token,
//     required String uid,
//   }) async {
//     Utils.showLog("Get Setting Api Calling...");
//     try {
//       final uri = Uri.parse(Api.getSetting);

//       final headers = {
//         Api.key: Api.secretKey,
//         Api.tokenKey: "Bearer $token",
//         Api.uidKey: uid,
//       };

//       Utils.showLog("Get Setting Api headers => $headers");
//       Utils.showLog("Get Setting Api Uri => $uri");

//       final response = await http.get(uri, headers: headers);
//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);

//         Utils.showLog("Get Setting Api Response => ${response.body}");
//         getSettingModel = GetSettingModel.fromJson(jsonResponse);
//         print(
//             "======================${getSettingModel?.data?.agoraAppId}==================== settins check");
//         Database.onSetVideoPrivateCallRate(
//             getSettingModel?.data?.videoPrivateCallRate ?? 0);
//         Database.onSetAudioPrivateCallRate(
//             getSettingModel?.data?.audioPrivateCallRate ?? 0);
//         Database.onSetFemaleRandomCallRate(
//             getSettingModel?.data?.femaleRandomCallRate ?? 0);
//         Database.onSetMaleRandomCallRate(
//             getSettingModel?.data?.maleRandomCallRate ?? 0);
//         Database.onSetGeneralRandomCallRate(
//             getSettingModel?.data?.generalRandomCallRate ?? 0);
//         Database.onSetVideoPrivateCallRate(
//             getSettingModel?.data?.videoPrivateCallRate ?? 0);
//         Database.onSetAudioPrivateCallRate(
//             getSettingModel?.data?.audioPrivateCallRate ?? 0);
//         Database.onSetFemaleRandomCallRate(
//             getSettingModel?.data?.femaleRandomCallRate ?? 0);
//         Database.onSetMaleRandomCallRate(
//             getSettingModel?.data?.maleRandomCallRate ?? 0);
//         Database.onSetGeneralRandomCallRate(
//             getSettingModel?.data?.generalRandomCallRate ?? 0);
//         Database.onAgoraAppId(getSettingModel?.data?.agoraAppId ?? "");
//         Database.onAgoraAppCertificate(
//             getSettingModel?.data?.agoraAppCertificate ?? "");
//         Database.onSetChatRate(getSettingModel?.data?.chatInteractionRate ?? 0);
//         Database.onSetMinCoinsToConvert(
//             getSettingModel?.data?.minCoinsToConvert ?? 0);
//         Database.onSetUrl(getSettingModel?.data?.privacyPolicyLink ?? "");
//         Database.onSetTermsAndConditions(
//             getSettingModel?.data?.termsOfUsePolicyLink ?? "");
//         Database.onSetPrivacyPolicy(
//             getSettingModel?.data?.privacyPolicyLink ?? "");
//         Database.onCallInitiatedAt(getSettingModel?.data?.callInitiatedAt ?? 1);
//         Database.onSetIsAutoRefreshEnabled(
//             getSettingModel?.data?.isAutoRefreshEnabled ?? true);
//         Database.onSetCurrencyCode(
//             getSettingModel?.data?.currency?.symbol ?? "\$");
//       } else {
//         Utils.showLog("Get Setting Api Response Error");
//         return null;
//       }
//     } catch (e) {
//       Utils.showLog("Get Setting Error => $e");
//       return null;
//     }
//     return getSettingModel;
//   }
// }

import 'dart:convert';

import 'package:LoveBirds/pages/splash_screen_page/model/get_setting_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class GetSettingApi {
  static GetSettingModel? getSettingModel;

  static Future<GetSettingModel?> getSettingApi({
    required String token,
    required String uid,
  }) async {
  
    Utils.showLog("Get Setting Api Calling...");

    try {
      final uri = Uri.parse(Api.getSetting);
      

      final headers = {
        Api.key: Api.secretKey,
        Api.tokenKey: "Bearer $token",
        Api.uidKey: uid,
      };
   
      Utils.showLog("Get Setting Api headers => $headers");

      final response = await http.get(uri, headers: headers);

     
      if (response.statusCode == 200) {
        try {
          final jsonResponse = json.decode(response.body);



          getSettingModel = GetSettingModel.fromJson(jsonResponse);

       
        } catch (e, stack) {
          print("❌ [GetSettingApi] Exception during parsing: $e");
          print(stack);
        }
        // Save settings to Database
        Database.onSetVideoPrivateCallRate(
            getSettingModel?.data?.videoPrivateCallRate ?? 0);
        Database.onSetAudioPrivateCallRate(
            getSettingModel?.data?.audioPrivateCallRate ?? 0);
        Database.onSetFemaleRandomCallRate(
            getSettingModel?.data?.femaleRandomCallRate ?? 0);
        Database.onSetMaleRandomCallRate(
            getSettingModel?.data?.maleRandomCallRate ?? 0);
        Database.onSetGeneralRandomCallRate(
            getSettingModel?.data?.generalRandomCallRate ?? 0);
        Database.onAgoraAppId(getSettingModel?.data?.agoraAppId ?? "");
        Database.onAgoraAppCertificate(
            getSettingModel?.data?.agoraAppCertificate ?? "");
        Database.onSetChatRate(getSettingModel?.data?.chatInteractionRate ?? 0);
        Database.onSetMinCoinsToConvert(
            getSettingModel?.data?.minCoinsToConvert ?? 0);
        Database.onSetUrl(getSettingModel?.data?.privacyPolicyLink ?? "");
        Database.onSetTermsAndConditions(
            getSettingModel?.data?.termsOfUsePolicyLink ?? "");
        Database.onSetPrivacyPolicy(
            getSettingModel?.data?.privacyPolicyLink ?? "");
        Database.onCallInitiatedAt(getSettingModel?.data?.callInitiatedAt ?? 1);
        Database.onSetIsAutoRefreshEnabled(
            getSettingModel?.data?.isAutoRefreshEnabled ?? true);
        Database.onSetCurrencyCode(
            getSettingModel?.data?.currency?.symbol ?? "\$");

        print("🟢 [GetSettingApi] All settings saved to Database");
      } else {
        print("❌ [GetSettingApi] Response Error: ${response.statusCode}");
        Utils.showLog("Get Setting Api Response Error");
        return null;
      }
    } catch (e) {
      print("❌ [GetSettingApi] Exception caught: $e");
      Utils.showLog("Get Setting Error => $e");
      return null;
    }

    print("🟢 [GetSettingApi] API call finished successfully");
    return getSettingModel;
  }
}
