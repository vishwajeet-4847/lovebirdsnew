// ignore_for_file: must_be_immutable

import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/chat_page/api/host_blocking_user_api.dart';
import 'package:LoveBirds/pages/chat_page/api/user_blocking_host_api.dart';
import 'package:LoveBirds/pages/chat_page/model/host_block_user_model.dart';
import 'package:LoveBirds/pages/chat_page/model/usre_block_host_api.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnblockDialog extends StatelessWidget {
  final String hostId;
  final String userId;
  final bool isHost;

  UnblockDialog({
    super.key,
    required this.hostId,
    required this.userId,
    required this.isHost,
  });

  HostBlockUserApiModel? hostBlockUserApiModel;
  UserBlockHostApiModel? userBlockHostApiModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 320,
      padding: const EdgeInsets.all(15),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(48),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          15.height,
          Image.asset(
            AppAsset.unBlockIcon2,
            height: 100,
            width: 100,
            color: AppColors.redColor2,
          ),
          10.height,
          Text(
            isHost
                ? EnumLocale.txtUnBlockHost.name.tr
                : EnumLocale.txtUnBlockUser.name.tr,
            textAlign: TextAlign.center,
            style: AppFontStyle.styleW800(AppColors.blackColor, 30),
          ),
          4.height,
          Text(
            isHost
                ? EnumLocale.txtUnBlockDetailsHost.name.tr
                : EnumLocale.txtUnBlockDetailsUser.name.tr,
            textAlign: TextAlign.center,
            style: AppFontStyle.styleW600(AppColors.colorGryTxt, 18),
          ).paddingOnly(left: 7, right: 7),
          20.height,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Expanded(
          //       child: GestureDetector(
          //         onTap: () {
          //           Get.back();
          //         },
          //         child: Container(
          //           alignment: Alignment.center,
          //           height: 50,
          //           width: Get.width,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(50),
          //             color: AppColors.colorGry.withValues(alpha: 0.3),
          //           ),
          //           child: Text(
          //             EnumLocale.txtCancel.name.tr,
          //             style: AppFontStyle.styleW600(AppColors.blackColor, 18),
          //           ),
          //         ),
          //       ),
          //     ),
          //     10.width,
          //     Expanded(
          //       child: GestureDetector(
          //         onTap: () async {
          //           if (isHost) {
          //             final uid = FirebaseUid.onGet();
          //             final token = await FirebaseAccessToken.onGet();
          //
          //             userBlockHostApiModel = await UserBlockHostApi.callApi(
          //               hostId: hostId,
          //               token: token ?? "",
          //               uid: uid ?? "",
          //             );
          //
          //             if (userBlockHostApiModel?.status == true) {
          //               Utils.showToast(userBlockHostApiModel?.message ?? "");
          //               Get.close(2);
          //             } else {
          //               Utils.showToast(userBlockHostApiModel?.message ?? "");
          //             }
          //           } else {
          //             final uid = FirebaseUid.onGet();
          //             final token = await FirebaseAccessToken.onGet();
          //
          //             hostBlockUserApiModel = await HostBlockingUserApi.callApi(
          //               hostId: Database.hostId,
          //               token: token ?? "",
          //               uid: uid ?? "",
          //               userId: userId,
          //             );
          //
          //             if (hostBlockUserApiModel?.status == true) {
          //               Utils.showToast(hostBlockUserApiModel?.message ?? "");
          //               Get.close(2);
          //             } else {
          //               Utils.showToast(hostBlockUserApiModel?.message ?? "");
          //             }
          //           }
          //         },
          //         child: Container(
          //           alignment: Alignment.center,
          //           height: 50,
          //           width: Get.width,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(50),
          //             color: AppColors.redColor,
          //           ),
          //           child: Text(
          //             EnumLocale.txtUnblock.name.tr,
          //             style: AppFontStyle.styleW600(AppColors.whiteColor, 18),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ).paddingOnly(left: 7, right: 7),
          GestureDetector(
            onTap: () async {
              if (isHost) {
                final uid = FirebaseUid.onGet();
                final token = await FirebaseAccessToken.onGet();

                userBlockHostApiModel = await UserBlockHostApi.callApi(
                  hostId: hostId,
                  token: token ?? "",
                  uid: uid ?? "",
                );

                if (userBlockHostApiModel?.status == true) {
                  Utils.showToast(userBlockHostApiModel?.message ?? "");
                  Get.close(2);
                } else {
                  Utils.showToast(userBlockHostApiModel?.message ?? "");
                }
              } else {
                final uid = FirebaseUid.onGet();
                final token = await FirebaseAccessToken.onGet();

                hostBlockUserApiModel = await HostBlockingUserApi.callApi(
                  hostId: Database.hostId,
                  token: token ?? "",
                  uid: uid ?? "",
                  userId: userId,
                );

                if (hostBlockUserApiModel?.status == true) {
                  Utils.showToast(hostBlockUserApiModel?.message ?? "");
                  Get.close(2);
                } else {
                  Utils.showToast(hostBlockUserApiModel?.message ?? "");
                }
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 54,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.redColor2,
              ),
              child: Text(
                EnumLocale.txtUnblock.name.tr,
                style: AppFontStyle.styleW600(AppColors.whiteColor, 18),
              ),
            ),
          ),
          14.height,
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.colorGry.withValues(alpha: 0.3),
              ),
              child: Text(
                EnumLocale.txtCancel.name.tr,
                style: AppFontStyle.styleW600(AppColors.cancelTxtColor, 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
