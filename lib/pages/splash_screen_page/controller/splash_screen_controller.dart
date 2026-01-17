import 'dart:developer';

import 'package:figgy/custom/dialog/app_maintenance_dialog.dart';
import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/host_detail_page/api/get_host_profile_api.dart';
import 'package:figgy/pages/host_detail_page/model/get_user_profile_model.dart';
import 'package:figgy/pages/login_page/api/fetch_login_user_profile_api.dart';
import 'package:figgy/pages/login_page/model/fetch_login_user_profile_model.dart';
import 'package:figgy/pages/splash_screen_page/api/get_country_api.dart';
import 'package:figgy/pages/splash_screen_page/api/get_policy_api.dart';
import 'package:figgy/pages/splash_screen_page/api/get_setting_api.dart';
import 'package:figgy/pages/splash_screen_page/model/get_policy_model.dart';
import 'package:figgy/pages/splash_screen_page/model/get_setting_model.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/socket/socket_services.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashScreenController extends GetxController {
  final localStorage = GetStorage();

  GetSettingModel? getSettingModel;
  FetchLoginUserProfileModel? fetchLoginUserProfileModel;
  GetHostProfileModel? getHostProfileModel;
  GetPolicyModel? getPolicyModel;

  @override
  Future<void> onInit() async {
    Utils.showLog("Splash screen*****************");
    super.onInit();

    await settingsApi();

    print(
        "${getSettingModel?.data?.isAppEnabled == false}======================");

    if (getSettingModel?.data?.isAppEnabled == false) {
      Get.dialog(
        barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
        barrierDismissible: false,
        Dialog(
          backgroundColor: AppColors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          child: const AppMaintenanceDialog(),
        ),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        precacheImage(
          const AssetImage(AppAsset.imgBgTopUp1),
          Get.context!,
        );

        precacheImage(
          const AssetImage(AppAsset.imaRandomBg1),
          Get.context!,
        );

        precacheImage(
          const AssetImage(AppAsset.imgPopVip1),
          Get.context!,
        );
      });

      initStart();
    }
  }

  void initStart() async {
    await GetCountryApi.callApi(); // Get Country Data...
    GetCountryApi.getDialCode();

    // Get Policy and Conditions data
    getPolicyModel = await GetPolicyApi.callApi();

    // Store policy data in database for global access
    if (getPolicyModel?.data?.privacyPolicyLink != null) {
      Database.onSetPrivacyPolicy(getPolicyModel!.data!.privacyPolicyLink!);
    }
    if (getPolicyModel?.data?.termsOfUsePolicyLink != null) {
      Database.onSetTermsAndConditions(
          getPolicyModel!.data!.termsOfUsePolicyLink!);
    }

    log("Database.isLogin=============== ${Database.isLogin}");
    log("Database.isSetProfile========== ${Database.isSetProfile}");

    if (Database.isLogin == true) {
      if (Database.isSetProfile == true) {
        final uid = FirebaseUid.onGet();
        final token = await FirebaseAccessToken.onGet();

        if ((uid != null || uid?.isNotEmpty == true) &&
            (token != null || token?.isNotEmpty == true)) {
          fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(
            token: token ?? "",
            uid: uid ?? "",
          );

          if (fetchLoginUserProfileModel?.status == false) {
            if (fetchLoginUserProfileModel?.message ==
                "User not found in the database") {
              Utils.showToast(fetchLoginUserProfileModel?.message ??
                  "User not found in the database");

              final identityLogOut = Database.identity;
              final fcmTokenLogOut = Database.fcmToken;

              if (Database.loginType == 2) {
                Utils.showLog("Google Logout Success");
                await GoogleSignIn().signOut();
              }

              Database.localStorage.erase();

              SocketServices.disconnectSocket();

              Database.onSetFcmToken(fcmTokenLogOut);
              Database.onSetIdentity(identityLogOut);

              Get.offAllNamed(AppRoutes.loginView);
            } else {
              final identityLogOut = Database.identity;
              final fcmTokenLogOut = Database.fcmToken;

              if (Database.loginType == 2) {
                Utils.showLog("Google Logout Success");
                await GoogleSignIn().signOut();
              }

              Database.localStorage.erase();

              SocketServices.disconnectSocket();

              Database.onSetFcmToken(fcmTokenLogOut);
              Database.onSetIdentity(identityLogOut);

              Get.offAllNamed(AppRoutes.loginView);

              Database.onSetIsAutoRefreshEnabled(false);
            }
          } else {
            if (Database.isHost)
              getHostProfileModel =
                  await GetHostProfileApi.callApi(hostId: Database.hostId);

            Database.onSetLoginUserId(
                fetchLoginUserProfileModel?.user?.id ?? "");
            Database.onSetLoginType(
                fetchLoginUserProfileModel?.user?.loginType ?? 0);
            Database.onSetVip(fetchLoginUserProfileModel?.user?.isVip ?? false);
            Database.onSetImpression(
                getHostProfileModel?.host?.impression ?? []);
            Database.isHost
                ? Database.onSetEmail(getHostProfileModel?.host?.email ?? "")
                : Database.onSetEmail(
                    fetchLoginUserProfileModel?.user?.email ?? "");
            Database.isHost
                ? Database.onSetUniqueId(
                    getHostProfileModel?.host?.uniqueId ?? "")
                : Database.onSetUniqueId(
                    fetchLoginUserProfileModel?.user?.uniqueId ?? "");

            Database.isHost
                ? Database.onSetUserProfileImage(
                    getHostProfileModel?.host?.image ?? "")
                : Database.onSetUserProfileImage(
                    fetchLoginUserProfileModel?.user?.image ?? "");
            Database.isHost
                ? Database.onSetUserName(getHostProfileModel?.host?.name ?? "")
                : Database.onSetUserName(
                    fetchLoginUserProfileModel?.user?.name ?? "");
            Database.isHost
                ? Database.onSetCoin(getHostProfileModel?.host?.coin ?? 0)
                : Database.onSetCoin(
                    fetchLoginUserProfileModel?.user?.coin ?? 0);

            Database.isHost
                ? Get.offAllNamed(AppRoutes.hostBottomBar)
                : Get.offAllNamed(AppRoutes.bottomBar);
          }
        } else {
          final identityLogOut = Database.identity;
          final fcmTokenLogOut = Database.fcmToken;

          if (Database.loginType == 2) {
            Utils.showLog("Google Logout Success");
            await GoogleSignIn().signOut();
          }

          Database.localStorage.erase();

          SocketServices.disconnectSocket();

          Database.onSetFcmToken(fcmTokenLogOut);
          Database.onSetIdentity(identityLogOut);

          Get.offAllNamed(AppRoutes.loginView);

          Database.onSetIsAutoRefreshEnabled(false);
        }
      } else {
        Database.loginType == 2
            ? Get.toNamed(
                AppRoutes.fillProfile,
                arguments: {
                  "email": Database.email,
                  "name": Database.userName,
                  "image": Database.profileImage,
                  "loginType": Database.loginType,
                },
              )
            : Get.offAllNamed(AppRoutes.loginView);
      }
    } else {
      Get.offAllNamed(AppRoutes.loginView);
    }
  }

  Future<void> settingsApi() async {
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    if ((uid != null || uid?.isNotEmpty == true) &&
        (token != null || token?.isNotEmpty == true)) {
      getSettingModel =
          await GetSettingApi.getSettingApi(uid: uid ?? "", token: token ?? "");
    } else {
      final identityLogOut = Database.identity;
      final fcmTokenLogOut = Database.fcmToken;

      if (Database.loginType == 2) {
        Utils.showLog("Google Logout Success");
        await GoogleSignIn().signOut();
      }

      Database.localStorage.erase();

      SocketServices.disconnectSocket();

      Database.onSetFcmToken(fcmTokenLogOut);
      Database.onSetIdentity(identityLogOut);

      Get.offAllNamed(AppRoutes.loginView);

      Database.onSetIsAutoRefreshEnabled(false);
    }
  }
}
