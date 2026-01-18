import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:LoveBirds/pages/withdraw_page/controller/withdraw_controller.dart';
import 'package:LoveBirds/pages/withdraw_page/widget/withdraw_widget.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/shimmer/withdraw_shimmer.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/api.dart';
import '../../../utils/enum.dart';

class WithdrawView extends GetView<WithdrawController> {
  const WithdrawView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: AppColors.incomingCallGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).viewPadding.top + 60,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                  left: 15,
                  right: 15),
              alignment: Alignment.center,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
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
                  const Spacer(),
                  Text(
                    EnumLocale.txtWithdraw.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.hostWithdrawHistory);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.redColor2,
                          borderRadius: BorderRadius.circular(60),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.darkRedColor,
                              offset: Offset(0, 1.4),
                              blurRadius: 0,
                              spreadRadius: 0,
                            )
                          ]),
                      height: 34,
                      child: Row(
                        children: [
                          Image.asset(
                            AppAsset.walletHistoryIcon,
                            height: 20,
                            width: 20,
                          ),
                          Text(
                            EnumLocale.txtHistory.name.tr,
                            style: AppFontStyle.styleW800(
                                AppColors.whiteColor, 15),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 12, vertical: 5),
                    ),
                  )
                ],
              ),
            ),
            GetBuilder<WithdrawController>(
              id: AppConstant.onChangePaymentMethod,
              builder: (logic) {
                return Expanded(
                  child: logic.isLoading
                      ? const WithdrawShimmerUi()
                      : Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    20.height,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              AppRoutes.hostWithdrawHistory);
                                        },
                                        child: SizedBox(
                                          height: 148,
                                          width: Get.width,
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: Get.width,
                                                height: Get.height,
                                                decoration: const BoxDecoration(
                                                  // gradient: AppColors.editProfileButton,
                                                  // color: Colors.red,
                                                  image: DecorationImage(
                                                      image: AssetImage(AppAsset
                                                          .walletBgImage),
                                                      fit: BoxFit.cover),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 14, right: 10),
                                                child: SizedBox(
                                                  height: 148,
                                                  width: Get.width,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          2.height,
                                                          Text(
                                                            EnumLocale
                                                                .txtAvailableCoin
                                                                .name
                                                                .tr,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color: AppColors
                                                                  .whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              shadows: [
                                                                Shadow(
                                                                  color: AppColors
                                                                      .blackColor
                                                                      .withValues(
                                                                          alpha:
                                                                              0.40),
                                                                  offset:
                                                                      const Offset(
                                                                          0,
                                                                          0.6),
                                                                  blurRadius: 0,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            Database.coin
                                                                .toString()
                                                                .split('.')[0],
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 36,
                                                              color: AppColors
                                                                  .whiteColor,
                                                              shadows: [
                                                                Shadow(
                                                                  color: AppColors
                                                                      .blackColor
                                                                      .withValues(
                                                                          alpha:
                                                                              0.64),
                                                                  offset:
                                                                      const Offset(
                                                                          0.6,
                                                                          0.6),
                                                                  blurRadius: 0,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          10.height,
                                                          Container(
                                                            height: 32,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: AppColors
                                                                      .blackColor
                                                                      .withValues(
                                                                          alpha:
                                                                              0.6),
                                                                  offset:
                                                                      const Offset(
                                                                          0, 2),
                                                                  blurRadius: 1,
                                                                  blurStyle:
                                                                      BlurStyle
                                                                          .normal,
                                                                ),
                                                              ],
                                                              color: AppColors
                                                                  .darkBrownColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                    AppAsset
                                                                        .icWithdrawCoin,
                                                                    width: 16),
                                                                8.width,
                                                                GetBuilder<
                                                                    WithdrawController>(
                                                                  builder:
                                                                      (logic) {
                                                                    return Text(
                                                                      "${logic.getSettingModel?.data?.minCoinsToConvert} Coin",
                                                                      style: AppFontStyle.styleW700(
                                                                          AppColors
                                                                              .orangeTxtColor,
                                                                          14),
                                                                    );
                                                                  },
                                                                ),
                                                                8.width,
                                                                Text(
                                                                  "= \$ 1.00",
                                                                  style: AppFontStyle
                                                                      .styleW700(
                                                                          AppColors
                                                                              .orangeTxtColor,
                                                                          14),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Image.asset(
                                                        AppAsset.coinStarImage,
                                                        height: 120,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    30.height,
                                    const EnterCoinFieldUi(),
                                    18.height,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        EnumLocale
                                            .txtSelectPaymentGateway.name.tr,
                                        style: AppFontStyle.styleW500(
                                            AppColors.walletTxtColor, 14),
                                      ),
                                    ),
                                    10.height,
                                    Container(
                                      height: 50,
                                      width: Get.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: AppColors.settingColor,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: GetBuilder<WithdrawController>(
                                        id: AppConstant.onChangePaymentMethod,
                                        builder: (logic) {
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Text(
                                                EnumLocale
                                                    .txtSelectPaymentGateway
                                                    .name
                                                    .tr,
                                                style: AppFontStyle.styleW500(
                                                    AppColors.whiteColor,
                                                    14), // white color
                                              ),
                                              value:
                                                  logic.selectedPaymentMethod,
                                              onChanged: (index) {
                                                logic.onChangePaymentMethod(
                                                    index!);
                                                logic.update([
                                                  AppConstant
                                                      .onChangePaymentMethod
                                                ]);
                                              },
                                              items: List.generate(
                                                logic.withdrawMethods.length,
                                                (index) {
                                                  final item = logic
                                                      .withdrawMethods[index];
                                                  return DropdownMenuItem(
                                                    value: index,
                                                    child: Row(
                                                      children: [
                                                        Image.network(
                                                          Api.baseUrl +
                                                              (item.image ??
                                                                  ""),
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                        10.width,
                                                        Text(
                                                          item.name ?? "",
                                                          style: AppFontStyle
                                                              .styleW500(
                                                                  AppColors
                                                                      .whiteColor,
                                                                  14), // white color
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              iconStyleData: IconStyleData(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color:
                                                        AppColors.whiteColor),
                                              ),
                                              buttonStyleData: ButtonStyleData(
                                                height: 54,
                                                width: Get.width,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                elevation: 0,
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .colorChat, // dropdown background translucent
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    42.height,
                                    GetBuilder<WithdrawController>(
                                      id: AppConstant.onChangePaymentMethod,
                                      builder: (logic) => controller
                                                  .selectedPaymentMethod ==
                                              null
                                          ? const Offstage()
                                          : Column(children: logic.inputFel),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.onClickWithdraw();
                                  },
                                  child: Container(
                                    height: 56,
                                    width: 340,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.withdraw,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      EnumLocale.txtWithdraw.name.tr,
                                      style: AppFontStyle.styleW800(
                                          AppColors.whiteColor, 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
