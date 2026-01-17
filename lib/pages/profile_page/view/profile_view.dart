import 'package:dotted_line/dotted_line.dart';
import 'package:figgy/common/common_info_tile.dart';
import 'package:figgy/custom/app_background/custom_app_image_background.dart';
import 'package:figgy/pages/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:figgy/pages/host_bottom_bar/controller/host_bottom_controller.dart';
import 'package:figgy/pages/profile_page/controller/profile_controller.dart';
import 'package:figgy/pages/profile_page/widget/bottom_profile_widget.dart';
import 'package:figgy/pages/profile_page/widget/more_container_widget.dart';
import 'package:figgy/pages/profile_page/widget/profile_name_widget.dart';
import 'package:figgy/pages/profile_page/widget/profile_picture_widget.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Database.isHost ? Get.find<HostBottomBarController>().changeTab(0) : Get.find<BottomBarController>().changeTab(0);
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: CustomAppImageBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //************** Profile image
                  const ProfilePictureWidget(),

                  //************** Profile name
                  const ProfileNameWidget(),
                  Database.isHost ? const Offstage() : 22.height,

                  //************** Host wallet view
                  Database.isHost
                      ? GetBuilder<ProfileViewController>(
                          builder: (logic) => GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.historyView),
                            child: Container(
                              height: 110,
                              width: Get.width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage(AppAsset.hostCoinBg1), fit: BoxFit.cover),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Container(
                                height: 110,
                                width: Get.width,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    height: 148,
                                    width: Get.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          AppAsset.coinStarImage,
                                          height: 130,
                                        ),
                                        10.width,
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            12.height,
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                              decoration: BoxDecoration(
                                                  color: AppColors.blackColor.withValues(alpha: 0.28), borderRadius: BorderRadius.circular(20)),
                                              child: Text(
                                                EnumLocale.txtAvailableCoin.name.tr,
                                                style: AppFontStyle.styleW600(AppColors.whiteColor.withValues(alpha: 0.80), 14),
                                              ),
                                            ),
                                            4.height,
                                            Text(
                                              Database.coin.toString().split('.')[0],

                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 40,
                                                color: AppColors.whiteColor,
                                                shadows: [
                                                  Shadow(
                                                    color: AppColors.blackColor.withValues(alpha: 0.27),
                                                    offset: const Offset(1, 1.2),
                                                    blurRadius: 0,
                                                  ),
                                                ],
                                              ),
                                              // overflow: TextOverflow.visible,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Image.asset(
                                          AppAsset.icRightArrow,
                                          width: 14,
                                        ),
                                        15.width,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ).paddingOnly(top: 20),
                          ),
                        )
                      : const Offstage(),

                  Database.isHost ? 20.height : const Offstage(),
                  Database.isHost
                      ? DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: AppColors.whiteColor.withValues(alpha: 0.22),
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        )
                      : const Offstage(),

                  Database.isHost ? 22.height : const Offstage(),

                  Database.isHost
                      ? Column(
                          children: [
                            GetBuilder<ProfileViewController>(
                              builder: (controller) {
                                return CommonInfoTile(
                                  onTap: () => Get.toNamed(AppRoutes.withdrawPage)?.then(
                                    (value) async {
                                      controller.onGetHostProfile();
                                    },
                                  ),
                                  text: EnumLocale.txtWithdraw.name.tr,
                                  imageAsset: AppAsset.hostWithDrawIcon,
                                  gradient: AppColors.walletGradiant,
                                );
                              },
                            ),
                            20.height,
                            CommonInfoTile(
                              onTap: () => Get.toNamed(AppRoutes.blockPage),
                              text: EnumLocale.txtBlockList.name.tr,
                              imageAsset: AppAsset.hostBlockIcon,
                              gradient: AppColors.blockList,
                            ),
                            20.height,
                            CommonInfoTile(
                              onTap: () => Get.toNamed(AppRoutes.appLanguagePage),
                              text: EnumLocale.txtAppLanguage.name.tr,
                              imageAsset: AppAsset.hostLanguageIcon,
                              gradient: AppColors.language,
                            ),
                            20.height,
                            CommonInfoTile(
                              onTap: () => Get.toNamed(AppRoutes.appSettingPage),
                              text: EnumLocale.txtSetting.name.tr,
                              imageAsset: AppAsset.hostSettingIcon,
                              gradient: AppColors.hostRequest,
                            ),
                            70.height
                          ],
                        )
                      : const Offstage(),

                  //************** User VIP view
                  Database.isHost
                      ? const Offstage()
                      : GetBuilder<ProfileViewController>(
                          builder: (logic) {
                            return GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.vipPage)?.then(
                                (value) {
                                  logic.update();
                                },
                              ),
                              child: const MoreContainerWidget(),
                            );
                          },
                        ),
                  22.height,

                  Database.isHost
                      ? const Offstage()
                      : DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: AppColors.whiteColor.withValues(alpha: 0.22),
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                  22.height,

                  //************** Profile bottom view
                  Database.isHost ? const Offstage() : const BottomProfileWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
