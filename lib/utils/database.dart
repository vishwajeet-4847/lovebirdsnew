import 'dart:developer';

import 'package:LoveBirds/pages/host_detail_page/model/get_user_profile_model.dart';
import 'package:LoveBirds/pages/login_page/model/fetch_login_user_profile_model.dart';
import 'package:LoveBirds/pages/splash_screen_page/model/get_country_model.dart';
import 'package:LoveBirds/utils/platform_device_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';

import 'constant.dart';

class Database {
  static final localStorage = GetStorage();

  static FetchLoginUserProfileModel? fetchLoginUserProfileModel;
  static GetHostProfileModel? getHostProfileModel;

  static GetCountryModel? getCountryModel;

  static Future<void> init() async {
    String? identity = await PlatformDeviceId.getDeviceId;
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    onSetFcmToken(fcmToken ?? "");
    onSetIdentity(identity ?? "");

    log("loginUserId: $loginUserId");
  }

  // >>>>> >>>>> Network Image Database <<<<< <<<<<

  static onSetNetworkImage(String image) async =>
      localStorage.write(image, image);
  static String? networkImage(String image) => localStorage.read(image);

  // >>>>> >>>>> Is Api Call <<<<< <<<<<

  static onSetIsLiveStreamApiCall(bool isLiveStreamApiCall) async =>
      localStorage.write("isLiveStreamApiCall", isLiveStreamApiCall);
  static bool get isLiveStreamApiCall =>
      localStorage.read("isLiveStreamApiCall") ?? true;

  static bool get isMessageApiCall =>
      localStorage.read("isMessageApiCall") ?? true;
  static onSetIsMessageApiCall(bool isMessageApiCall) async =>
      localStorage.write("isMessageApiCall", isMessageApiCall);

  static bool get isHostLiveStreamApiCall =>
      localStorage.read("isHostLiveStreamApiCall") ?? true;
  static onSetIsHostLiveStreamApiCall(bool isHostLiveStreamApiCall) async =>
      localStorage.write("isHostLiveStreamApiCall", isHostLiveStreamApiCall);

  static bool get isHostMessageApiCall =>
      localStorage.read("isHostMessageApiCall") ?? true;
  static onSetIsHostMessageApiCall(bool isHostMessageApiCall) async =>
      localStorage.write("isHostMessageApiCall", isHostMessageApiCall);

  // >>>>> >>>>> Auto Refresh <<<<< <<<<<

  static onSetIsAutoRefreshEnabled(bool isAutoRefreshEnabled) async =>
      localStorage.write("isAutoRefreshEnabled", isAutoRefreshEnabled);
  static bool get isAutoRefreshEnabled =>
      localStorage.read("isAutoRefreshEnabled") ?? true;

  static onSetFcmToken(String fcmToken) async =>
      await localStorage.write("fcmToken", fcmToken);
  static String get fcmToken => localStorage.read("fcmToken") ?? "";

  static onSetIdentity(String identity) async =>
      await localStorage.write("identity", identity);
  static String get identity => localStorage.read("identity") ?? "";

  static onAgoraAppId(String agoraAppId) async =>
      await localStorage.write("agoraAppId", agoraAppId);
  static String get agoraAppId => localStorage.read("agoraAppId") ?? '';

  static onAgoraAppCertificate(String agoraAppCertificate) async =>
      await localStorage.write("agoraAppCertificate", agoraAppCertificate);
  static String get agoraAppCertificate =>
      localStorage.read("agoraAppCertificate") ?? '';

  static onSetUserProfileImage(String profileImage) async =>
      await localStorage.write("profileImage", profileImage);
  static String get profileImage => localStorage.read("profileImage") ?? "";

  static onSetUserName(String userName) async =>
      await localStorage.write("userName", userName);
  static String get userName => localStorage.read("userName") ?? "";

  static onSetImpression(List<dynamic> impression) async =>
      await localStorage.write("impression", impression);
  static List<dynamic> get impression => localStorage.read("impression") ?? [];

  static onSetLanguage(List<String> language) async =>
      await localStorage.write("language", language);
  static List<String> get language => localStorage.read("language") ?? [];

  static onSetHostAllImage(List<dynamic> hostAllImage) async =>
      await localStorage.write("HostAllImage", hostAllImage);
  static List<dynamic> get hostAllImage =>
      localStorage.read("HostAllImage") ?? [];

  static onSetLastRewardDate(String lastRewardDate) async =>
      await localStorage.write("lastRewardDate", lastRewardDate);
  static String get lastRewardDate => localStorage.read("lastRewardDate") ?? "";

  static onSetEmail(String email) async =>
      await localStorage.write("email", email);
  static String get email => localStorage.read("email") ?? "";

  static onSetUniqueId(String uniqueId) async =>
      await localStorage.write("uniqueId", uniqueId);
  static String get uniqueId => localStorage.read("uniqueId") ?? "";

  static onSetCoin(num dailyCoin) async =>
      await localStorage.write("Coin", dailyCoin);
  static num get coin => localStorage.read("Coin") ?? 0;

  // ================== For call rate ===================
  static onSetVideoPrivateCallRate(num videoPrivateCallRate) async =>
      await localStorage.write("videoPrivateCallRate", videoPrivateCallRate);
  static num get videoPrivateCallRate =>
      localStorage.read("videoPrivateCallRate") ?? 0;

  static onSetAudioPrivateCallRate(num audioPrivateCallRate) async =>
      await localStorage.write("audioPrivateCallRate", audioPrivateCallRate);
  static num get audioPrivateCallRate =>
      localStorage.read("audioPrivateCallRate") ?? 0;

  static onSetFemaleRandomCallRate(num femaleRandomCallRate) async =>
      await localStorage.write("femaleRandomCallRate", femaleRandomCallRate);
  static num get femaleRandomCallRate =>
      localStorage.read("femaleRandomCallRate") ?? 0;

  static onSetMaleRandomCallRate(num maleRandomCallRate) async =>
      await localStorage.write("maleRandomCallRate", maleRandomCallRate);
  static num get maleRandomCallRate =>
      localStorage.read("maleRandomCallRate") ?? 0;

  static onSetGeneralRandomCallRate(num generalRandomCallRate) async =>
      await localStorage.write("generalRandomCallRate", generalRandomCallRate);
  static num get generalRandomCallRate =>
      localStorage.read("generalRandomCallRate") ?? 0;

  static onSetChatRate(num chatRate) async =>
      await localStorage.write("ChatRate", chatRate);
  static num get chatRate => localStorage.read("chatRate") ?? 0;

  static onSetMinCoinsToConvert(num minCoinsToConvert) async =>
      await localStorage.write("minCoinsToConvert", minCoinsToConvert);
  static num get minCoinsToConvert =>
      localStorage.read("minCoinsToConvert") ?? 0;

  static onSetUrl(String url) async => await localStorage.write("url", url);
  static String get url => localStorage.read("url") ?? "";

  static onSetTermsAndConditions(String termsAndConditions) async =>
      await localStorage.write("termsAndConditions", termsAndConditions);
  static String get termsAndConditions =>
      localStorage.read("termsAndConditions") ?? "";

  static onSetPrivacyPolicy(String privacyPolicy) async =>
      await localStorage.write("privacyPolicy", privacyPolicy);
  static String get privacyPolicy => localStorage.read("privacyPolicy") ?? "";

  static onSetCurrencyCode(String currencyCode) async =>
      await localStorage.write("currencyCode", currencyCode);
  static String get currencyCode => localStorage.read("currencyCode") ?? "\$";

  static onCallInitiatedAt(num callInitiatedAt) async =>
      await localStorage.write("callInitiatedAt", callInitiatedAt);
  static num get callInitiatedAt => localStorage.read("callInitiatedAt") ?? 1;

  static onLastLoginDate(String lastLoginDate) async =>
      await localStorage.write("lastLoginDate", lastLoginDate);
  static String get lastLoginDate => localStorage.read("lastLoginDate") ?? "";

  static onSetDemoLogin(bool isDemoLogin) async =>
      await localStorage.write("isDemoLogin", isDemoLogin);
  static bool get isDemoLogin => localStorage.read("isDemoLogin") ?? false;

  static onSetLogin(bool isLogin) async =>
      await localStorage.write("isLogin", isLogin);
  static bool get isLogin => localStorage.read("isLogin") ?? false;

  static onSetProfile(bool isSetProfile) async =>
      await localStorage.write("isSetProfile", isSetProfile);
  static bool get isSetProfile => localStorage.read("isSetProfile") ?? false;

  static onVipPlanPurchase(bool isVipPlanPurchase) async =>
      await localStorage.write("isVipPlanPurchase", isVipPlanPurchase);
  static bool get isVipPlanPurchase =>
      localStorage.read("isVipPlanPurchase") ?? false;

  static onVipFrameBadge(String vipFrameBadge) async =>
      await localStorage.write("vipFrameBadge", vipFrameBadge);
  static String get isVipFrameBadge => localStorage.read("vipFrameBadge") ?? "";

  static onSetVip(bool isVip) async => await localStorage.write("isVip", isVip);
  static bool get isVip => localStorage.read("isVip") ?? false;

  static onSetVerification(bool isVerification) async =>
      await localStorage.write("isVerification", isVerification);
  static bool get isVerification =>
      localStorage.read("isVerification") ?? false;

  static onSetHost(bool isHost) async =>
      await localStorage.write("isHost", isHost);
  static bool get isHost => localStorage.read("isHost") ?? false;

  static onSetLoginType(int loginType) async =>
      localStorage.write("loginType", loginType);
  static int get loginType => localStorage.read("loginType") ?? 0;

  static onSetLoginUserId(String loginUserId) async =>
      localStorage.write("loginUserId", loginUserId);
  static String get loginUserId => localStorage.read("loginUserId") ?? "";

  static onSetHostId(String hostId) async =>
      localStorage.write("hostId", hostId);
  static String get hostId => localStorage.read("hostId") ?? "";

  static onSetSelectedLanguage(String language) async =>
      await localStorage.write("language", language);
  static String get selectedLanguage =>
      localStorage.read("language") ?? AppConstant.language;

  static onSetDialCode(String dialCode) async =>
      localStorage.write("dialCode", dialCode);
  static String get dialCode => localStorage.read("dialCode") ?? "";

  static onSetCountry(String country) async =>
      localStorage.write("country", country);
  static String get country => localStorage.read("country") ?? "India";

  static onSetCountryCode(String countryCode) async =>
      localStorage.write("countryCode", countryCode);
  static String get countryCode => localStorage.read("countryCode") ?? "IN";

  static onSetSelectedCountryCode(String countryCode) async =>
      await localStorage.write("countryCode", countryCode);
  static String get selectedCountryCode =>
      localStorage.read("countryCode") ?? AppConstant.countryCodeEn;

  static onSetSelectedLanguageCode(String languageCode) async =>
      await localStorage.write("languageCode", languageCode);
  static String get selectedLanguageCode =>
      localStorage.read("languageCode") ?? AppConstant.languageEn;
}
