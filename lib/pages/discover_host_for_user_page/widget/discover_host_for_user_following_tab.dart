import 'package:LoveBirds/custom/bottom_sheet/video_bottom_sheet.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/custom/no_data_found/no_data_found.dart';
import 'package:LoveBirds/pages/discover_host_for_user_page/controller/discover_host_for_user_controller.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/shimmer/host_stream_bottom_shimmer.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DiscoverHostForUserFollowingTab extends StatelessWidget {
  const DiscoverHostForUserFollowingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GetBuilder<DiscoverHostForUserController>(
        id: AppConstant.idStreamPage1,
        builder: (logic) {
          return LayoutBuilder(
            builder: (context, box) {
              return logic.isLoading
                  ? const DiscoverHostForUserShimmer().paddingOnly(top: 10)
                  : RefreshIndicator(
                      onRefresh: () async {
                        await logic.discoverHostForUser(
                            country: logic.selectedCountry);
                      },
                      child: logic.followUserList.isEmpty
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
                                  child: GridView.builder(
                                    padding: const EdgeInsets.only(top: 12),
                                    itemCount: logic.followUserList.length,
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
                                      final hostList =
                                          logic.followUserList[index];

                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.hostDetailPage,
                                              arguments: {
                                                "hostId": hostList.id,
                                                "isOnline":
                                                    hostList.status ?? "",
                                              })?.then(
                                            (_) async {
                                              logic.discoverHostForUser(
                                                  country:
                                                      logic.selectedCountry);
                                            },
                                          );
                                        },
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(22),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                color: AppColors.colorTextGrey
                                                    .withValues(alpha: 0.22),
                                                height: Get.height,
                                                width: Get.width,
                                                child: CustomImage(
                                                  image: logic
                                                          .followUserList[index]
                                                          .image ??
                                                      "",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Spacer(),
                                                  Container(
                                                    height: 22,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5, right: 5),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withValues(
                                                              alpha: 0.48),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomLeft:
                                                            Radius.circular(12),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        hostList.status ==
                                                                "Live"
                                                            ? Lottie.asset(
                                                                AppAsset
                                                                    .lottieLive,
                                                                height: 70,
                                                              )
                                                            : Container(
                                                                height: 10,
                                                                width: 10,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: AppColors
                                                                          .whiteColor,
                                                                      width:
                                                                          0.4),
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
                                                              ).paddingOnly(
                                                                left: 4),
                                                        5.width,
                                                        Text(
                                                          hostList.status ==
                                                                  "Online"
                                                              ? EnumLocale
                                                                  .txtOnline
                                                                  .name
                                                                  .tr
                                                              : hostList.status ==
                                                                      "Offline"
                                                                  ? EnumLocale
                                                                      .txtOffline
                                                                      .name
                                                                      .tr
                                                                  : hostList.status ==
                                                                          "Live"
                                                                      ? EnumLocale
                                                                          .txtLive
                                                                          .name
                                                                          .tr
                                                                      : EnumLocale
                                                                          .txtBusy
                                                                          .name
                                                                          .tr,
                                                          style: AppFontStyle
                                                              .styleW500(
                                                            hostList.status ==
                                                                    "Live"
                                                                ? AppColors
                                                                    .greenColor
                                                                : AppColors
                                                                    .whiteColor,
                                                            11,
                                                          ),
                                                        ).paddingOnly(right: 7),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  height: 100,
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        AppColors.transparent,
                                                        AppColors.blackColor
                                                            .withValues(
                                                                alpha: 0.0),
                                                        AppColors.blackColor,
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // ======================= User Name =======================
                                              Positioned(
                                                bottom: 0,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: SizedBox(
                                                    height: 45,
                                                    width: Get.width * 0.41,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                logic
                                                                        .followUserList[
                                                                            index]
                                                                        .name ??
                                                                    "",
                                                                style: AppFontStyle
                                                                    .styleW700(
                                                                        AppColors
                                                                            .whiteColor,
                                                                        16),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                (hostList.countryFlagImage?.startsWith(
                                                                            "http") ==
                                                                        true)
                                                                    ? Image
                                                                        .network(
                                                                        "${hostList.countryFlagImage}",
                                                                        height:
                                                                            10,
                                                                      )
                                                                    : Text(
                                                                        hostList.countryFlagImage ??
                                                                            "",
                                                                      ),
                                                                5.width,
                                                                Text(
                                                                  hostList.country ??
                                                                      "",
                                                                  style: AppFontStyle
                                                                      .styleW600(
                                                                          AppColors
                                                                              .whiteColor,
                                                                          13),
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
                                                            hostList.id ?? "",
                                                        receiverName:
                                                            hostList.name ?? "",
                                                        receiverImage:
                                                            hostList.image ??
                                                                "",
                                                        audioCallCharge: hostList
                                                                .audioCallRate ??
                                                            0,
                                                        videoCallCharge: hostList
                                                                .privateCallRate ??
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
                                                  child: hostList.status ==
                                                          "Online"
                                                      ? Lottie.asset(
                                                          AppAsset
                                                              .lottieVideoCall,
                                                          fit: BoxFit.cover,
                                                          height: 44,
                                                        )
                                                      : Image.asset(
                                                          AppAsset.icBgNotCall,
                                                          fit: BoxFit.cover,
                                                          height: 44,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ).paddingOnly(bottom: 20),
                                ),
                              ),
                            ),
                    );
            },
          );
        },
      ),
    );
  }
}
