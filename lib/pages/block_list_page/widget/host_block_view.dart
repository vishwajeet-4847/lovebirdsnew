import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/custom/dialog/unblock_dialog.dart';
import 'package:LoveBirds/custom/no_data_found/no_data_found.dart';
import 'package:LoveBirds/pages/block_list_page/api/get_blocked_user_api.dart';
import 'package:LoveBirds/pages/block_list_page/controller/block_list_controller.dart';
import 'package:LoveBirds/shimmer/block_list_shimmer.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostBlockView extends StatelessWidget {
  const HostBlockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAsset.allBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).viewPadding.top + 72,
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              alignment: Alignment.center,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.chatDetailTopColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.back,
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
                    EnumLocale.txtBlockList.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                  ),
                  45.width,
                ],
              ),
            ),
            const Expanded(child: HostBlockListView()),
          ],
        ),
      ),
    );
  }
}

class HostBlockListView extends StatelessWidget {
  const HostBlockListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlockController>(
      id: AppConstant.idUserBlockList,
      builder: (logic) {
        return logic.isHostLoading
            ? const BlockListShimmer()
            : LayoutBuilder(
                builder: (context, box) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      GetBlockedUserApi.startPagination = 1;
                      await logic.getUserBlockList(isPagination: false);
                    },
                    child: logic.userBlockList.isEmpty
                        ? SingleChildScrollView(
                            child: SizedBox(
                              height: box.maxHeight + 1,
                              child: NoDataFoundWidget(),
                            ),
                          )
                        : SingleChildScrollView(
                            child: SizedBox(
                              height: Get.height + 1,
                              child: SingleChildScrollView(
                                controller: logic.scrollController,
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(top: 0),
                                  itemCount: logic.userBlockList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 11, vertical: 8),
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: AppColors.settingColor,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(18),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: AppColors.whiteColor
                                                    .withValues(alpha: 0.70),
                                              ),
                                            ),
                                            child: Container(
                                              height: 48,
                                              width: 48,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.colorTextGrey
                                                    .withValues(alpha: 0.22),
                                              ),
                                              clipBehavior: Clip.hardEdge,
                                              child: CustomImage(
                                                padding: 8,
                                                image: logic
                                                        .userBlockList[index]
                                                        .userId
                                                        ?.image ??
                                                    "",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          16.width,
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                logic.userBlockList[index]
                                                        .userId?.name ??
                                                    "",
                                                style: AppFontStyle.styleW700(
                                                    AppColors.whiteColor, 20),
                                              ),
                                              1.height,
                                              Row(
                                                children: [
                                                  (logic
                                                              .userBlockList[
                                                                  index]
                                                              .userId
                                                              ?.countryFlagImage
                                                              ?.startsWith(
                                                                  "http") ==
                                                          true)
                                                      ? Image.network(
                                                          logic
                                                                  .userBlockList[
                                                                      index]
                                                                  .userId
                                                                  ?.countryFlagImage ??
                                                              "",
                                                          height: 10,
                                                        )
                                                      : Text(
                                                          logic
                                                                  .userBlockList[
                                                                      index]
                                                                  .userId
                                                                  ?.countryFlagImage ??
                                                              "",
                                                          style: AppFontStyle
                                                              .styleW400(
                                                                  AppColors
                                                                      .colorGry,
                                                                  19),
                                                        ),
                                                  8.width,
                                                  Text(
                                                    logic.userBlockList[index]
                                                            .userId?.country ??
                                                        "",
                                                    style:
                                                        AppFontStyle.styleW400(
                                                            AppColors.colorGry,
                                                            14),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          GetBuilder<BlockController>(
                                            builder: (logic) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.dialog(
                                                    barrierColor: AppColors
                                                        .blackColor
                                                        .withValues(alpha: 0.8),
                                                    Dialog(
                                                      backgroundColor:
                                                          AppColors.transparent,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      surfaceTintColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                      child: UnblockDialog(
                                                        hostId: logic
                                                                .userBlockList[
                                                                    index]
                                                                .userId
                                                                ?.id ??
                                                            "",
                                                        isHost: false,
                                                        userId: logic
                                                                .userBlockList[
                                                                    index]
                                                                .userId
                                                                ?.id ??
                                                            "",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color:
                                                        AppColors.unBlockColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(30),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        AppAsset.unBlockIcon2,
                                                        width: 18,
                                                        height: 18,
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                      Text(
                                                        EnumLocale
                                                            .txtUnblock.name.tr,
                                                        style: AppFontStyle
                                                            .styleW700(
                                                                AppColors
                                                                    .whiteColor,
                                                                15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ).paddingOnly(right: 11, left: 11, top: 15);
                                  },
                                ),
                              ),
                            ).paddingOnly(top: 3),
                          ),
                  );
                },
              );
      },
    );
  }
}
