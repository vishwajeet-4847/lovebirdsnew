import 'dart:math';

import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/firebase/anonymous_authentication.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/firebase/google_authentication.dart';
import 'package:LoveBirds/pages/host_detail_page/api/get_host_profile_api.dart';
import 'package:LoveBirds/pages/host_detail_page/model/get_user_profile_model.dart';
import 'package:LoveBirds/pages/login_page/api/fetch_login_user_profile_api.dart';
import 'package:LoveBirds/pages/login_page/api/login_api.dart';
import 'package:LoveBirds/pages/login_page/model/fetch_login_user_profile_model.dart';
import 'package:LoveBirds/pages/login_page/model/login_model.dart';
import 'package:LoveBirds/pages/splash_screen_page/api/check_user_name_api.dart';
import 'package:LoveBirds/pages/splash_screen_page/api/get_setting_api.dart';
import 'package:LoveBirds/pages/splash_screen_page/model/check_user_name_model.dart';
import 'package:LoveBirds/pages/splash_screen_page/model/get_setting_model.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/internet_connection.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginModel? loginModel;
  bool isLogin = false;
  CheckUserModel? checkUserNameModel;
  UserCredential? userCredential;
  FetchLoginUserProfileModel? fetchLoginUserProfileModel;
  GetHostProfileModel? getHostProfileModel;
  GetSettingModel? getSettingModel;

  List<String> randomNames = [
    "Emily Johnson",
    "Sophia Brown",
    "Olivia Miller",
    "Ava Wilson",
    "Mia Anderson",
    "Isabella Taylor",
    "Amelia Thomas",
    "Harper Moore",
    "Evelyn Jackson",
    "Abigail White",
    "Ella Harris",
    "Scarlett Lewis",
    "Lily Clark",
    "Grace Hall",
    "Zoe Young",
    "Nora King",
    "Riley Wright",
    "Aria Scott",
    "Hannah Green",
    "Layla Adams",
  ];

  final randomImages = [
    "https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/1758144/pexels-photo-1758144.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/1898555/pexels-photo-1898555.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/1771383/pexels-photo-1771383.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/3053485/pexels-photo-3053485.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
    "https://cdn.pixabay.com/photo/2019/11/03/20/11/portrait-4599553_1280.jpg"
  ];

  TextEditingController countryController = TextEditingController();
  TextEditingController flagController = TextEditingController();
  String? flag = "";

  String getFlagEmoji(String countryCode) {
    return countryCode
        .toUpperCase()
        .runes
        .map((code) => String.fromCharCode(code + 127397))
        .join();
  }

  @override
  void onInit() {
    flag = getFlagEmoji(Database.countryCode);
    flagController.text = flag ?? "";
    countryController.text = Database.country;

    super.onInit();
  }

  String onGetRandomName() {
    Random random = Random();
    int index = random.nextInt(randomNames.length);
    return randomNames[index];
  }

  String onGetRandomImage() {
    Random random = Random();
    int index = random.nextInt(randomImages.length);
    return randomImages[index];
  }

  // void onGoogleLogin() async {
  //   if (InternetConnection.isConnect) {
  //     Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
  //     userCredential = await GoogleAuthentication.signInWithGoogle();
  //
  //     if (userCredential == null) {
  //       Get.back();
  //     }
  //
  //     String? fcmToken = await FirebaseMessaging.instance.getToken();
  //     Utils.showLog("FCM Token => $fcmToken");
  //
  //     Database.init();
  //
  //     final uid = FirebaseUid.onGet();
  //     final token = await FirebaseAccessToken.onGet();
  //
  //     if (userCredential?.user?.email != null && userCredential?.user?.displayName != null && userCredential?.user?.photoURL != null) {
  //       loginModel = await LoginApi.callApi(
  //         loginType: 2,
  //         identity: Database.identity,
  //         fcmToken: fcmToken ?? "",
  //         email: userCredential?.user?.email ?? "",
  //         name: userCredential?.user?.displayName ?? "",
  //         image: userCredential?.user?.photoURL ?? "",
  //         uid: uid ?? "",
  //         token: token ?? "",
  //         country: countryController.text,
  //         countryFlagImage: flagController.text,
  //       );
  //
  //       if (loginModel?.status == true) {
  //         Database.onSetLogin(true);
  //
  //         fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(
  //           token: token ?? "",
  //           uid: uid ?? "",
  //         );
  //
  //         if (Database.isHost) getHostProfileModel = await GetHostProfileApi.callApi(hostId: Database.hostId);
  //
  //         await settingsApi();
  //
  //         Database.onSetLoginUserId(fetchLoginUserProfileModel?.user?.id ?? "");
  //         Database.onSetLoginType(fetchLoginUserProfileModel?.user?.loginType ?? 2);
  //         Database.onSetVip(fetchLoginUserProfileModel?.user?.isVip ?? false);
  //         Database.onSetImpression(getHostProfileModel?.host?.impression ?? []);
  //         Database.isHost
  //             ? Database.onSetEmail(getHostProfileModel?.host?.email ?? "")
  //             : Database.onSetEmail(fetchLoginUserProfileModel?.user?.email ?? "");
  //
  //         Database.isHost
  //             ? Database.onSetUniqueId(getHostProfileModel?.host?.uniqueId ?? "")
  //             : Database.onSetUniqueId(fetchLoginUserProfileModel?.user?.uniqueId ?? "");
  //
  //         Database.isHost
  //             ? Database.onSetUserProfileImage(getHostProfileModel?.host?.image ?? "")
  //             : Database.onSetUserProfileImage(fetchLoginUserProfileModel?.user?.image ?? "");
  //         Database.isHost
  //             ? Database.onSetUserName(getHostProfileModel?.host?.name ?? "")
  //             : Database.onSetUserName(fetchLoginUserProfileModel?.user?.name ?? "");
  //         Database.isHost
  //             ? Database.onSetCoin(getHostProfileModel?.host?.coin ?? 0)
  //             : Database.onSetCoin(fetchLoginUserProfileModel?.user?.coin ?? 0);
  //
  //         Utils.showLog("Database.loginUserId :: ${Database.loginUserId}");
  //         Utils.showLog("Database.loginType :: ${Database.loginType}");
  //         Utils.showLog("Database.isVip :: ${Database.isVip}");
  //         Utils.showLog("Database.impression :: ${Database.impression}");
  //         Utils.showLog("Database.email :: ${Database.email}");
  //         Utils.showLog("Database.profileImage :: ${Database.profileImage}");
  //         Utils.showLog("Database.userName :: ${Database.userName}");
  //         Utils.showLog("Database.coin :: ${Database.coin}");
  //
  //         Utils.showLog("text********************");
  //         Database.onSetProfile(true);
  //         Get.back(); // Stop Loading...
  //         fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(
  //           token: token ?? "",
  //           uid: uid ?? "",
  //         );
  //
  //         if (Database.isHost) getHostProfileModel = await GetHostProfileApi.callApi(hostId: Database.hostId);
  //
  //         Database.isHost ? Get.offAllNamed(AppRoutes.hostBottomBar) : Get.offAllNamed(AppRoutes.bottomBar);
  //       } else {
  //         Utils.showToast(loginModel?.message ?? "");
  //       }
  //     } else {
  //       Utils.showLog(loginModel?.message ?? "");
  //     }
  //   } else {
  //     Utils.showToast(EnumLocale.txtNoInternetConnection.name.tr);
  //     Utils.showLog("Internet Connection Lost !!");
  //   }
  // }

  void onGoogleLogin() async {
    if (!InternetConnection.isConnect) {
      Utils.showToast(EnumLocale.txtNoInternetConnection.name.tr);
      Utils.showLog("Internet Connection Lost !!");
      return;
    }

    Get.dialog(const LoadingWidget(), barrierDismissible: false);

    // Google Login
    userCredential = await GoogleAuthentication.signInWithGoogle();

    print(
        "===========================\n$userCredential\n========================");

    if (userCredential == null) {
      Get.back(); // stop loading
      Utils.showToast("Google Sign-In Cancelled");
      return;
    }

    // Firebase OR fallback data
    final email =
        userCredential?.user?.email ?? GoogleAuthentication.lastUsedEmail;
    final name =
        userCredential?.user?.displayName ?? GoogleAuthentication.lastUsedName;
    final image =
        userCredential?.user?.photoURL ?? GoogleAuthentication.lastUsedPhoto;

    Utils.showLog("FINAL LOGIN EMAIL => $email");
    Utils.showLog("FINAL LOGIN NAME  => $name");
    Utils.showLog("FINAL LOGIN IMAGE => $image");

    if (email == null || name == null || image == null) {
      Get.back();
      Utils.showToast("Google account did not provide email or name!");
      return;
    }

    // Fetch FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    Utils.showLog("FCM Token => $fcmToken");

    Database.init();
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    // LOGIN API CALL
    loginModel = await LoginApi.callApi(
      loginType: 2,
      identity: Database.identity,
      fcmToken: fcmToken ?? "",
      email: email,
      name: name,
      image: image,
      uid: uid ?? "",
      token: token ?? "",
      country: countryController.text,
      countryFlagImage: flagController.text,
    );

    if (loginModel?.status != true) {
      Get.back();
      Utils.showToast(loginModel?.message ?? "Login failed");
      return;
    }

    // Save Login In Database
    Database.onSetLogin(true);

    // Fetch Login User Profile
    fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(
      token: token ?? "",
      uid: uid ?? "",
    );

    if (Database.isHost) {
      getHostProfileModel =
          await GetHostProfileApi.callApi(hostId: Database.hostId);
    }

    await settingsApi();

    // Save Profile Data
    Database.onSetLoginUserId(fetchLoginUserProfileModel?.user?.id ?? "");
    Database.onSetLoginType(fetchLoginUserProfileModel?.user?.loginType ?? 2);
    Database.onSetVip(fetchLoginUserProfileModel?.user?.isVip ?? false);
    Database.onSetImpression(getHostProfileModel?.host?.impression ?? []);

    Database.onSetEmail(Database.isHost
        ? getHostProfileModel?.host?.email ?? ""
        : fetchLoginUserProfileModel?.user?.email ?? "");

    Database.onSetUniqueId(Database.isHost
        ? getHostProfileModel?.host?.uniqueId ?? ""
        : fetchLoginUserProfileModel?.user?.uniqueId ?? "");

    Database.onSetUserProfileImage(Database.isHost
        ? getHostProfileModel?.host?.image ?? ""
        : fetchLoginUserProfileModel?.user?.image ?? "");

    Database.onSetUserName(Database.isHost
        ? getHostProfileModel?.host?.name ?? ""
        : fetchLoginUserProfileModel?.user?.name ?? "");

    Database.onSetCoin(Database.isHost
        ? getHostProfileModel?.host?.coin ?? 0
        : fetchLoginUserProfileModel?.user?.coin ?? 0);

    Utils.showLog("Login Complete");

    // Done
    Database.onSetProfile(true);
    Get.back();

    // Navigate
    Database.isHost
        ? Get.offAllNamed(AppRoutes.hostBottomBar)
        : Get.offAllNamed(AppRoutes.bottomBar);
  }

  void onQuickLogin() async {
    if (InternetConnection.isConnect) {
      Get.dialog(const LoadingWidget(),
          barrierDismissible: false); // Start Loading...
      await AnonymousAuthentication.signInWithAnonymous(); // Anonymous Login...
      Database.init();
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      checkUserNameModel = await CheckUserApi.callApi(
        identity: Database.identity,
      );

      loginModel = await LoginApi.callApi(
        loginType: 3,
        identity: Database.identity,
        fcmToken: fcmToken ?? "",
        email: Database.identity,
        uid: uid ?? "",
        token: token ?? "",
        name: onGetRandomName(),
        image: onGetRandomImage(),
        country: countryController.text,
        countryFlagImage: flagController.text,
      );
      Get.back(); // Stop Loading...

      if (loginModel?.status == true) {
        Database.onSetLogin(true);
        Database.onSetProfile(false);

        settingsApi();

        Database.isHost
            ? getHostProfileModel =
                await GetHostProfileApi.callApi(hostId: Database.hostId)
            : fetchLoginUserProfileModel =
                await FetchLoginUserProfileApi.callApi(
                token: token ?? "",
                uid: uid ?? "",
              );

        Database.onSetLoginUserId(fetchLoginUserProfileModel?.user?.id ?? "");
        Database.onSetLoginType(
            fetchLoginUserProfileModel?.user?.loginType ?? 3);
        Database.onSetVip(fetchLoginUserProfileModel?.user?.isVip ?? false);
        Database.onSetImpression(getHostProfileModel?.host?.impression ?? []);
        Database.isHost
            ? Database.onSetEmail(getHostProfileModel?.host?.email ?? "")
            : Database.onSetEmail(
                fetchLoginUserProfileModel?.user?.email ?? "");

        Database.isHost
            ? Database.onSetUniqueId(getHostProfileModel?.host?.uniqueId ?? "")
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
            : Database.onSetCoin(fetchLoginUserProfileModel?.user?.coin ?? 0);

        Utils.showLog("Database.loginUserId :: ${Database.loginUserId}");
        Utils.showLog("Database.loginType :: ${Database.loginType}");
        Utils.showLog("Database.isVip :: ${Database.isVip}");
        Utils.showLog("Database.impression :: ${Database.impression}");
        Utils.showLog("Database.email :: ${Database.email}");
        Utils.showLog("Database.profileImage :: ${Database.profileImage}");
        Utils.showLog("Database.userName :: ${Database.userName}");
        Utils.showLog("Database.coin :: ${Database.coin}");
        Utils.showLog("Database.uniqueId :: ${Database.uniqueId}");

        if (loginModel?.signUp == true) {
          Get.toNamed(
            AppRoutes.fillProfile,
            arguments: {
              "email": Database.email,
              "name": Database.userName,
              "image": Database.profileImage,
              "loginType": Database.loginType,
            },
          );
        } else {
          Database.onSetProfile(true);
          Database.isHost
              ? Get.offAllNamed(AppRoutes.hostBottomBar)
              : Get.offAllNamed(AppRoutes.bottomBar);
        }
      } else {
        Utils.showToast(loginModel?.message ?? "");
      }
    } else {
      Utils.showToast(EnumLocale.txtNoInternetConnection.name.tr);
      Utils.showLog("Internet Connection Lost !!");
    }
  }

  ///===================== DEMO DATA REMOVE START =====================///

  void onDemoHostLogin() async {
    if (InternetConnection.isConnect) {
      Get.dialog(const LoadingWidget(),
          barrierDismissible: false); // Start Loading...

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: "mia.modi123@gmail.com", password: "Mia.Modi123");

        Utils.showLog(
            "signInWithEmailAndPassword***************** $credential");
      } on FirebaseAuthException catch (e) {
        Utils.showLog('Error in demo host :: $e');
      }

      String? fcmToken = await FirebaseMessaging.instance.getToken();
      Utils.showLog("FCM Token => $fcmToken");

      Database.init();

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      loginModel = await LoginApi.callApi(
        loginType: 2,
        identity: Database.identity,
        fcmToken: fcmToken ?? "",
        email: "mia.modi123@gmail.com",
        name: "Mia Modi",
        image:
            "https://lh3.googleusercontent.com/a/ACg8ocLXkMUVLElGCTt9nswGsW4b6Yu260REzBFlMSLN4N52MWwFoA=s96-c",
        uid: uid ?? "",
        token: token ?? "",
        country: countryController.text,
        countryFlagImage: flagController.text,
      );

      if (loginModel?.status == true) {
        Database.onSetLogin(true);
        Database.onSetDemoLogin(true);

        settingsApi();

        fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(
          token: token ?? "",
          uid: uid ?? "",
        );

        if (Database.isHost)
          getHostProfileModel =
              await GetHostProfileApi.callApi(hostId: Database.hostId);

        Database.onSetLoginUserId(fetchLoginUserProfileModel?.user?.id ?? "");
        Database.onSetLoginType(
            fetchLoginUserProfileModel?.user?.loginType ?? 2);
        Database.onSetVip(fetchLoginUserProfileModel?.user?.isVip ?? false);
        Database.onSetImpression(getHostProfileModel?.host?.impression ?? []);
        Database.isHost
            ? Database.onSetEmail(getHostProfileModel?.host?.email ?? "")
            : Database.onSetEmail(
                fetchLoginUserProfileModel?.user?.email ?? "");

        Database.isHost
            ? Database.onSetUniqueId(getHostProfileModel?.host?.uniqueId ?? "")
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
            : Database.onSetCoin(fetchLoginUserProfileModel?.user?.coin ?? 0);

        Utils.showLog("Database.loginUserId :: ${Database.loginUserId}");
        Utils.showLog("Database.loginType :: ${Database.loginType}");
        Utils.showLog("Database.isVip :: ${Database.isVip}");
        Utils.showLog("Database.impression :: ${Database.impression}");
        Utils.showLog("Database.email :: ${Database.email}");
        Utils.showLog("Database.profileImage :: ${Database.profileImage}");
        Utils.showLog("Database.userName :: ${Database.userName}");
        Utils.showLog("Database.coin :: ${Database.coin}");

        Database.onSetProfile(true);

        fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(
          token: token ?? "",
          uid: uid ?? "",
        );

        if (Database.isHost)
          getHostProfileModel =
              await GetHostProfileApi.callApi(hostId: Database.hostId);

        Database.isHost
            ? Get.offAllNamed(AppRoutes.hostBottomBar)
            : Get.offAllNamed(AppRoutes.bottomBar);

        Get.back(); // Stop Loading...
      } else {
        Utils.showToast(loginModel?.message ?? "");
      }
    } else {
      Utils.showToast(EnumLocale.txtNoInternetConnection.name.tr);
      Utils.showLog("Internet Connection Lost !!");
    }
  }

  ///===================== DEMO DATA REMOVE END =====================///

  Future<void> settingsApi() async {
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    getSettingModel =
        await GetSettingApi.getSettingApi(uid: uid ?? "", token: token ?? "");
  }
}
