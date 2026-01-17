import 'dart:developer';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:figgy/custom/app_title/custom_title.dart';
import 'package:figgy/custom/bottom_sheet/report_bottom_sheet.dart';
import 'package:figgy/custom/custom_image/custom_profile_image.dart';
import 'package:figgy/custom/dialog/stop_live_dialog.dart';
import 'package:figgy/custom/gift_bottom_sheet/gift_bottom_sheet.dart';
import 'package:figgy/pages/discover_host_for_user_page/controller/discover_host_for_user_controller.dart';
import 'package:figgy/pages/host_live_page/controller/host_live_controller.dart';
import 'package:figgy/socket/socket_services.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/api_params.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svga/flutter_svga.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:marquee/marquee.dart';
import 'package:photo_view/photo_view.dart';

class HostLiveUi extends StatelessWidget {
  const HostLiveUi({super.key, required this.liveScreen});

  final Widget liveScreen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        liveScreen,
        Align(
          alignment: Alignment.center,
          child: GiftBottomSheetWidget.onShowGift(),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 400,
            width: Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.transparent, AppColors.blackColor.withValues(alpha: 0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          top: 45,
          child: SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GetBuilder<HostLiveController>(
                            builder: (controller) => GestureDetector(
                              child: Container(
                                height: 50,
                                width: 178,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(56),
                                  border: Border.all(
                                    color: AppColors.whiteColor.withValues(alpha: 0.2),
                                  ),
                                  color: AppColors.whiteColor.withValues(alpha: 0.12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    5.width,
                                    Container(
                                      height: 40,
                                      width: 40,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                                      ),
                                      child: Stack(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child: Image.asset(AppAsset.icProfilePlaceHolder),
                                          ),
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child: CustomImage(
                                              image: controller.image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    7.width,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 95,
                                          child: Text(
                                            controller.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppFontStyle.styleW600(AppColors.whiteColor, 14),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(AppAsset.icEye, width: 18),
                                            5.width,
                                            Obx(
                                              () => Text(
                                                CustomFormatNumber.convert(SocketServices.userWatchCount.value),
                                                maxLines: 1,
                                                style: AppFontStyle.styleW700(AppColors.whiteColor, 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      10.height,
                      GetBuilder<HostLiveController>(
                        id: AppConstant.onChangeTime,
                        builder: (controller) => Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(56),
                            color: AppColors.whiteColor.withValues(alpha: 0.12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAsset.icClock1,
                                width: 18,
                                color: AppColors.whiteColor,
                              ),
                              8.width,
                              Text(
                                controller.onConvertSecondToHMS(controller.countTime),
                                style: AppFontStyle.styleW700(AppColors.whiteColor, 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
                            Dialog(
                              backgroundColor: AppColors.transparent,
                              shadowColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              elevation: 0,
                              child: const StopLiveDialog(),
                            ),
                          );
                        },
                        child: Container(
                          height: 38,
                          width: 38,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.whiteColor, strokeAlign: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            AppAsset.icLiveOff,
                          ),
                        ),
                      ),
                      20.height,
                      GetBuilder<HostLiveController>(
                        id: AppConstant.idSwitchMic,
                        builder: (controller) => GestureDetector(
                          onTap: () => controller.onSwitchMic(),
                          child: Container(
                            height: 38,
                            width: 38,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.whiteColor, strokeAlign: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              controller.isMicOn ? AppAsset.icMuteMic : AppAsset.icUnMuteMic,
                            ),
                          ),
                        ),
                      ),
                      20.height,
                      GetBuilder<HostLiveController>(
                        builder: (controller) => GestureDetector(
                          onTap: () => controller.onSwitchCamera(),
                          child: Container(
                            height: 38,
                            width: 38,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.whiteColor, strokeAlign: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(AppAsset.icHostCamera),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          child: SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GetBuilder<HostLiveController>(
                builder: (controller) => CommentTextFieldUi(
                  controller: controller.commentController,
                  callback: () => controller.onSendComment(),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 70,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.transparent],
                stops: [0.0, 0.1, 0.8, 8.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstOut,
            child: Container(
              height: 250,
              width: Get.width / 1.8,
              color: AppColors.transparent,
              child: Obx(
                () => ListView.builder(
                  itemCount: SocketServices.mainLiveComments.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  reverse: true,
                  itemBuilder: (context, index) {
                    final data = SocketServices.mainLiveComments[index];
                    return CommentItemUi(
                      title: data[ApiParams.userName],
                      subTitle: data[ApiParams.commentText],
                      leading: data[ApiParams.userImage],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UserLiveUi extends StatelessWidget {
  final Widget liveScreen;
  final String liveRoomId;
  final String liveUserId;
  final bool liveStatus;

  const UserLiveUi({
    super.key,
    required this.liveScreen,
    required this.liveRoomId,
    required this.liveUserId,
    required this.liveStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        liveScreen,
        Align(
          alignment: Alignment.center,
          child: GiftBottomSheetWidget.onShowGift(),
        ),
        if (liveStatus) ...[
          Positioned(
            top: 51,
left: 200,
            child: GetBuilder<HostLiveController>(
                builder: (logic) {
                  return PopupMenuButton<String>(
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
                  );
                }
            ),
          ),
          Positioned(
            top: 40,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  clipBehavior: Clip.antiAlias,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      height: 750,
                      width: Get.width,
                      decoration: BoxDecoration(
                        gradient: AppColors.callOptionBottomSheet,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: GetBuilder<HostLiveController>(
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

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).viewPadding.top + 60,
                                padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                                alignment: Alignment.center,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor.withValues(alpha: 0.1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      28.width,
                                      Text(
                                        "Host Detail",
                                        style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                                      ),
                                      GestureDetector(
                                        onTap: Get.back,
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteColor.withValues(alpha: 0.5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            AppAsset.icCloseDialog,
                                            width: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ).paddingOnly(bottom: 10),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors.whiteColor.withValues(alpha: 0.50),
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
                                                  color: AppColors.colorTextGrey.withValues(alpha: 0.22),
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
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        blankSpace: 10.0,
                                                        velocity: 30.0,
                                                        pauseAfterRound: const Duration(seconds: 1),
                                                        startPadding: 0.0,
                                                        accelerationDuration: const Duration(seconds: 1),
                                                        accelerationCurve: Curves.linear,
                                                        decelerationDuration: const Duration(milliseconds: 500),
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
                                                    style: AppFontStyle.styleW500(AppColors.uniqueIdTxtColor, 14),
                                                  ),
                                                  5.width,
                                                  GestureDetector(
                                                    onTap: () {
                                                      Utils.copyText(logic.hostDetailModel?.host?.uniqueId ?? "");
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
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(80), color: AppColors.colorPink1),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          AppAsset.genderIcon,
                                                          height: 13,
                                                          width: 13,
                                                        ),
                                                        3.width,
                                                        Text(
                                                          logic.hostDetailModel?.host?.gender ?? "",
                                                          style: AppFontStyle.styleW700(AppColors.whiteColor, 12),
                                                        ),
                                                      ],
                                                    ).paddingSymmetric(vertical: 4, horizontal: 9),
                                                  ),
                                                  8.width,
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      color: AppColors.followerBgColor,
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(16),
                                                          bottomLeft: Radius.circular(16),
                                                          bottomRight: Radius.circular(16),
                                                          topRight: Radius.circular(16)),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Follower : ",
                                                          style: AppFontStyle.styleW600(AppColors.whiteColor, 12),
                                                        ),
                                                        Text(
                                                          logic.hostDetailModel?.host?.totalFollower.toString() ?? "",
                                                          style: AppFontStyle.styleW800(AppColors.whiteColor, 12),
                                                        ),
                                                      ],
                                                    ).paddingOnly(top: 3, bottom: 3, left: 7, right: 7),
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
                                                      padding: const EdgeInsets.only(right: 8, top: 2),
                                                      child: GetBuilder<HostLiveController>(
                                                        id: AppConstant.idFollowToggle,
                                                        builder: (controller) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              logic.onFollowToggle();
                                                            },
                                                            child: Container(
                                                              height: 26,
                                                              decoration: BoxDecoration(
                                                                color: logic.isFollow ? null : AppColors.followBgColor,
                                                                gradient: logic.isFollow ? AppColors.gradientButtonColor : null,
                                                                border: logic.isFollow
                                                                    ? null
                                                                    : Border.all(color: AppColors.whiteColor.withValues(alpha: 0.34)),
                                                                borderRadius: BorderRadius.circular(30),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Image.asset(logic.isFollow ? AppAsset.followingIcon2 : AppAsset.followIcon2,
                                                                      width: 14, height: 14),
                                                                  const SizedBox(width: 7),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Text(
                                                                        logic.isFollow
                                                                            ? EnumLocale.txtFollowing.name.tr
                                                                            : EnumLocale.txtFollow.name.tr,
                                                                        style: AppFontStyle.styleW700(Colors.white, 13),
                                                                      ),
                                                                    ],
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
                                      ).paddingOnly(left: 10, bottom: 17),
                                      HostDetailTitle(title: EnumLocale.txtAboutMe.name.tr).paddingOnly(left: 14),
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
                                      const UserBottomView(),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: SizedBox(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetBuilder<HostLiveController>(
                        builder: (controller) => GestureDetector(
                          child: Container(
                            height: 50,
                            width: 178,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(56),
                              border: Border.all(
                                color: AppColors.whiteColor.withValues(alpha: 0.2),
                              ),
                              color: AppColors.whiteColor.withValues(alpha: 0.12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                5.width,
                                Container(
                                  height: 40,
                                  width: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                                  ),
                                  child: Stack(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.asset(AppAsset.icProfilePlaceHolder),
                                      ),
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: CustomImage(
                                          image: controller.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                7.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 95,
                                      child: Text(
                                        controller.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFontStyle.styleW600(AppColors.whiteColor, 14),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(AppAsset.icEye, width: 18),
                                        5.width,
                                        Obx(
                                          () => Text(
                                            CustomFormatNumber.convert(SocketServices.userWatchCount.value),
                                            maxLines: 1,
                                            style: AppFontStyle.styleW700(AppColors.whiteColor, 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 34,
                          width: 34,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor.withValues(alpha: 0.1),
                            border: Border.all(
                              strokeAlign: 0.4,
                              color: AppColors.whiteColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Image.asset(
                            AppAsset.icClose,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 400,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.transparent, AppColors.blackColor.withValues(alpha: 0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            child: SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: GetBuilder<HostLiveController>(
                        builder: (controller) => CommentTextFieldUi(
                          controller: controller.commentController,
                          callback: () => controller.onSendComment(),
                        ),
                      ),
                    ),
                    15.width,
                    GetBuilder<HostLiveController>(
                      builder: (controller) {
                        return GestureDetector(
                          onTap: () {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                              currentFocus.focusedChild?.unfocus();
                            }

                            GiftBottomSheetWidget.show(
                              context: context,
                              callback: () {
                                controller.onSendGift();
                              },
                              isChat: false,
                            );
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor.withValues(alpha: 0.12),
                              border: Border.all(
                                strokeAlign: 0.4,
                                color: AppColors.whiteColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Image.asset(
                              AppAsset.icGift,
                            ).paddingAll(3),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 70,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.transparent],
                  stops: [0.0, 0.1, 0.8, 8.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstOut,
              child: Container(
                height: 250,
                width: Get.width / 1.8,
                color: AppColors.transparent,
                child: Obx(
                  () => ListView.builder(
                    itemCount: SocketServices.mainLiveComments.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    reverse: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = SocketServices.mainLiveComments[index];
                      return CommentItemUi(
                        title: data[ApiParams.userName],
                        subTitle: data[ApiParams.commentText],
                        leading: data[ApiParams.userImage],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class CommentTextFieldUi extends StatelessWidget {
  const CommentTextFieldUi({
    super.key,
    this.callback,
    this.controller,
  });

  final Callback? callback;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 15, right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.whiteColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          strokeAlign: 0.4,
          color: AppColors.whiteColor.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            height: 22,
            width: 22,
            AppAsset.icMessage,
            color: AppColors.whiteColor,
          ),
          5.width,
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: AppColors.coloGreyText.withValues(alpha: 0.3),
          ),
          5.width,
          Expanded(
            child: TextFormField(
              controller: controller,
              cursorColor: AppColors.whiteColor,
              style: AppFontStyle.styleW600(
                AppColors.whiteColor,
                14,
              ),
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 3),
                hintText: EnumLocale.txtTypeComment.name.tr,
                hintStyle: AppFontStyle.styleW600(AppColors.whiteColor, 16),
              ),
            ),
          ),
          GestureDetector(
            onTap: callback,
            child: Container(
              height: 40,
              width: 40,
              color: AppColors.transparent,
              child: Center(
                child: Image.asset(
                  width: 26,
                  AppAsset.icSend,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommentItemUi extends StatelessWidget {
  const CommentItemUi({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leading,
  });

  final String title;
  final String subTitle;
  final String leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: AppColors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor,
            ),
            padding: const EdgeInsets.all(0.8),
            child: Container(
              height: 40,
              width: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.colorTextGrey.withValues(alpha: 0.22),
              ),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(AppAsset.icProfilePlaceHolder),
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: CustomImage(
                      padding: 8,
                      image: leading,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          10.width,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: AppFontStyle.styleW600(AppColors.whiteColor, 12),
                ),
                4.height,
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      strokeAlign: 0.4,
                      color: AppColors.whiteColor.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    subTitle,
                    style: AppFontStyle.styleW600(AppColors.whiteColor, 13.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFormatNumber {
  static String convert(int number) {
    if (number >= 10000000) {
      double millions = number / 1000000;
      return '${millions.toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      double thousands = number / 1000;
      return '${thousands.toStringAsFixed(1)}k';
    } else {
      return number.toString();
    }
  }
}

class LiveStreamEndUi extends StatelessWidget {
  final String image;
  const LiveStreamEndUi({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.colorTextGrey.withValues(alpha: 0.22),
          height: Get.height,
          width: Get.width,
          child: CustomImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        BlurryContainer(
          blur: 10,
          elevation: 0,
          borderRadius: BorderRadius.zero,
          color: Colors.black45,
          child: SizedBox(
            height: Get.height,
            width: Get.width,
          ),
        ),
        Positioned(
          top: 40,
          child: SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetBuilder<HostLiveController>(
                    builder: (controller) => GestureDetector(
                      child: Container(
                        height: 50,
                        width: 178,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(56),
                          border: Border.all(
                            color: AppColors.whiteColor.withValues(alpha: 0.2),
                          ),
                          color: AppColors.whiteColor.withValues(alpha: 0.12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            5.width,
                            Container(
                              height: 40,
                              width: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                              ),
                              child: Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.asset(AppAsset.icProfilePlaceHolder),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: CustomImage(
                                      image: controller.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            7.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 95,
                                  child: Text(
                                    controller.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFontStyle.styleW600(AppColors.whiteColor, 14),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset(AppAsset.icEye, width: 18),
                                    5.width,
                                    Text(
                                      "0",
                                      maxLines: 1,
                                      style: AppFontStyle.styleW700(AppColors.whiteColor, 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GetBuilder<DiscoverHostForUserController>(
                    builder: (logic) {
                      return GestureDetector(
                        onTap: () async {
                          await logic.discoverHostForUser(country: logic.selectedCountry);
                          Get.back();
                        },
                        child: Container(
                          height: 34,
                          width: 34,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor.withValues(alpha: 0.1),
                            border: Border.all(
                              strokeAlign: 0.4,
                              color: AppColors.whiteColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Image.asset(
                            AppAsset.icClose,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.transparent,
                  border: Border.all(
                    color: AppColors.whiteColor,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  height: 125,
                  width: 125,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CustomImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              3.height,
              Text(
                "Live Stream Ended",
                style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class HostDetailsGift extends StatelessWidget {
  const HostDetailsGift({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostLiveController>(
      builder: (logic) {
        return logic.hostDetailModel?.receivedGifts?.isEmpty == true
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HostDetailTitle(title: EnumLocale.txtReceivedGifts.name.tr).paddingOnly(left: 14),
                  10.height,
                  SizedBox(
                    height: Get.height * 0.17,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      itemCount: logic.hostDetailModel?.receivedGifts?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final gift = logic.hostDetailModel?.receivedGifts?[index];

                        return Container(
                          width: 126,
                          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.receiveGiftBg,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Center(
                                      child: gift?.giftType == 3
                                          ? Container(
                                              width: 70,
                                              height: 70,
                                              padding: const EdgeInsets.all(10),
                                              child: SVGAEasyPlayer(
                                                resUrl: Api.baseUrl + (gift?.giftImage ?? ""),
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: Api.baseUrl + (gift?.giftImage ?? ""),
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.contain,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 38,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xff462766),
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(16),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "x${gift?.totalReceived ?? 0}",
                                      style: AppFontStyle.styleW700(
                                        AppColors.yellowColor1,
                                        14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }
}

class HostDetailLanguage extends StatelessWidget {
  const HostDetailLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HostDetailTitle(title: EnumLocale.txtLanguages.name.tr).paddingOnly(left: 14),
        10.height,
        GetBuilder<HostLiveController>(
          builder: (logic) {
            return Wrap(
              spacing: 12,
              runSpacing: 2,
              children: logic.language.map(
                (text) {
                  return Chip(
                    label: Text(
                      text,
                      style: AppFontStyle.styleW600(
                        AppColors.whiteColor,
                        15,
                      ),
                    ),
                    backgroundColor: AppColors.languageBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: AppColors.whiteColor.withValues(alpha: 0.20), width: 0.6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    labelPadding: EdgeInsets.zero,
                  );
                },
              ).toList(),
            ).paddingOnly(right: 14, left: 14);
          },
        ),
        16.height,
        HostDetailTitle(title: EnumLocale.txtImpression.name.tr).paddingOnly(left: 14),
        10.height,
        GetBuilder<HostLiveController>(
          builder: (logic) {
            return Wrap(
              spacing: 12,
              runSpacing: 2,
              children: logic.impression.map(
                (text) {
                  return Chip(
                    label: Text(
                      text,
                      style: AppFontStyle.styleW600(
                        AppColors.whiteColor,
                        15,
                      ),
                    ),
                    backgroundColor: AppColors.impressionBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: AppColors.whiteColor.withValues(alpha: 0.20), width: 0.6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                    labelPadding: EdgeInsets.zero,
                  );
                },
              ).toList(),
            ).paddingOnly(right: 14, left: 14);
          },
        ),
        18.height,
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String icon;
  final String? rate;
  final Color? bgColor;
  final Gradient gradient;
  final double? width;
  final Color? color;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
    this.rate,
    this.bgColor,
    this.width,
    required this.gradient,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: bgColor,
          gradient: gradient,
          border: Border.all(color: AppColors.whiteColor.withValues(alpha: 0.18)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 28,
              height: 28,
              color: color,
            ),
            SizedBox(width: width ?? 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: AppFontStyle.styleW800(Colors.white, 14),
                ),
                if (rate != null)
                  Row(
                    children: [
                      Image.asset(
                        AppAsset.icCoin,
                        width: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        rate!,
                        style: AppFontStyle.styleW800(Colors.white, 10),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HostDetailPhoto extends StatelessWidget {
  const HostDetailPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HostDetailTitle(title: EnumLocale.txtPhotos.name.tr).paddingOnly(left: 14),
        10.height,
        GetBuilder<HostLiveController>(
          builder: (logic) {
            return SizedBox(
              height: Get.height * 0.17,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 10),
                itemCount: logic.hostDetailModel?.host?.photoGallery?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  clipBehavior: Clip.antiAlias,
                  width: 123,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      log("image>>>>>>>>>>>>>>>>>>>>>>>>>>>>${Api.baseUrl + (logic.hostDetailModel?.host?.photoGallery?[index] ?? "")}");
                      showDialog(
                        context: context,
                        builder: (_) => imageView(Api.baseUrl + (logic.hostDetailModel?.host?.photoGallery?[index] ?? "")),
                      );
                    },
                    child: CustomImage(
                      image: logic.hostDetailModel?.host?.photoGallery?[index] ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget imageView(String imageUrl) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: PhotoView(
                  imageProvider: CachedNetworkImageProvider(imageUrl),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  basePosition: Alignment.center,
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.covered,
                  maxScale: PhotoViewComputedScale.covered * 2.5,
                  heroAttributes: const PhotoViewHeroAttributes(tag: "zoomable_image"),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () => Navigator.of(Get.overlayContext ?? Get.context!).pop(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserBottomView extends StatelessWidget {
  const UserBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          19.height,
          const HostDetailLanguage(),
          const HostDetailPhoto(),
          19.height,
          const HostDetailsGift(),
          10.height,
        ],
      ),
    );
  }
}
