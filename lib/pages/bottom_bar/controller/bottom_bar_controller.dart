import 'dart:async';

import 'package:figgy/custom/dialog/daily_check_in_dialog.dart';
import 'package:figgy/pages/discover_host_for_user_page/view/discover_host_for_user_view.dart';
import 'package:figgy/pages/message_page/view/message_view.dart';
import 'package:figgy/pages/profile_page/controller/profile_controller.dart';
import 'package:figgy/pages/profile_page/view/profile_view.dart';
import 'package:figgy/pages/random_match_page/view/random_match_view.dart';
import 'package:figgy/pages/top_up_page/controller/top_up_controller.dart';
import 'package:figgy/socket/socket_services.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  TopUpController? topUpController;
  ProfileViewController? profileViewController;
  int currentIndex = 0;

  final List<Widget> pages = [
    const DiscoverHostForUserView(),
    const MessageView(),
    const RandomMatchView(),
    const ProfileView(),
  ];

  @override
  Future<void> onInit() async {
    await SocketServices.onConnect();

    final controller = Get.find<ProfileViewController>();
    Utils.showLog('controller: ${controller.coinData}');
    1000.milliseconds.delay();

    _checkFirstTimeToday();
    super.onInit();
  }

  Future<void> changeTab(int index) async {
    currentIndex = index;

    if (currentIndex == 0) {
      topUpController?.getCoinPlanApi();
      Utils.showLog("call api");
    }
    if (currentIndex == 3) {
      profileViewController?.getDailyRewardCoin();
    }

    update();
  }

  Future<void> _checkFirstTimeToday() async {
    String? lastLoginDate = Database.lastLoginDate;
    String currentDate = DateTime.now().toString().substring(0, 10);

    if (lastLoginDate != currentDate) {
      Utils.showLog("Welcome back! You entered the app today.");

      Get.dialog(
        barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
        Dialog(
          alignment: Alignment.center,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          backgroundColor: AppColors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          child: const DailyCheckInDialog(),
        ),
      );

      await Database.onLastLoginDate(currentDate);
    }
  }
}
