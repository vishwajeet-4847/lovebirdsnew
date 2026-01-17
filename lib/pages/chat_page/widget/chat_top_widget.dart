import 'dart:developer';

import 'package:figgy/custom/bottom_sheet/report_bottom_sheet.dart';
import 'package:figgy/custom/custom_image/custom_profile_image.dart';
import 'package:figgy/pages/chat_page/controller/chat_controller.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatTopWidget extends StatelessWidget {
  const ChatTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).viewPadding.top + 72,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, left: 15, right: 15),
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
      child: GetBuilder<ChatController>(
        builder: (logic) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      color: AppColors.transparent,
                      width: 20,
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Center(
                        child: Image.asset(
                          AppAsset.icLeftArrow,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  10.width,
                  GestureDetector(
                    onTap: Database.isHost
                        ? null
                        : () {
                            Get.toNamed(AppRoutes.hostDetailPage, arguments: {
                              "hostId": logic.hostId,
                              "isOnline": logic.isOnline.toString(),
                            });
                          },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(border: Border.all(color: AppColors.borderColor), shape: BoxShape.circle),
                      child: Container(
                        height: 42,
                        width: 42,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        clipBehavior: Clip.hardEdge,
                        child: CustomImage(
                          image: logic.profileImage,
                          padding: 8,
                        ),
                      ),
                    ),
                  ),
                  10.width,
                  GestureDetector(
                    onTap: Database.isHost
                        ? null
                        : () {
                            Get.toNamed(AppRoutes.hostDetailPage, arguments: {
                              "hostId": logic.hostId,
                              "isOnline": logic.isOnline.toString(),
                            });
                          },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          logic.hostName,
                          style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                        ),
                        3.height,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                              color: logic.isOnline == true ? AppColors.lightGreenColor : AppColors.offLineBgColor,
                              borderRadius: BorderRadius.circular(60)),
                          child: Row(
                            children: [
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: logic.isOnline == true ? AppColors.greenColor : AppColors.offLineTxtColor,
                                ),
                              ),
                              3.width,
                              Text(
                                logic.isOnline == true ? "Online" : "Offline",
                                style: AppFontStyle.styleW700(logic.isOnline == true ? AppColors.greenColor : AppColors.offLineTxtColor, 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // GestureDetector(
              //   onTap: () => logic.getBlock(context: context),
              //   child: Container(
              //     width: 27,
              //     height: 27,
              //     color: AppColors.transparent,
              //     child: Image.asset(
              //       AppAsset.circleMoreIcon,
              //     ),
              //   ),
              // ),

              PopupMenuButton<String>(
                child: Container(
                  width: 27,
                  height: 27,
                  color: AppColors.transparent,
                  child: Image.asset(
                    AppAsset.circleMoreIcon,
                  ),
                ),
                onSelected: (value) {
                  if (value == EnumLocale.txtBlock.name.tr) {

                    logic.getBlock(context: context);
                    log("logic.hostDetailModel?.host?.id${logic.hostDetailModel?.host?.id}");
                    log("${Database.isHost}");
                    log("${Database.loginUserId}");

                  } else if (value == EnumLocale.txtReport.name.tr) {
                    ReportBottomSheetUi.show(
                      context: context,
                    );
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: EnumLocale.txtBlock.name.tr,
                    child: Text(EnumLocale.txtBlock.name.tr),
                  ),
                  PopupMenuItem(
                    value: EnumLocale.txtReport.name.tr,
                    child: Text(EnumLocale.txtReport.name.tr),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
