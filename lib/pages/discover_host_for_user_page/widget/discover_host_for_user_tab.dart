import 'dart:math';

import 'package:LoveBirds/custom/bottom_sheet/video_bottom_sheet.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/custom/no_data_found/no_data_found.dart';
import 'package:LoveBirds/pages/discover_host_for_user_page/controller/discover_host_for_user_controller.dart';
import 'package:LoveBirds/pages/discover_host_for_user_page/model/discover_host_for_user_model.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/shimmer/host_stream_bottom_shimmer.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DiscoverHostForUserTab extends StatelessWidget {
  const DiscoverHostForUserTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          Container(
            height: 30,
            alignment: Alignment.center,
            child: GetBuilder<DiscoverHostForUserController>(
              id: AppConstant.idStreamPage3,
              builder: (logic) {
                return Row(
                  children: [
                    logic.filterCountry.isEmpty
                        ? Container()
                        : logic.filterCountry == 'World Wide'
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  logic.filterData();
                                },
                                child: Container(
                                  height: 30,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.hostNextButton,
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: AppColors.whiteColor),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        logic.filterCountry,
                                        style: AppFontStyle.styleW600(
                                            AppColors.whiteColor, 12),
                                      ),
                                      3.width,
                                      Image.asset(
                                        AppAsset.icClose,
                                        color: AppColors.whiteColor,
                                        height: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ).paddingOnly(left: 15),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: logic.userCountry.length,
                        itemBuilder: (context, index) {
                          final indexData = logic.userCountry[index];
                          final bool isSelected =
                              logic.selectedCountry.trim().toLowerCase() ==
                                  indexData.trim().toLowerCase();

                          return isSelected
                              ? GestureDetector(
                                  onTap: () => logic.countryTab(index: index),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            color: AppColors.whiteColor),
                                        gradient: AppColors.hostNextButton),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: index == 0 ? 16 : 9),
                                          child: index == 0
                                              ? const Offstage()
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .whiteColor),
                                                      shape: BoxShape.circle),
                                                  child: Image.asset(
                                                    logic
                                                        .userCountryFlag[index],
                                                    width: 18,
                                                    height: 18,
                                                  ),
                                                ),
                                        ),
                                        index == 0 ? const SizedBox() : 7.width,
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: index == 0 ? 16 : 9),
                                          child: Text(
                                            logic.userCountry[index],
                                            style: AppFontStyle.styleW600(
                                                AppColors.whiteColor, 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ).paddingOnly(left: 8)
                              : GestureDetector(
                                  onTap: () => logic.countryTab(index: index),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: AppColors.colorTextGrey
                                          .withValues(alpha: 0.22),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: index == 0 ? 16 : 9,
                                          ),
                                          child: index == 0
                                              ? const Offstage()
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .whiteColor),
                                                      shape: BoxShape.circle),
                                                  child: Image.asset(
                                                    logic
                                                        .userCountryFlag[index],
                                                    width: 18,
                                                    height: 18,
                                                  ),
                                                ),
                                        ),
                                        index == 0 ? const SizedBox() : 7.width,
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: index == 0 ? 16 : 9),
                                          child: Text(
                                            logic.userCountry[index],
                                            style: AppFontStyle.styleW600(
                                                AppColors.whiteColor, 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ).paddingOnly(left: 8);
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        logic.onChangeCountry(context);
                      },
                      child: Container(
                        width: Get.width * 0.13,
                        decoration: BoxDecoration(
                            color: AppColors.globalColor,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.globalColor,
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                  offset: Offset(0, 0))
                            ]),
                        child: Center(
                          child: Image.asset(
                            AppAsset.globalIcon,
                            height: 35,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          20.height,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: GetBuilder<DiscoverHostForUserController>(
                id: AppConstant.idStreamPage1,
                builder: (logic) {
                  return LayoutBuilder(
                    builder: (context, box) {
                      return logic.isLoading
                          ? const DiscoverHostForUserShimmer()
                          : RefreshIndicator(
                              onRefresh: () async {
                                logic.update([AppConstant.idStreamPage1]);
                                await logic.discoverHostForUser(
                                    country: logic.selectedCountry);
                              },
                              child: logic.hostList.isEmpty
                                  ? SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      child: SizedBox(
                                        height: box.maxHeight,
                                        child: NoDataFoundWidget(),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      controller: logic.scrollController,
                                      child: GridView.builder(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        itemCount: logic.hostList.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 18,
                                          crossAxisSpacing: 18,
                                          childAspectRatio: 0.8,
                                        ),
                                        itemBuilder: (context, index) {
                                          Host hostList =
                                              logic.hostList[index] ?? Host();

                                          return GestureDetector(
                                            onTap: () {
                                              if (hostList.status == "Live") {
                                                if (hostList.isFake == true) {
                                                  final random = Random();
                                                  final List<String>?
                                                      videoList =
                                                      hostList.liveVideo;
                                                  final String randomVideoUrl =
                                                      (videoList != null &&
                                                              videoList
                                                                  .isNotEmpty)
                                                          ? videoList[random
                                                              .nextInt(videoList
                                                                  .length)]
                                                          : "";

                                                  Get.toNamed(
                                                    AppRoutes.fakeLivePage,
                                                    arguments: {
                                                      "isHost": false,
                                                      "name":
                                                          hostList.name ?? "",
                                                      "image":
                                                          hostList.image ?? "",
                                                      "liveHistoryId": hostList
                                                              .liveHistoryId ??
                                                          "",
                                                      "hostId":
                                                          hostList.hostId ?? "",
                                                      "token":
                                                          hostList.token ?? "",
                                                      "channel":
                                                          hostList.channel ??
                                                              "",
                                                      "videoUrl":
                                                          randomVideoUrl,
                                                    },
                                                  )?.then((_) {
                                                    logic.discoverHostForUser(
                                                        country: logic
                                                            .selectedCountry);
                                                  });
                                                } else {
                                                  Get.toNamed(
                                                    AppRoutes.hostLivePage,
                                                    arguments: {
                                                      "isHost": false,
                                                      "name":
                                                          hostList.name ?? "",
                                                      "image":
                                                          hostList.image ?? "",
                                                      "liveHistoryId": hostList
                                                              .liveHistoryId ??
                                                          "",
                                                      "hostId":
                                                          hostList.id ?? "",
                                                      "token":
                                                          hostList.token ?? "",
                                                      "channel":
                                                          hostList.channel ??
                                                              "",
                                                    },
                                                  )?.then((_) {
                                                    logic.discoverHostForUser(
                                                        country: logic
                                                            .selectedCountry);
                                                  });
                                                }
                                              } else {
                                                Get.toNamed(
                                                    AppRoutes.hostDetailPage,
                                                    arguments: {
                                                      "hostId": hostList.id,
                                                      "isOnline":
                                                          hostList.status ?? "",
                                                    })?.then((_) async {
                                                  await logic
                                                      .discoverHostForUser(
                                                          country: logic
                                                              .selectedCountry);
                                                });
                                              }
                                            },
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(22)),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    color: AppColors
                                                        .colorTextGrey
                                                        .withValues(
                                                            alpha: 0.22),
                                                    child: CustomImage(
                                                      image:
                                                          hostList.image ?? "",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  //*************** Host Status
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Container(
                                                      height: 18,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withValues(
                                                                alpha: 0.48),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  12),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          if (hostList.status ==
                                                              "Live")
                                                            Lottie.asset(
                                                              AppAsset
                                                                  .lottieLive,
                                                              height: 12,
                                                              width: 12,
                                                            )
                                                          else
                                                            Container(
                                                              height: 8,
                                                              width: 8,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 2),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: AppColors
                                                                        .whiteColor,
                                                                    width: 0.4),
                                                                color: hostList
                                                                            .status ==
                                                                        "Online"
                                                                    ? AppColors
                                                                        .greenColor
                                                                    : AppColors
                                                                        .redColor,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                            logic.getStatusText(
                                                                hostList
                                                                    .status),
                                                            style: AppFontStyle
                                                                .styleW400(
                                                              hostList
                                                                          .status ==
                                                                      "Live"
                                                                  ? AppColors
                                                                      .greenColor
                                                                  : AppColors
                                                                      .whiteColor,
                                                              10,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  //*************** Gradient Overlay
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: Container(
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            AppColors
                                                                .transparent,
                                                            AppColors.blackColor
                                                                .withValues(
                                                                    alpha: 0.3),
                                                            AppColors.blackColor
                                                                .withValues(
                                                                    alpha: 0.8),
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  //*************** Host Info
                                                  Positioned(
                                                    bottom: 8,
                                                    left: 8,
                                                    child: SizedBox(
                                                      width: 130,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            hostList.name ?? "",
                                                            style: AppFontStyle
                                                                .styleW700(
                                                                    AppColors
                                                                        .whiteColor,
                                                                    16),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          const SizedBox(
                                                              height: 2),
                                                          Row(
                                                            children: [
                                                              if (hostList
                                                                      .countryFlagImage
                                                                      ?.startsWith(
                                                                          "http") ==
                                                                  true)
                                                                Image.network(
                                                                  hostList.countryFlagImage ??
                                                                      "",
                                                                  height: 10,
                                                                  errorBuilder:
                                                                      (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          Text(
                                                                    hostList.countryFlagImage ??
                                                                        "",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            13),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                )
                                                              else
                                                                Text(
                                                                  hostList.countryFlagImage ??
                                                                      "",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              Expanded(
                                                                child: Text(
                                                                  hostList.country ??
                                                                      "",
                                                                  style: AppFontStyle
                                                                      .styleW600(
                                                                          AppColors
                                                                              .whiteColor,
                                                                          13),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  //*************** Call Button
                                                  Positioned(
                                                    bottom: 8,
                                                    right: 8,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (hostList.status ==
                                                            "Online") {
                                                          showVideoBottomSheet(
                                                            context: context,
                                                            receiverId:
                                                                hostList.id ??
                                                                    "",
                                                            receiverName:
                                                                hostList.name ??
                                                                    "",
                                                            receiverImage:
                                                                hostList.image ??
                                                                    "",
                                                            audioCallCharge:
                                                                hostList.audioCallRate ??
                                                                    0,
                                                            videoCallCharge:
                                                                hostList.privateCallRate ??
                                                                    0,
                                                            isFake:
                                                                hostList.isFake ==
                                                                        true
                                                                    ? true
                                                                    : false,
                                                            videoList:
                                                                hostList.video,
                                                          );
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 38,
                                                        width: 38,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          color: hostList
                                                                      .status !=
                                                                  "Online"
                                                              ? Colors.black
                                                                  .withValues(
                                                                      alpha:
                                                                          0.3)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                        child:
                                                            hostList.status ==
                                                                    "Online"
                                                                ? Lottie.asset(
                                                                    AppAsset
                                                                        .lottieVideoCall,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 50,
                                                                  )
                                                                : Image.asset(
                                                                    AppAsset
                                                                        .icBgNotCall,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 50,
                                                                  ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
