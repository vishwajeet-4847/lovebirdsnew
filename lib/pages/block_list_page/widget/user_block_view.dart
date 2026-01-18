import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/custom/dialog/unblock_dialog.dart';
import 'package:LoveBirds/custom/no_data_found/no_data_found.dart';
import 'package:LoveBirds/pages/block_list_page/api/get_blocked_hosts_api.dart';
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

class UserBlockView extends StatelessWidget {
  const UserBlockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Container(
        height: Get.height,
        width: Get.width,
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
            const Expanded(child: UserBlockListView()),
          ],
        ),
      ),
    );
  }
}

class UserBlockListView extends StatelessWidget {
  const UserBlockListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlockController>(
      id: AppConstant.userViewUpdate,
      builder: (logic) {
        return logic.isUserLoading
            ? SizedBox(
                height: Get.height,
                child: const BlockListShimmer(),
              )
            : LayoutBuilder(builder: (context, box) {
                return RefreshIndicator(
                  onRefresh: () async {
                    GetBlockedHostsApi.startPagination = 1;
                    await logic.getHostBlockList();
                  },
                  child: logic.hostBlockList.isEmpty
                      ? SingleChildScrollView(
                          child: SizedBox(
                            height: box.maxHeight + 1,
                            child: NoDataFoundWidget(),
                          ),
                        )
                      : SingleChildScrollView(
                          child: SizedBox(
                            height: box.maxHeight + 1,
                            child: SingleChildScrollView(
                              controller: logic.scrollController,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: logic.hostBlockList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 11, vertical: 8),
                                    // height: 70,
                                    width: Get.width,
                                    // margin: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.settingColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(18)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: AppColors.whiteColor
                                                      .withValues(
                                                          alpha: 0.70))),
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
                                              image: logic.hostBlockList[index]
                                                      .hostId?.image ??
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
                                              logic.hostBlockList[index].hostId
                                                      ?.name ??
                                                  "",
                                              style: AppFontStyle.styleW700(
                                                  AppColors.whiteColor, 20),
                                            ),
                                            1.height,
                                            Row(
                                              children: [
                                                (logic
                                                            .hostBlockList[
                                                                index]
                                                            .hostId
                                                            ?.countryFlagImage
                                                            ?.startsWith(
                                                                "http") ==
                                                        true)
                                                    ? Image.network(
                                                        logic
                                                                .hostBlockList[
                                                                    index]
                                                                .hostId
                                                                ?.countryFlagImage ??
                                                            "",
                                                        height: 10,
                                                      )
                                                    : Text(
                                                        logic
                                                                .hostBlockList[
                                                                    index]
                                                                .hostId
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
                                                  logic.hostBlockList[index]
                                                          .hostId?.country ??
                                                      "",
                                                  style: AppFontStyle.styleW400(
                                                      AppColors.colorCountryTxt,
                                                      14),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Get.dialog(
                                              barrierColor: AppColors.blackColor
                                                  .withValues(alpha: 0.8),
                                              Dialog(
                                                backgroundColor:
                                                    AppColors.transparent,
                                                shadowColor: Colors.transparent,
                                                surfaceTintColor:
                                                    Colors.transparent,
                                                elevation: 0,
                                                child: UnblockDialog(
                                                  hostId: logic
                                                          .hostBlockList[index]
                                                          .hostId
                                                          ?.id ??
                                                      "",
                                                  isHost: true,
                                                  userId: "",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            // height: 35,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 8),
                                            decoration: const BoxDecoration(
                                              color: AppColors.unBlockColor,
                                              // border: Border.all(color: AppColors.purpleColor),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  AppAsset.unBlockIcon2,
                                                  width: 18,
                                                  height: 18,
                                                  color: AppColors.whiteColor,
                                                ),
                                                Text(
                                                  EnumLocale.txtUnblock.name.tr,
                                                  style: AppFontStyle.styleW700(
                                                      AppColors.whiteColor, 15),
                                                ),
                                              ],
                                            ),
                                          ),
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
              });
      },
    );
  }
}
