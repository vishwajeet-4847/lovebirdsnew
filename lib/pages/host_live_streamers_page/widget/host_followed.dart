import 'package:figgy/custom/custom_image/custom_profile_image.dart';
import 'package:figgy/pages/host_live_streamers_page/controller/host_live_streamers_controller.dart';
import 'package:figgy/shimmer/host_stream_bottom_shimmer.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostFollowed extends StatelessWidget {
  const HostFollowed({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        Utils.showLog("******************${Get.height}***************** ${box.maxHeight}");

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GetBuilder<HostLiveStreamersController>(
            id: AppConstant.idHostStreamPage3,
            builder: (logic) {
              return logic.isLoading
                  ? const DiscoverHostForUserShimmer().paddingOnly(top: 15)
                  : RefreshIndicator(
                      onRefresh: () async {
                        await logic.getCountryWishHost(country: logic.selectedCountry);
                      },
                      child: logic.followedHost.isEmpty
                          ? SingleChildScrollView(
                              child: SizedBox(
                                height: box.maxHeight + 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(child: Image.asset(AppAsset.imgEmptyData, height: 130)),
                                    Text(
                                      EnumLocale.txtNoDataFound.name.tr,
                                      style: AppFontStyle.styleW400(AppColors.whiteColor, 16),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: SizedBox(
                                  height: box.maxHeight + 1,
                                  child: SingleChildScrollView(
                                    controller: logic.scrollController,
                                    child: GridView.builder(
                                      padding: const EdgeInsets.only(top: 15),
                                      itemCount: logic.followedHost.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 18,
                                        crossAxisSpacing: 18,
                                        childAspectRatio: 0.8,
                                      ),
                                      itemBuilder: (context, index) {
                                        final hostList = logic.followedHost[index];
                                        return Container(
                                          clipBehavior: Clip.antiAlias,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(22)),
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                                                height: Get.height,
                                                width: Get.width,
                                                child: CustomImage(
                                                  image: hostList?.followerId?.image ?? "",
                                                  fit: BoxFit.cover,
                                                ),
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
                                                        // AppColors.colorBlack,
                                                      ],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // ======================= User Name =======================
                                              Positioned(
                                                bottom: 0,
                                                left: 5,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          hostList?.followerId?.name ?? "",
                                                          style: AppFontStyle.styleW700(AppColors.whiteColor, 16),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Text(
                                                          "ID: ${hostList?.followerId?.uniqueId ?? ""}",
                                                          style: AppFontStyle.styleW500(
                                                            AppColors.whiteColor,
                                                            13,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    // const Spacer(),
                                                    // GestureDetector(
                                                    //   onTap: () => logic.getBlock(
                                                    //     context: context,
                                                    //     userId: hostList?.followerId?.id ?? "",
                                                    //   ),
                                                    //   child: Image.asset(
                                                    //     AppAsset.circleMoreIcon,
                                                    //     height: 28,
                                                    //     width: 28,
                                                    //   ),
                                                    // ),
                                                    // GestureDetector(
                                                    //   onTap: () => Get.toNamed(AppRoutes.userLivePage),
                                                    //   child: hostList?.status == "Online"
                                                    //       ? Lottie.asset(
                                                    //           AppAsset.lottieVideoCall,
                                                    //           fit: BoxFit.cover,
                                                    //           height: 50,
                                                    //         )
                                                    //       : Image.asset(
                                                    //           AppAsset.icBgNotCall,
                                                    //           // indexData.image,
                                                    //           fit: BoxFit.cover,
                                                    //           height: 50,
                                                    //         ),
                                                    // ),
                                                  ],
                                                ).paddingOnly(left: 8, right: 8, bottom: 8),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 5,
                                                child: GestureDetector(
                                                  onTap: () => logic.getBlock(
                                                    context: context,
                                                    userId: hostList?.followerId?.id ?? "",
                                                  ),
                                                  child: Image.asset(
                                                    AppAsset.circleMoreIcon,
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                ).paddingOnly(right: 8, bottom: 15),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ).paddingOnly(bottom: 20),
                                  ),
                                ),
                              ),
                            ),
                    );
            },
          ),
        );
      },
    );
  }
}
