// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:figgy/pages/chat_page/api/host_blocking_user_api.dart';
import 'package:figgy/pages/chat_page/api/user_blocking_host_api.dart';
import 'package:figgy/pages/chat_page/model/host_block_user_model.dart';
import 'package:figgy/pages/chat_page/model/usre_block_host_api.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../firebase/firebase_access_token.dart';
import '../../firebase/firebase_uid.dart';

class BlockDialog extends StatelessWidget {
  final String hostId;
  final String userId;
  final bool isHost;
  final bool? isChatHostDetail;
  final bool? isVideoCall;
  final bool? isLive;

  BlockDialog({
    super.key,
    required this.hostId,
    required this.userId,
    required this.isHost,
    this.isChatHostDetail,
    this.isVideoCall,
    this.isLive,
  });

  UserBlockHostApiModel? userBlockHostApiModel;
  HostBlockUserApiModel? hostBlockUserApiModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      width: 330,
      padding: const EdgeInsets.all(15),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          15.height,
          Image.asset(
            AppAsset.unBlockIcon2,
            height: 100,
            width: 100,
          ),
          10.height,
          Text(
            isHost
                ? EnumLocale.txtBlockHost.name.tr
                : EnumLocale.txtBlockUser.name.tr,
            textAlign: TextAlign.center,
            style: AppFontStyle.styleW800(AppColors.blackColor, 30),
          ),
          4.height,
          Text(
            isHost
                ? EnumLocale.txtBlockDetailsHost.name.tr
                : EnumLocale.txtBlockDetailsUser.name.tr,
            textAlign: TextAlign.center,
            style: AppFontStyle.styleW600(AppColors.colorGryTxt, 18),
          ).paddingOnly(left: 7, right: 7),
          20.height,
          GestureDetector(
            onTap: () async {

              if(isLive== true){
                final uid = FirebaseUid.onGet();
                final token = await FirebaseAccessToken.onGet();

                log("hostId api::::::::::::::::$hostId");

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


              }else{
              log("hostId api::::::::::::::::$hostId");
              if (isHost) {
                final uid = FirebaseUid.onGet();
                final token = await FirebaseAccessToken.onGet();

                log("hostId api::::::::::::::::$hostId");

                userBlockHostApiModel = await UserBlockHostApi.callApi(
                  hostId: hostId,
                  token: token ?? "",
                  uid: uid ?? "",
                );

                if (userBlockHostApiModel?.status == true) {
                  Utils.showToast(userBlockHostApiModel?.message ?? "");
                  if (Get.currentRoute == AppRoutes.chatPage ||
                      Get.currentRoute == AppRoutes.hostDetailPage) {
                    if (isChatHostDetail == true) {
                      Get.close(3);
                    } else {
                      Get.close(2);
                    }
                  } else if (Get.currentRoute == AppRoutes.videoCallPage) {
                    if (isVideoCall == true) {
                      Get.close(2);
                    }
                  } else {
                    Get.back();
                  }
                } else {
                  Utils.showToast(userBlockHostApiModel?.message ?? "");
                }
              } else {
                final uid = FirebaseUid.onGet();
                final token = await FirebaseAccessToken.onGet();
                log("hostId api::::::::::::::::$hostId");
                hostBlockUserApiModel = await HostBlockingUserApi.callApi(
                  hostId: Database.hostId,
                  token: token ?? "",
                  uid: uid ?? "",
                  userId: userId,
                );

                if (hostBlockUserApiModel?.status == true) {
                  Utils.showToast(hostBlockUserApiModel?.message ?? "");

                  if (Get.currentRoute == AppRoutes.chatPage) {
                    Get.close(2);
                  } else if (Get.currentRoute == AppRoutes.videoCallPage) {
                    Get.close(2);
                  } else {
                    Get.back();
                  }
                } else {
                  Utils.showToast(hostBlockUserApiModel?.message ?? "");
                }
              }}
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.redColor2,
              ),
              child: Text(
                EnumLocale.txtBlock.name.tr,
                style: AppFontStyle.styleW600(AppColors.whiteColor, 17),
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
              height: 54,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.cancelColor,
              ),
              child: Text(
                EnumLocale.txtCancel.name.tr,
                style: AppFontStyle.styleW700(AppColors.cancelTxtColor, 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
