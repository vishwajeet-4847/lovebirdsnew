import 'dart:math';

import 'package:figgy/custom/custom_image/custom_profile_image.dart';
import 'package:figgy/custom/no_data_found/no_data_found.dart';
import 'package:figgy/pages/discover_host_for_user_page/controller/discover_host_for_user_controller.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/shimmer/host_stream_bottom_shimmer.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DiscoverHostForUserLiveHostTab extends StatelessWidget {
  const DiscoverHostForUserLiveHostTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GetBuilder<DiscoverHostForUserController>(
        id: AppConstant.idStreamPage1,
        builder: (logic) {
          return LayoutBuilder(
            builder: (context, box) {
              if (logic.isLoading) {
                return const DiscoverHostForUserShimmer().paddingOnly(top: 10);
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await logic.discoverHostForUser(country: logic.selectedCountry);
                },
                child: logic.liveHostList.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [SizedBox(height: box.maxHeight, child: NoDataFoundWidget())],
                      )
                    : GridView.builder(
                        controller: logic.scrollController,
                        padding: const EdgeInsets.only(
                          right: 4,
                          left: 4,
                          top: 10,
                          bottom: 20,
                        ),
                        itemCount: logic.liveHostList.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final liveHost = logic.liveHostList[index];
                          return GestureDetector(
                            onTap: () {
                              if (liveHost.isFake == true) {
                                final random = Random();
                                final List<String>? videoList = liveHost.liveVideo;
                                final String randomVideoUrl =
                                    (videoList != null && videoList.isNotEmpty) ? videoList[random.nextInt(videoList.length)] : "";

                                Get.toNamed(
                                  AppRoutes.fakeLivePage,
                                  arguments: {
                                    "isHost": false,
                                    "name": liveHost.name ?? "",
                                    "image": liveHost.image ?? "",
                                    "liveHistoryId": liveHost.liveHistoryId ?? "",
                                    "hostId": liveHost.hostId ?? "",
                                    "token": liveHost.token ?? "",
                                    "channel": liveHost.channel ?? "",
                                    "videoUrl": randomVideoUrl,
                                  },
                                )?.then((_) {
                                  logic.discoverHostForUser(country: logic.selectedCountry);
                                });
                              } else {
                                Get.toNamed(
                                  AppRoutes.hostLivePage,
                                  arguments: {
                                    "isHost": false,
                                    "name": liveHost.name ?? "",
                                    "image": liveHost.image ?? "",
                                    "liveHistoryId": liveHost.liveHistoryId ?? "",
                                    "hostId": liveHost.hostId ?? "",
                                    "token": liveHost.token ?? "",
                                    "channel": liveHost.channel ?? "",
                                  },
                                )?.then((_) {
                                  logic.discoverHostForUser(country: logic.selectedCountry);
                                });
                              }
                            },
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(22)),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: CustomImage(
                                      image: liveHost.image ?? "",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 22,
                                        padding: const EdgeInsets.symmetric(horizontal: 7),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.48),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Lottie.asset(AppAsset.lottieLive, height: 70),
                                            const SizedBox(width: 3),
                                            Text(
                                              EnumLocale.txtLive.name.tr,
                                              style: AppFontStyle.styleW500(AppColors.greenColor, 14),
                                            ),
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
                                            AppColors.blackColor.withValues(alpha: 0.0),
                                            AppColors.blackColor,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: SizedBox(
                                        height: 45,
                                        width: 150,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  liveHost.name ?? "",
                                                  style: AppFontStyle.styleW700(AppColors.whiteColor, 16),
                                                ),
                                                Row(
                                                  children: [
                                                    (liveHost.countryFlagImage?.startsWith("http") == true)
                                                        ? Image.network(
                                                            "${liveHost.countryFlagImage}",
                                                            height: 10,
                                                          )
                                                        : Text(liveHost.countryFlagImage ?? ""),
                                                    const SizedBox(width: 1),
                                                    Text(
                                                      liveHost.country ?? "",
                                                      style: AppFontStyle.styleW400(AppColors.whiteColor, 15),
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
                            ),
                          );
                        },
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
