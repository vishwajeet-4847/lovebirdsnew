import 'package:dotted_line/dotted_line.dart';
import 'package:figgy/common/loading_widget.dart';
import 'package:figgy/custom/custom_image/custom_profile_image.dart';
import 'package:figgy/pages/verification_page/controller/verification_controller.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Database.isVerification ? Get.back() : Get.close(2);
        }
      },
      child: Scaffold(
        body: GetBuilder<VerificationController>(
          id: AppConstant.idHostStatus,
          builder: (logic) {
            return Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAsset.allBackgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: logic.isLoading
                  ? const Center(child: LoadingWidget()).paddingOnly(top: 0)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).viewPadding.top + 72,
                          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                          alignment: Alignment.center,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColors.chatDetailTopColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blackColor.withValues(alpha: 0.40),
                                offset: const Offset(0, -6),
                                blurRadius: 34,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Database.isVerification ? Get.back() : Get.close(2);
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    AppAsset.icLeftArrow,
                                    width: 10,
                                  ),
                                ),
                              ),
                              Text(
                                EnumLocale.txtVerificationDetails.name.tr,
                                style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                              ),
                              45.width,
                            ],
                          ),
                        ),
                        40.height,
                        Center(
                          child: Image.asset(
                            AppAsset.verificationImage,
                            width: 200,
                          ),
                        ),
                        15.height,
                        Center(
                          child: Text(
                            logic.fetchHostRequestStatusModel?.data == 1
                                ? EnumLocale.txtRequestPending.name.tr
                                : logic.fetchHostRequestStatusModel?.data == 2
                                    ? EnumLocale.txtRequestAccepted.name.tr
                                    : EnumLocale.txtRequestDecline.name.tr,
                            style: AppFontStyle.styleW900(AppColors.whiteColor, 30),
                          ),
                        ),
                        30.height,
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.verificationColor,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                    child: Container(
                                      height: 66,
                                      width: 66,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: CustomImage(
                                        padding: 8,
                                        image: Database.profileImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  15.width,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Database.userName,
                                        style: AppFontStyle.styleW800(AppColors.whiteColor, 20),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            Database.uniqueId,
                                            maxLines: 1,
                                            style: AppFontStyle.styleW600(AppColors.verificationTxtColor, 15),
                                          ),
                                          5.width,
                                          GestureDetector(
                                            onTap: () {
                                              Utils.copyText(Database.uniqueId);
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Image.asset(
                                                AppAsset.copy,
                                                height: 20,
                                                width: 20,
                                                color: AppColors.verificationTxtColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              20.height,
                              DottedLine(
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
                              20.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${EnumLocale.txtName.name.tr} : ",
                                    style: AppFontStyle.styleW600(AppColors.verificationTxtColor1, 16),
                                  ),
                                  Text(
                                    Database.userName,
                                    style: AppFontStyle.styleW700(AppColors.whiteColor, 16),
                                  )
                                ],
                              ),
                              20.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${EnumLocale.txtRequestId.name.tr} : ",
                                    style: AppFontStyle.styleW600(AppColors.verificationTxtColor1, 16),
                                  ),
                                  Text(
                                    Database.uniqueId,
                                    style: AppFontStyle.styleW700(AppColors.whiteColor, 16),
                                  )
                                ],
                              ),
                              20.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${EnumLocale.txtStatus.name.tr} : ",
                                    style: AppFontStyle.styleW600(AppColors.verificationTxtColor1, 16),
                                  ),
                                  Text(
                                    logic.fetchHostRequestStatusModel?.data == 1
                                        ? EnumLocale.txtPending.name.tr
                                        : logic.fetchHostRequestStatusModel?.data == 2
                                            ? EnumLocale.txtAccepted.name.tr
                                            : EnumLocale.txtDecline.name.tr,
                                    style: AppFontStyle.styleW700(
                                      logic.fetchHostRequestStatusModel?.data == 1
                                          ? AppColors.whiteColor
                                          : logic.fetchHostRequestStatusModel?.data == 2
                                              ? AppColors.darkGreenColor
                                              : AppColors.redColor2,
                                      16,
                                    ),
                                  ),
                                ],
                              ),
                              20.height,
                            ],
                          ).paddingOnly(right: 14, left: 14, top: 22),
                        ).paddingOnly(left: 26, right: 26),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
