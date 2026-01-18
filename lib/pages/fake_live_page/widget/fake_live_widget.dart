import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/custom/gift_bottom_sheet/gift_bottom_sheet.dart';
import 'package:LoveBirds/pages/fake_live_page/controller/fake_live_controller.dart';
import 'package:LoveBirds/pages/fake_live_page/widget/fake_comment_data.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:lottie/lottie.dart';

class UserLiveUi extends StatelessWidget {
  const UserLiveUi(
      {super.key,
      required this.liveScreen,
      required this.liveRoomId,
      required this.liveUserId});

  final Widget liveScreen;
  final String liveRoomId;
  final String liveUserId;

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);

    return Stack(
      children: [
        GetBuilder<FakeLiveController>(
          id: AppConstant.initializeVideoPlayer,
          builder: (controller) {
            return Container(
              color: AppColors.blackColor,
              width: Get.width,
              height: Get.height,
              child: controller.chewieController != null &&
                      controller.videoPlayerController != null &&
                      controller.videoPlayerController!.value.isInitialized
                  ? SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: controller
                                  .videoPlayerController?.value.size.width ??
                              0,
                          height: controller
                                  .videoPlayerController?.value.size.height ??
                              0,
                          child:
                              Chewie(controller: controller.chewieController!),
                        ),
                      ),
                    )
                  : Container(
                      height: Get.height,
                      width: Get.width,
                      color: AppColors.blackColor,
                      child: Stack(
                        children: [
                          Container(
                            color:
                                AppColors.colorTextGrey.withValues(alpha: 0.22),
                            height: Get.height,
                            width: Get.width,
                            child: CustomImage(
                              image: controller.image,
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
                                      color: AppColors.colorTextGrey
                                          .withValues(alpha: 0.22),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: CustomImage(
                                      image: controller.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                3.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      EnumLocale.txtConnect.name.tr,
                                      style: AppFontStyle.styleW700(
                                          AppColors.whiteColor, 20),
                                    ),
                                    Lottie.asset(
                                      AppAsset.lottieLoading,
                                      height: 35,
                                    ).paddingOnly(top: 10),
                                  ],
                                )
                              ],
                            ).paddingOnly(bottom: Get.height * 0.08),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
        Align(
          alignment: Alignment.center,
          child: GiftBottomSheetWidget.onShowGift(),
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
                  GetBuilder<FakeLiveController>(
                    builder: (controller) => GestureDetector(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(56),
                          border: Border.all(
                              color:
                                  AppColors.colorBorder.withValues(alpha: 0.3)),
                          color: AppColors.blackColor.withValues(alpha: 0.45),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            5.width,
                            Container(
                              height: 30,
                              width: 30,
                              clipBehavior: Clip.antiAlias,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.asset(
                                        AppAsset.icProfilePlaceHolder),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: CachedNetworkImage(
                                      imageUrl: Api.baseUrl + controller.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            10.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFontStyle.styleW600(
                                      AppColors.whiteColor, 12),
                                ),
                                GetBuilder<FakeLiveController>(
                                  id: AppConstant.onChangeTime,
                                  builder: (logic) {
                                    return Text(
                                      logic.onConvertSecondToHMS(
                                          logic.countTime),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFontStyle.styleW400(
                                          AppColors.whiteColor, 11),
                                    );
                                  },
                                ),
                              ],
                            ),
                            20.width,
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
        Positioned(
          bottom: 0,
          child: Container(
            height: 400,
            width: Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.transparent,
                  AppColors.blackColor.withValues(alpha: 0.7)
                ],
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
                    child: GetBuilder<FakeLiveController>(
                      builder: (controller) => CommentTextFieldUi(
                        controller: controller.commentController,
                        callback: () => controller.onSendComment(),
                      ),
                    ),
                  ),
                  15.width,
                  GetBuilder<FakeLiveController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          GiftBottomSheetWidget.show(
                            context: context,
                            callback: () {
                              controller.onSendGift();
                            },
                            isChat: false,
                          );
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
                              color:
                                  AppColors.whiteColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Image.asset(
                            AppAsset.icGift,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        GetBuilder<FakeLiveController>(
          id: AppConstant.initializeVideoPlayer,
          builder: (controller) {
            return controller.chewieController != null &&
                    controller.videoPlayerController != null &&
                    controller.videoPlayerController!.value.isInitialized
                ? Positioned(
                    left: 0,
                    bottom: 70,
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent
                          ],
                          stops: [0.0, 0.1, 0.8, 8.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstOut,
                      child: GetBuilder<FakeLiveController>(
                        builder: (controller) {
                          return Container(
                            height: 250,
                            width: Get.width / 1.8,
                            color: AppColors.transparent,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SingleChildScrollView(
                                controller: controller.scrollController,
                                child: ListView.builder(
                                  itemCount: fakeHostCommentListBlank.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return CommentItemUi(
                                      title:
                                          fakeHostCommentListBlank[index].user,
                                      subTitle: fakeHostCommentListBlank[index]
                                          .message,
                                      leading:
                                          fakeHostCommentListBlank[index].image,
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : const SizedBox();
          },
        ),
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
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            height: 22,
            width: 22,
            AppAsset.icMessage,
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
              cursorColor: AppColors.colorTextGrey,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 3),
                hintText: EnumLocale.txtTypeComment.name.tr,
                hintStyle: AppFontStyle.styleW400(AppColors.coloGreyText, 15),
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
                  color: AppColors.colorTextGrey,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 38,
                width: 38,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.colorBorder.withValues(alpha: 0.8)),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(AppAsset.icProfilePlaceHolder),
                    ),
                    AspectRatio(
                      aspectRatio: 1,
                      child: CustomImage(
                        image: leading,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                  style: AppFontStyle.styleW600(AppColors.whiteColor, 11.5),
                ),
                2.height,
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
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
