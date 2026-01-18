import 'dart:developer';

import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/host_detail_page/api/get_host_profile_api.dart';
import 'package:LoveBirds/pages/host_detail_page/model/get_user_profile_model.dart';
import 'package:LoveBirds/pages/login_page/api/fetch_login_user_profile_api.dart';
import 'package:LoveBirds/pages/login_page/model/fetch_login_user_profile_model.dart';
import 'package:LoveBirds/pages/profile_page/api/earn_coin_from_daily_check_in_api.dart';
import 'package:LoveBirds/pages/profile_page/api/get_daily_reward_coin_api.dart';
import 'package:LoveBirds/pages/profile_page/model/earn_coin_from_daily_check_in_model.dart';
import 'package:LoveBirds/pages/profile_page/model/get_daily_reward_coin_model.dart';
import 'package:LoveBirds/pages/verification_page/model/fetch_host_request_status_model.dart';
import 'package:LoveBirds/pages/vip_page/api/vip_plan_privilege_api.dart';
import 'package:LoveBirds/pages/vip_page/model/vip_plan_privilege_model.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileViewController extends GetxController {
  FetchHostRequestStatusModel? fetchHostRequestStatusModel;
  FetchLoginUserProfileModel? fetchLoginUserProfileModel;

  //*************** Check-in
  GetDailyRewardCoinModel? getDailyRewardCoinModel;
  EarnCoinFromDailyCheckInModel? earnCoinFromDailyCheckInModel;
  GetHostProfileModel? getHostProfileModel;

  int totalCoin = 0;
  List<Datum> coinData = <Datum>[];
  int boxId = 0;
  bool isTodayCheckIn = false;
  int todayCoin = 0;

  bool isLoading = false;

  @override
  void onInit() async {
    log("Enter in profile controller");
    log("Enter in profile controller${Database.profileImage}");

    await getVipPrivilege();

    if (Database.isHost) {
      onGetHostProfile();
    } else {
      getDailyRewardCoin();
      CustomFetchUserCoin.init();
    }

    super.onInit();
  }

  void onGetVerifyPage() {
    log("Database.isVerification************************* ${Database.isVerification}");

    if (Database.isVerification == true) {
      Get.toNamed(AppRoutes.verificationPage);
    } else {
      Get.toNamed(AppRoutes.hostRequestPage);
    }
  }

  //*************** Check-in
  Future<void> getDailyRewardCoin() async {
    try {
      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      getDailyRewardCoinModel = await GetDailyRewardCoinApi.callApi(
          uid: uid ?? "", token: token ?? "");

      DateTime today = DateTime.now();
      List<DateTime> weekDates = onGetCustomGetCurrentWeekDate();

      if (getDailyRewardCoinModel?.data?.isNotEmpty ?? false) {
        coinData.clear();
        coinData.addAll(getDailyRewardCoinModel?.data ?? []);

        await Database.onSetCoin(getDailyRewardCoinModel?.totalCoins ?? 0);
        log("Coin:${Database.coin.toString()}");

        update([AppConstant.idGetDailyRewards]);
        for (int index = 0; index < coinData.length; index++) {
          if (index < weekDates.length &&
              today.day == weekDates[index].day &&
              today.month == weekDates[index].month) {
            todayCoin = coinData[index].reward ?? 0;
            log("weekDates: $weekDates");
            log("Today Coin: $todayCoin");
            isTodayCheckIn = coinData[index].isCheckIn ?? false;
            log("isTodayCheckIn--------------------- $isTodayCheckIn");

            update([AppConstant.idGetDailyRewards]);
          }
        }
      }

      if (coinData.isNotEmpty) {
        boxId = coinData.length;
      }

      update([AppConstant.idDailyCheck]);
    } catch (e) {
      log("Error in getDailyRewardCoin: $e");
    }
  }

  Future<void> earnCoinFromDailyCheckIn(BuildContext context) async {
    try {
      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      earnCoinFromDailyCheckInModel = await EarnCoinFromDailyCheckInApi.callApi(
        token: token ?? "",
        uid: uid ?? "",
        dailyRewardCoin: todayCoin.toString(),
      );
      getDailyRewardCoinModel = await GetDailyRewardCoinApi.callApi(
          uid: uid ?? "", token: token ?? "");

      600.milliseconds.delay();
      await CustomFetchUserCoin.init();

      update();

      if (earnCoinFromDailyCheckInModel?.isCheckIn ?? false) {
        isTodayCheckIn = true;

        Database.onSetLastRewardDate(DateTime.now().toString());
        log("LastRewardDate:${Database.lastRewardDate}");

        update([AppConstant.idGetDailyRewards]);
      }

      getDailyRewardCoin();

      log("Earned Coin: ${todayCoin.toString()}");
    } catch (e) {
      log("Error in earnCoinFromDailyCheckIn: $e");
    }
  }

  List<DateTime> onGetCustomGetCurrentWeekDate({DateTime? customDate}) {
    List<DateTime> weekDates = [];
    DateTime now = customDate ?? DateTime.now().toLocal();
    int currentWeekday = now.weekday;
    DateTime startOfWeek = now.subtract(Duration(days: currentWeekday - 1));
    log("startOfWeek: $startOfWeek");
    log("currentWeekday: $currentWeekday");
    for (int i = 0; i < 7; i++) {
      DateTime weekDay = startOfWeek.add(Duration(days: i));
      weekDates.add(weekDay);
    }
    return weekDates;
  }

  //******************* Host Profile
  Future<void> onGetHostProfile() async {
    getHostProfileModel =
        await GetHostProfileApi.callApi(hostId: Database.hostId);

    if (getHostProfileModel?.host != null) {
      Database.onSetCoin(getHostProfileModel?.host?.coin ?? 0);
      Database.onSetUserProfileImage(getHostProfileModel?.host?.image ?? "");
      update();

      log("Database.coin host=================== ${Database.coin}");
    }
  }

  //******************* User Profile
  Future<void> onGetUserProfile() async {
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(
      token: token ?? "",
      uid: uid ?? "",
    );

    if (fetchLoginUserProfileModel?.user != null) {
      Database.onSetCoin(fetchLoginUserProfileModel?.user?.coin ?? 0);
      Database.onSetUserProfileImage(
          fetchLoginUserProfileModel?.user?.image ?? "");
      update();

      log("Database.coin user*************** ${Database.coin}");
    }
  }

  VipPlanPrivilegeModel? vipPlanPrivilegeModel;
  String? frameBadge;
  Future<void> getVipPrivilege() async {
    vipPlanPrivilegeModel = await VipPlanPrivilegeApi.callApi();

    log("frameBadge: ${vipPlanPrivilegeModel?.data?.vipFrameBadge}");
    frameBadge = vipPlanPrivilegeModel?.data?.vipFrameBadge ?? '';
    Database.onVipFrameBadge(frameBadge ?? "");
    Database.onVipPlanPurchase(true);

    log("Database.isVipFrameBadge******************** ${Database.isVipFrameBadge}");

    update([
      AppConstant.idOnCarouselTap1,
      AppConstant.idVipChangeTab,
      AppConstant.idChangePage
    ]);
  }
}
