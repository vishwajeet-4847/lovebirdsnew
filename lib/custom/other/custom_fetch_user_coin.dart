import 'dart:developer';

import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/host_detail_page/api/get_host_profile_api.dart';
import 'package:LoveBirds/pages/host_detail_page/model/get_user_profile_model.dart';
import 'package:LoveBirds/pages/login_page/api/fetch_login_user_profile_api.dart';
import 'package:LoveBirds/pages/login_page/model/fetch_login_user_profile_model.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:get/get.dart';

class CustomFetchUserCoin {
  static RxInt coin = 0.obs;
  static FetchLoginUserProfileModel? fetchLoginUserProfileModel;
  static GetHostProfileModel? getHostProfileModel;
  static RxBool isLoading = false.obs;

  static Future<void> init() async {
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();
    isLoading.value = true;

    if (Database.isHost) {
      getHostProfileModel =
          await GetHostProfileApi.callApi(hostId: Database.hostId);

      if (getHostProfileModel?.host != null) {
        coin.value = getHostProfileModel?.host?.coin?.toInt() ?? 0;
        Database.onSetCoin(getHostProfileModel?.host?.coin ?? 0);

        log("Database.coin host*************** ${Database.coin}");
        isLoading.value = false;
      }
    } else {
      fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(
        token: token ?? "",
        uid: uid ?? "",
      );

      if (fetchLoginUserProfileModel?.user != null) {
        coin.value = fetchLoginUserProfileModel?.user?.coin?.toInt() ?? 0;
        Database.onSetCoin(fetchLoginUserProfileModel?.user?.coin ?? 0);

        log("Database.coin user*************** ${Database.coin}");
        isLoading.value = false;
      }
    }
  }
}
