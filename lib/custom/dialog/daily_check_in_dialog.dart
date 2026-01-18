import 'dart:developer';

import 'package:LoveBirds/common/gradiant_text.dart';
import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/custom/dialog/check_in_reward_dialog.dart';
import 'package:LoveBirds/pages/profile_page/controller/profile_controller.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/shimmer/daily_check_in_dialog_shimmer.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyCheckInDialog extends StatelessWidget {
  const DailyCheckInDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff451B66),
                  borderRadius: BorderRadius.all(
                    Radius.circular(22),
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            gradient: AppColors.gradientButtonColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(22),
                              topLeft: Radius.circular(22),
                            ),
                            image: const DecorationImage(
                              image: AssetImage(
                                AppAsset.dailyCheckInTopBg,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                EnumLocale.txtDailyCheckIn.name.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30,
                                  color: AppColors.whiteColor,
                                  shadows: [
                                    Shadow(
                                      color: AppColors.blackColor
                                          .withValues(alpha: 0.38),
                                      offset: const Offset(0, 1),
                                      blurRadius: 0,
                                    ),
                                  ],
                                ),
                              ).paddingOnly(left: 12, top: 13),
                              3.height,
                              SizedBox(
                                width: 220,
                                child: Text(
                                  maxLines: 3,
                                  overflow: TextOverflow.visible,
                                  EnumLocale.txtDailyCheckInDescription.name.tr,
                                  style: AppFontStyle.styleW600(
                                      AppColors.whiteColor, 14),
                                ).paddingOnly(left: 12),
                              ).paddingOnly(bottom: 10),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: -Get.height * 0.026,
                          child: Image.asset(
                            AppAsset.dailyCheckInImage,
                            width: 134,
                            height: 134,
                          ),
                        ),
                      ],
                    ),
                    GetBuilder<ProfileViewController>(
                      id: AppConstant.idDailyCheck,
                      builder: (logic) {
                        return logic.coinData.isEmpty == true
                            ? const DailyCheckInDialogShimmer()
                            : GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 3,
                                  childAspectRatio: 0.86,
                                ),
                                itemCount: logic.coinData.length,
                                itemBuilder: (context, index) {
                                  return GridTile(
                                    child: DailyCheckInContainer(
                                      day: '${index + 1}',
                                      index: index,
                                    ),
                                  );
                                },
                              );
                      },
                    ).paddingOnly(left: 8, right: 8, top: 18, bottom: 18),
                    GetBuilder<ProfileViewController>(
                      builder: (logic) {
                        return GestureDetector(
                          onTap: () async {
                            if (logic.isTodayCheckIn) {
                              log("User has already checked in today.");
                              Utils.showToast(
                                  "You have already checked in today");

                              Get.back();
                            } else {
                              Get.dialog(const LoadingWidget(),
                                  barrierDismissible: false);
                              await logic.earnCoinFromDailyCheckIn(context);

                              Get.close(2);

                              showBlockedUserDialog(coin: logic.todayCoin);
                            }
                          },
                          child: Center(
                            child: Container(
                              height: 52,
                              width: 342,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: logic.isTodayCheckIn
                                    ? AppColors.followGradient
                                    : AppColors.gradientButtonColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                EnumLocale.txtCheckIn.name.tr,
                                style: AppFontStyle.styleW700(
                                    AppColors.whiteColor, 18),
                              ),
                            ),
                          ),
                        );
                      },
                    ).paddingOnly(bottom: 15, right: 9, left: 9),
                  ],
                ),
              ),
              13.height,
              const DailyCheckInBottom(),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyCheckInBottom extends StatelessWidget {
  const DailyCheckInBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.vipPage),
      child: Container(
        alignment: Alignment.center,
        height: 96,
        width: Get.width - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage(AppAsset.moreVipImage),
                  fit: BoxFit.cover,
                ),
              ),
              height: Get.height,
              width: Get.width,
              child: Image.asset(
                AppAsset.vipBg,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.height,
                        Row(
                          children: [
                            Image.asset(
                              AppAsset.vipKingIcon,
                              height: 50,
                              width: 50,
                            ),
                            5.width,
                            const SizedBox(
                              height: 35,
                              child: Image(
                                image: AssetImage(AppAsset.vVipIcon),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        5.height,
                        Text(
                          EnumLocale.txtBecomeAVIPEnjoyPrivilege.name.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: AppColors.whiteColor,
                            shadows: [
                              Shadow(
                                color: AppColors.blackColor
                                    .withValues(alpha: 0.50),
                                offset: const Offset(1, 1.2),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 32,
                      width: 94,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withValues(alpha: 0.30),
                            offset: const Offset(0, 2),
                            blurRadius: 0,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: GradientText(
                          gradient: const LinearGradient(
                            colors: [AppColors.pinkColor, AppColors.blueColor],
                          ),
                          text: EnumLocale.txtVIEWMORE.name.tr,
                          style:
                              AppFontStyle.styleW700(AppColors.whiteColor, 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyCheckInContainer extends StatelessWidget {
  const DailyCheckInContainer(
      {super.key, required this.day, required this.index});
  final int index;
  final String day;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewController>(
      id: AppConstant.idDailyCheck,
      builder: (logic) {
        final value = logic.coinData[index];

        final isToday = (DateTime.now().day ==
            logic.onGetCustomGetCurrentWeekDate()[index].day);

        final today = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);

        final customDate = logic.onGetCustomGetCurrentWeekDate()[index];
        final isPreviousDay = customDate.isBefore(today);

        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.5, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: (isPreviousDay && value.isCheckIn == false)
                    ? const LinearGradient(colors: [
                        AppColors.disableColor,
                        AppColors.disableColor
                      ])
                    : (value.isCheckIn == true)
                        ? LinearGradient(colors: [
                            AppColors.transparent,
                            AppColors.transparent
                          ])
                        : (isToday && value.isCheckIn == false)
                            ? const LinearGradient(colors: [
                                AppColors.pinkColor,
                                AppColors.blueColor
                              ])
                            : const LinearGradient(
                                colors: [
                                  AppColors.disableColor,
                                  AppColors.disableColor
                                ],
                              ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withValues(alpha: 0.30),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              EnumLocale.txtDay.name.tr,
                              style: AppFontStyle.styleW800(
                                isPreviousDay && value.isCheckIn == false
                                    ? AppColors.dayColor
                                    : AppColors.whiteColor,
                                10,
                              ),
                            ),
                            9.height,
                            Text(
                              day,
                              style: AppFontStyle.styleW800(
                                isPreviousDay && value.isCheckIn == false
                                    ? AppColors.dayColor
                                    : AppColors.whiteColor,
                                10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    alignment: Alignment.center,
                    child: isPreviousDay && value.isCheckIn == false ||
                            value.isCheckIn == true
                        ? Image.asset(
                            AppAsset.disableCoinCheckIn,
                            height: 35,
                            width: 50,
                          )
                        : isToday
                            ? Image.asset(
                                AppAsset.coinIcon2,
                                height: 30,
                                width: 40,
                              )
                            : Image.asset(
                                AppAsset.disableCoinCheckIn,
                                height: 35,
                                width: 40,
                              ),
                  ),
                  const Spacer(),
                  Container(
                    height: 17,
                    decoration: BoxDecoration(
                      color: AppColors.checkInButtonColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: isPreviousDay && value.isCheckIn == false ||
                            value.isCheckIn == true
                        ? Text(
                            "${logic.coinData[index].reward.toString()} Coin",
                            style: AppFontStyle.styleW800(
                                AppColors.whiteColor, 10),
                          )
                        : Text(
                            "${logic.coinData[index].reward.toString()} Coin",
                            style: AppFontStyle.styleW800(
                                AppColors.whiteColor, 10),
                          ),
                  ).paddingSymmetric(horizontal: 10),
                  8.height,
                ],
              ),
            ),
            (value.isCheckIn == true ||
                    (isPreviousDay && value.isCheckIn == false))
                ? Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4.5, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: value.isCheckIn == true
                            ? AppColors.checkInColor.withValues(alpha: 0.58)
                            : AppColors.dailyCheckInPastBg,
                      ),
                      child: Center(
                        child: Container(
                          height: 15,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: value.isCheckIn == true
                                  ? [AppColors.pinkColor, AppColors.blueColor]
                                  : [
                                      AppColors.dailyCheckInPastDay,
                                      AppColors.dailyCheckInPastDay
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: value.isCheckIn == true
                                  ? AppColors.whiteColor
                                  : AppColors.whiteColor
                                      .withValues(alpha: 0.40),
                              width: 0.5,
                            ),
                          ),
                          margin: const EdgeInsets.only(left: 7, right: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              value.isCheckIn == true
                                  ? Image.asset(
                                      AppAsset.whiteCheckInIcon,
                                      height: 10,
                                      width: 10,
                                    )
                                  : const SizedBox.shrink(),
                              2.width,
                              Text(
                                value.isCheckIn == true
                                    ? EnumLocale.txtCheckedIn.name.tr
                                    : EnumLocale.txtLostThisDay.name.tr,
                                style: AppFontStyle.styleW800(
                                    AppColors.whiteColor, 8),
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 5),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
