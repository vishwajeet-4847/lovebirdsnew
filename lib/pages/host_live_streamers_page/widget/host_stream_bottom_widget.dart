import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/pages/host_live_streamers_page/controller/host_live_streamers_controller.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/shimmer/host_stream_bottom_shimmer.dart'
    as host_shimmer;
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HostStreamBottomWidget extends StatelessWidget {
  const HostStreamBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, box) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: GetBuilder<HostLiveStreamersController>(
            id: AppConstant.idHostStreamPage3,
            builder: (logic) {
              if (logic.isLoading && logic.hostList.isEmpty) {
                return const host_shimmer.DiscoverHostForUserShimmer();
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await logic.getCountryWishHost(
                      country: logic.selectedCountry);
                  logic.update([AppConstant.idHostStreamPage3]);
                },
                child: logic.hostList.isEmpty
                    ? _buildEmptyState(box)
                    : _buildHostGrid(logic, box),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState(BoxConstraints box) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: box.maxHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset(AppAsset.imgEmptyData, height: 130)),
            10.height,
            Text(
              EnumLocale.txtNoHostFound.name.tr,
              style: AppFontStyle.styleW400(AppColors.whiteColor, 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHostGrid(HostLiveStreamersController logic, BoxConstraints box) {
    // Add scroll listener for pagination
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (logic.scrollController.hasClients) {
        logic.scrollController.addListener(() {
          if (logic.scrollController.position.pixels ==
                  logic.scrollController.position.maxScrollExtent &&
              !logic.isLoadingMore &&
              logic.hasMoreData) {
            logic.loadMoreHosts();
          }
        });
      }
    });

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: logic.scrollController,
      child: Column(
        children: [
          GridView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: logic.hostList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final hostList = logic.hostList[index];
              return _buildHostCard(hostList, logic);
            },
          ),
          // Show loading indicator when loading more
          if (logic.isLoadingMore)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          // Show message when no more data
          if (!logic.hasMoreData && logic.hostList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'No more hosts to show',
                style: AppFontStyle.styleW400(AppColors.whiteColor, 14),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHostCard(dynamic hostList, HostLiveStreamersController logic) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.hostDetailPage,
        arguments: {
          "hostId": hostList?.id ?? "",
          "isOnline": hostList?.status ?? "",
        },
      )?.then((_) async {
        await logic.getCountryWishHost(country: logic.selectedCountry);
      }),
      child: Container(
        clipBehavior: Clip.antiAlias,
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
                image: hostList?.image ?? "",
                fit: BoxFit.cover,
              ),
            ),

            // Status Badge
            _buildStatusBadge(hostList),

            // Gradient Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.transparent,
                      AppColors.blackColor.withValues(alpha: 0.3),
                      AppColors.blackColor.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // User Info
            _buildUserInfo(hostList),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(dynamic hostList) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        height: 18,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.48),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hostList?.status == "Live")
              Lottie.asset(
                AppAsset.lottieLive,
                height: 12,
                width: 12,
              )
            else
              Container(
                height: 8,
                width: 8,
                margin: const EdgeInsets.only(left: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.whiteColor, width: 0.4),
                  color: hostList?.status == "Online"
                      ? AppColors.greenColor
                      : AppColors.redColor,
                  shape: BoxShape.circle,
                ),
              ),
            const SizedBox(width: 5),
            Text(
              _getStatusText(hostList?.status),
              style: AppFontStyle.styleW400(
                hostList?.status == "Live"
                    ? AppColors.greenColor
                    : AppColors.whiteColor,
                10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(String? status) {
    switch (status) {
      case "Online":
        return EnumLocale.txtOnline.name.tr;
      case "Offline":
        return EnumLocale.txtOffline.name.tr;
      case "Live":
        return EnumLocale.txtLive.name.tr;
      default:
        return EnumLocale.txtBusy.name.tr;
    }
  }

  Widget _buildUserInfo(dynamic hostList) {
    return Positioned(
      bottom: 7,
      left: 10,
      right: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hostList?.name ?? "",
            style: AppFontStyle.styleW700(AppColors.whiteColor, 17),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              if (hostList?.countryFlagImage?.startsWith("http") == true)
                Image.network(
                  hostList?.countryFlagImage ?? "",
                  height: 10,
                  errorBuilder: (context, error, stackTrace) => Text(
                    hostList?.countryFlagImage ?? "",
                    style: AppFontStyle.styleW400(AppColors.whiteColor, 15),
                  ),
                )
              else
                Text(
                  hostList?.countryFlagImage ?? "",
                  style: AppFontStyle.styleW400(AppColors.whiteColor, 15),
                ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  hostList?.country ?? "",
                  style: AppFontStyle.styleW400(AppColors.whiteColor, 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
