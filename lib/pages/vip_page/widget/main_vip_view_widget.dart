import 'package:dots_indicator/dots_indicator.dart';
import 'package:figgy/pages/vip_page/controller/vip_controller.dart';
import 'package:figgy/pages/vip_page/widget/carousel_slider.dart';
import 'package:figgy/pages/vip_page/widget/vip_button_widget.dart';
import 'package:figgy/shimmer/vip_view_shimmer.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainVIPViewWidget extends StatelessWidget {
  const MainVIPViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      decoration: const BoxDecoration(
        color: AppColors.vipBottomSheetColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
          bottom: Radius.circular(26),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAsset.icVipLeftTitle,
                fit: BoxFit.cover,
                width: 50,
              ),
              10.width,
              Text(
                EnumLocale.txtVIPEnjoyPrivileges.name.tr,
                style: AppFontStyle.styleW700(AppColors.vipTxtColor, 18),
              ),
              10.width,
              Image.asset(
                AppAsset.icVipRightTitle,
                fit: BoxFit.cover,
                width: 50,
              ),
            ],
          ),
          GetBuilder<VipController>(
            id: AppConstant.idOnCarouselTap1,
            builder: (logic) {
              int itemCount = logic.vipPlanList.length > 3 ? 3 : logic.vipPlanList.length;

              if (logic.frameLoading || logic.isLoading) {
                return const VipViewShimmer();
              }

              if (logic.vipPrivilegeList.isEmpty && logic.vipPlanList.isEmpty) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      EnumLocale.txtNoVipPlan.name.tr,
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  if (logic.vipPrivilegeList.isNotEmpty) ...[
                    20.height,
                    const CarouselSliderWidget(),
                    8.height,
                    DotsIndicator(
                      decorator: DotsDecorator(
                        color: AppColors.whiteColor.withValues(alpha: 0.18),
                        activeColor: AppColors.activeColor,
                        spacing: const EdgeInsets.all(3),
                        activeSize: const Size(7, 7),
                        size: const Size(5, 5),
                      ),
                      mainAxisAlignment: MainAxisAlignment.center,
                      axis: Axis.horizontal,
                      dotsCount: logic.vipPrivilegeList.length,
                      position: logic.carouselIndex.clamp(0, logic.vipPrivilegeList.length - 1).toDouble(),
                    ),
                    25.height,
                  ] else ...[
                    30.height,
                  ],
                  if (logic.vipPlanList.isNotEmpty) ...[
                    SizedBox(
                      height: 155,
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: logic.vipPlanList.length == 1
                              ? MainAxisAlignment.center
                              : logic.vipPlanList.length == 2
                                  ? MainAxisAlignment.spaceEvenly
                                  : MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            itemCount,
                            (index) {
                              if (index >= logic.vipPlanList.length) {
                                return const SizedBox.shrink();
                              }

                              final data = logic.vipPlanList[index];

                              return GestureDetector(
                                onTap: () => logic.changeTab(index: index),
                                child: Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: AppColors.activeColor,
                                    borderRadius: BorderRadius.circular(16),
                                    border: logic.currentIndex == index
                                        ? Border.all(color: AppColors.whiteColor)
                                        : Border.all(
                                            color: AppColors.whiteColor.withValues(alpha: 0.16),
                                          ),
                                    image: const DecorationImage(
                                      image: AssetImage(AppAsset.vipBg),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Image.asset(
                                              AppAsset.coinStarImage,
                                              height: 60,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '+ ',
                                                style: AppFontStyle.styleW900(AppColors.whiteColor, 16),
                                              ),
                                              Text(
                                                data.coin.toString(),
                                                style: AppFontStyle.styleW900(AppColors.whiteColor, 16),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${data.validity}/${data.validityType}",
                                            style: AppFontStyle.styleW600(AppColors.vipMonthColor, 12),
                                          ),
                                          7.height,
                                          Container(
                                            width: 110,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius: BorderRadius.circular(23),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${Utils.isShowCurrencySymbol} ${data.price?.toStringAsFixed(2) ?? '0.00'}',
                                                style: AppFontStyle.styleW900(AppColors.orangeTxtColor2, 14),
                                              ).paddingSymmetric(vertical: 2),
                                            ),
                                          ).paddingSymmetric(horizontal: 8),
                                        ],
                                      ),
                                      if (logic.currentIndex == index)
                                        Positioned(
                                          right: 0,
                                          child: Container(
                                            height: 26,
                                            width: 26,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(12),
                                                bottomLeft: Radius.circular(12),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.check,
                                                color: AppColors.activeColor,
                                                size: 18,
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
                      ),
                    ),
                    25.height,
                    GestureDetector(
                      onTap: () => logic.getVipPlanPurchase(),
                      child: const VipButtonWidget(),
                    ),
                  ]
                ],
              );
            },
          ),
        ],
      ),
    ).paddingOnly(left: 9, right: 9);
  }
}
