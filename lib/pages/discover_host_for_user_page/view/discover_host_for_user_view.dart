import 'package:figgy/custom/app_background/custom_app_image_background.dart';
import 'package:figgy/pages/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:figgy/pages/discover_host_for_user_page/controller/discover_host_for_user_controller.dart';
import 'package:figgy/pages/discover_host_for_user_page/widget/tab_bar_widget.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverHostForUserView extends GetView<DiscoverHostForUserController> {
  const DiscoverHostForUserView({super.key});

  @override
  Widget build(BuildContext context) {
    if (Database.isAutoRefreshEnabled == false) {
      Get.put(DiscoverHostForUserController(), permanent: true);

      controller.selectedTabIndex = 1;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.pageController.jumpToPage(controller.selectedTabIndex);
      });
    } else {
      Get.lazyPut<DiscoverHostForUserController>(
          () => DiscoverHostForUserController(),
          fenix: true);
    }
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Get.find<BottomBarController>().changeTab(0);
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          body: Stack(
            children: [
              const CustomAppImageBackground(
                child: TabBarWidget(),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                right: 12,
                child: GetBuilder<DiscoverHostForUserController>(
                  id: AppConstant.idUpdateCoin,
                  builder: (logic) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.topUpPage)?.then((_) async {
                          await logic.getUpdatedCoin();
                        });
                      },
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.colorDimButton),
                          borderRadius: BorderRadius.circular(50),
                          gradient: AppColors.gradientButtonColor,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppAsset.coinIcon2,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              Database.coin.toString().split('.')[0],
                              style: AppFontStyle.styleW800(
                                AppColors.whiteColor,
                                16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
