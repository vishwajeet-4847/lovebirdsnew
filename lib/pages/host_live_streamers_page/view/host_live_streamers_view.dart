import 'dart:io';

import 'package:LoveBirds/custom/app_background/custom_app_image_background.dart';
import 'package:LoveBirds/pages/host_live_streamers_page/controller/host_live_streamers_controller.dart';
import 'package:LoveBirds/pages/host_live_streamers_page/widget/host_tab_bar.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostLiveStreamersView extends GetView<HostLiveStreamersController> {
  const HostLiveStreamersView({super.key});

  @override
  Widget build(BuildContext context) {
    if (Database.isAutoRefreshEnabled == false) {
      Get.put(HostLiveStreamersController(), permanent: true);

      controller.selectedTabIndex = 0;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.pageController.jumpToPage(controller.selectedTabIndex);
      });
    } else {
      Get.lazyPut<HostLiveStreamersController>(
          () => HostLiveStreamersController(),
          fenix: true);
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomAppImageBackground(
          child: Stack(
            children: [
              const HostTabBar(),
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.goLiveStreamPage);
                  },
                  child: Container(
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      gradient: AppColors.hostNextButton,
                      border: Border.all(color: AppColors.whiteColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAsset.icVideoLive,
                          height: 26,
                        ),
                        8.width,
                        Text(
                          EnumLocale.txtGoLive.name.tr,
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(
                      bottom: Platform.isIOS
                          ? Get.height * 0.9
                          : Get.height * 0.11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
