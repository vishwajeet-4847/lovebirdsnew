import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/pages/top_up_page/controller/top_up_controller.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopUpBottomWidget extends StatelessWidget {
  const TopUpBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopUpController>(
      id: AppConstant.idGetCoin,
      builder: (logic) {
        return Padding(
          padding: EdgeInsets.only(
            top: Get.height * 0.17,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  EnumLocale.txtAvailableCoinBalance.name.tr,
                  style: AppFontStyle.styleW6002(
                      AppColors.whiteColor.withValues(alpha: 0.80), 14),
                ),
              ),
              5.height,
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    5.width,
                    Text(
                      Database.isDemoLogin == true
                          ? "620"
                          : Database.coin.toString().split('.')[0],
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        color: AppColors.whiteColor,
                        shadows: [
                          Shadow(
                            color: AppColors.blackColor.withValues(alpha: 0.27),
                            offset: const Offset(1, 1.2),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              22.height,
              Expanded(
                child: Container(
                  height: 350,
                  width: Get.width,
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: AppColors.whiteColor.withValues(alpha: 0.20),
                    border: Border.all(
                      color: AppColors.whiteColor.withValues(alpha: 0.32),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor.withValues(alpha: 0.18),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.blackColor.withValues(alpha: 0.08),
                              blurRadius: 16,
                              spreadRadius: 0,
                              offset: const Offset(0, 1),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            EnumLocale.txtRechargeWalletCoin.name.tr,
                            style: AppFontStyle.styleW800(
                                AppColors.rechargeCoinTxtColor, 22),
                          ),
                        ),
                      ),
                      Expanded(
                        child: !logic.isLoading
                            ? GridView.builder(
                                padding: const EdgeInsets.only(
                                    top: 15, right: 15, left: 15, bottom: 30),
                                itemCount: logic.coinPlanList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.78,
                                ),
                                itemBuilder: (context, index) {
                                  var item = logic.coinPlanList[index];
                                  return Stack(
                                    clipBehavior: Clip.hardEdge,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: item.isFeatured == true
                                              ? AppColors.lightYellowColor
                                              : AppColors.whiteColor
                                                  .withValues(alpha: 0.20),
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          image: item.isFeatured == true
                                              ? const DecorationImage(
                                                  image: AssetImage(
                                                      AppAsset.premiumBgImg),
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                          border: Border.all(
                                            color: AppColors.whiteColor
                                                .withValues(alpha: 0.10),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                  AppAsset.rechargeCoin),
                                              height: 85,
                                              width: 85,
                                            ).paddingOnly(top: 20),
                                            Text(
                                              "${item.coins} Coins",
                                              style: AppFontStyle.styleW900(
                                                  item.isFeatured == true
                                                      ? AppColors
                                                          .orangeTxtColor2
                                                      : AppColors.whiteColor,
                                                  18),
                                            ),
                                            item.isFeatured == true
                                                ? Text(
                                                    "(Popular Plan)",
                                                    style:
                                                        AppFontStyle.styleW500(
                                                      AppColors.orangeTxtColor2,
                                                      13,
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            5.height,
                                            GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                  AppRoutes.paymentPage,
                                                  arguments: {
                                                    "id": item.id ?? "",
                                                    "amount": item.price ?? 0,
                                                    "isVip": false,
                                                    "productKey":
                                                        item.productId ?? "",
                                                  },
                                                );
                                              },
                                              child: Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: item.isFeatured == true
                                                      ? AppColors.colorDarkBrown
                                                      : AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    ("${Utils.isShowCurrencySymbol} ${item.price?.toStringAsFixed(2)}"),
                                                    style: AppFontStyle.styleW900(
                                                        item.isFeatured == true
                                                            ? AppColors
                                                                .lightYellowColor
                                                            : AppColors
                                                                .orangeTxtColor2,
                                                        18),
                                                  ),
                                                ),
                                              ).paddingSymmetric(
                                                  horizontal: 17),
                                            ).paddingOnly(bottom: 10),
                                          ],
                                        ),
                                      ),

                                      // 🎯 Diagonal Cross Label (Inside)
                                      if (item.bonusCoins != null &&
                                          item.bonusCoins! > 0)
                                        Positioned(
                                          top: 10,
                                          right: -25,
                                          child: Transform.rotate(
                                            angle: 0.785398,
                                            child: Container(
                                              width: 120,
                                              height: 18,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                gradient: item.isFeatured ==
                                                        true
                                                    ? LinearGradient(
                                                        colors: [
                                                          AppColors
                                                              .colorDarkBrown,
                                                          AppColors
                                                              .colorDarkBrown,
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      )
                                                    : const LinearGradient(
                                                        colors: [
                                                          AppColors
                                                              .colorPinkGradient,
                                                          AppColors
                                                              .colorBlueGradient,
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: AppColors.whiteColor,
                                                  width: 0.5,
                                                ),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 3,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left:
                                                        20), // 👈 pushes text slightly down
                                                child: Text(
                                                  "VIP + ${item.bonusCoins}",
                                                  style: AppFontStyle.styleW900(
                                                      item.isFeatured == true
                                                          ? AppColors
                                                              .lightYellowColor
                                                          : AppColors
                                                              .whiteColor,
                                                      12),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              )
                            : const Center(child: LoadingWidget()),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
