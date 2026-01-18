import 'package:LoveBirds/custom/app_title/custom_title.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/custom/dialog/block_dialog.dart';
import 'package:LoveBirds/pages/host_detail_page/controller/host_detail_controller.dart';
import 'package:LoveBirds/pages/host_detail_page/widget/bottom_view_widget.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class MultiImg extends StatelessWidget {
  const MultiImg({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostDetailController>(
      builder: (logic) {
        double calculateTextWidth(String text, TextStyle style) {
          final TextPainter textPainter = TextPainter(
            text: TextSpan(text: text, style: style),
            maxLines: 1,
            textDirection: TextDirection.ltr,
          )..layout();
          return textPainter.size.width;
        }

        final name = logic.hostDetailModel?.host?.name ?? "";
        final textStyle = AppFontStyle.styleW800(AppColors.whiteColor, 20);
        final containerWidth = Get.width * 0.40;
        final textWidth = calculateTextWidth(name, textStyle);
        final isOverflow = textWidth > containerWidth;

        return SingleChildScrollView(
          child: Column(
            children: [
              // =================== Header with Circle Image ====================
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                    width: Get.width,
                    height: 360,
                    child: CustomImage(
                      image: logic.hostDetailModel?.host?.image ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        color: AppColors.transparent,
                        child: Image.asset(
                          AppAsset.whiteBackArrow,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                  Database.isHost
                      ? const SizedBox()
                      : Positioned(
                          top: 20,
                          right: 13,
                          child: GestureDetector(
                            onTap: () {
                              Dialog(
                                backgroundColor: AppColors.transparent,
                                shadowColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                elevation: 0,
                                child: BlockDialog(
                                  hostId: logic.hostDetailModel?.host?.id ?? "",
                                  isHost: false,
                                  userId: Database.loginUserId,
                                ),
                              );
                              Get.dialog(
                                barrierColor:
                                    AppColors.blackColor.withValues(alpha: 0.8),
                                Dialog(
                                  backgroundColor: AppColors.transparent,
                                  shadowColor: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,
                                  elevation: 0,
                                  child: BlockDialog(
                                    hostId:
                                        logic.hostDetailModel?.host?.id ?? "",
                                    isHost: true,
                                    userId: Database.loginUserId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              color: AppColors.transparent,
                              height: 50,
                              width: 30,
                              child: Center(
                                child: Icon(
                                  Icons.more_vert,
                                  size: 20,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                  Database.isHost
                      ? const Offstage()
                      : Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.only(left: 8, right: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColors.colorGold1,
                              border: Border.all(
                                color: AppColors.colorDialog
                                    .withValues(alpha: 0.5),
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAsset.icVip1,
                                  width: 65,
                                ),
                                5.width,
                                GetBuilder<HostDetailController>(
                                  id: AppConstant.idVipChangeTab,
                                  builder: (logic) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.colorDarkBrown,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Row(
                                        children: [
                                          logic.frameLoading
                                              ? CupertinoActivityIndicator(
                                                  color: AppColors.colorGold1,
                                                  radius: 6,
                                                ).paddingOnly(left: 8)
                                              : Text(
                                                  "${logic.finalCallRate}",
                                                  style: AppFontStyle.styleW800(
                                                      AppColors.colorGold1, 13),
                                                ).paddingOnly(
                                                  top: 3, bottom: 3, left: 8),
                                          Text(
                                            "/Min",
                                            style: AppFontStyle.styleW800(
                                                AppColors.colorGold1, 13),
                                          ).paddingOnly(
                                              top: 3, bottom: 3, right: 8),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              ),

              // =================== Profile Content ====================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.primaryColor1,
                    padding:
                        const EdgeInsets.only(bottom: 10, top: 10, left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.whiteColor
                                    .withValues(alpha: 0.50),
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.all(0.8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              height: 78,
                              width: 78,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.colorTextGrey
                                    .withValues(alpha: 0.22),
                              ),
                              child: CustomImage(
                                image: logic.hostDetailModel?.host?.image ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        14.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: containerWidth,
                              height: 26,
                              child: isOverflow
                                  ? Marquee(
                                      text: name,
                                      style: textStyle,
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      blankSpace: 10.0,
                                      velocity: 30.0,
                                      pauseAfterRound:
                                          const Duration(seconds: 1),
                                      startPadding: 0.0,
                                      accelerationDuration:
                                          const Duration(seconds: 1),
                                      accelerationCurve: Curves.linear,
                                      decelerationDuration:
                                          const Duration(milliseconds: 500),
                                      decelerationCurve: Curves.easeOut,
                                    )
                                  : Text(
                                      name,
                                      style: textStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                            4.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  logic.hostDetailModel?.host?.uniqueId ?? "",
                                  maxLines: 1,
                                  style: AppFontStyle.styleW500(
                                      AppColors.uniqueIdTxtColor, 14),
                                ),
                                5.width,
                                GestureDetector(
                                  onTap: () {
                                    Utils.copyText(
                                        logic.hostDetailModel?.host?.uniqueId ??
                                            "");
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      AppAsset.copy,
                                      height: 17,
                                      width: 17,
                                      color: AppColors.colorGry,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            8.height,
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color: AppColors.colorPink1),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        AppAsset.genderIcon,
                                        height: 13,
                                        width: 13,
                                      ),
                                      3.width,
                                      Text(
                                        logic.hostDetailModel?.host?.gender ??
                                            "",
                                        style: AppFontStyle.styleW700(
                                            AppColors.whiteColor, 12),
                                      ),
                                    ],
                                  ).paddingSymmetric(
                                      vertical: 4, horizontal: 9),
                                ),
                                8.width,
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.followerBgColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${EnumLocale.txtFollowers.name.tr} : ",
                                        style: AppFontStyle.styleW600(
                                            AppColors.whiteColor, 12),
                                      ),
                                      Text(
                                        logic.hostDetailModel?.host
                                                ?.totalFollower
                                                .toString() ??
                                            "",
                                        style: AppFontStyle.styleW800(
                                            AppColors.whiteColor, 12),
                                      ),
                                    ],
                                  ).paddingOnly(
                                      top: 3, bottom: 3, left: 7, right: 7),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Database.isHost
                                ? const Offstage()
                                : Padding(
                                    padding:
                                        const EdgeInsets.only(right: 8, top: 2),
                                    child: GetBuilder<HostDetailController>(
                                      id: AppConstant.idFollowToggle,
                                      builder: (controller) {
                                        return GestureDetector(
                                          onTap: () {
                                            logic.onFollowToggle();
                                          },
                                          child: Container(
                                            height: 26,
                                            decoration: BoxDecoration(
                                              color: logic.isFollow
                                                  ? null
                                                  : AppColors.followBgColor,
                                              gradient: logic.isFollow
                                                  ? AppColors
                                                      .gradientButtonColor
                                                  : null,
                                              border: logic.isFollow
                                                  ? null
                                                  : Border.all(
                                                      color: AppColors
                                                          .whiteColor
                                                          .withValues(
                                                              alpha: 0.34),
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    logic.isFollow
                                                        ? AppAsset
                                                            .followingIcon2
                                                        : AppAsset.followIcon2,
                                                    width: 14,
                                                    height: 14),
                                                const SizedBox(width: 7),
                                                Text(
                                                  logic.isFollow
                                                      ? EnumLocale
                                                          .txtFollowing.name.tr
                                                      : EnumLocale
                                                          .txtFollow.name.tr,
                                                  style: AppFontStyle.styleW700(
                                                      Colors.white, 13),
                                                ),
                                              ],
                                            ).paddingSymmetric(horizontal: 9),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        )
                      ],
                    ),
                  ),
                  18.height,
                  HostDetailTitle(title: EnumLocale.txtAboutMe.name.tr)
                      .paddingOnly(left: 14),
                  10.height,
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor1,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      logic.hostDetailModel?.host?.bio ?? "",
                      style: AppFontStyle.styleW500(AppColors.whiteColor, 12),
                    ).paddingAll(10),
                  ).paddingOnly(left: 14, right: 14),
                  const UserBottomViewWidget(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
