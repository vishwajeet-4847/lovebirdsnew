import 'dart:io';

import 'package:LoveBirds/custom/app_button/custom_gradient_button.dart';
import 'package:LoveBirds/pages/payment_page/controller/payment_controller.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAsset.allBackgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: GetBuilder<PaymentScreenController>(
              id: AppConstant.onChangePaymentMethod,
              builder: (controller) => CustomGradientButton(
                height: 56,
                text: EnumLocale.txtPayNow.name.tr,
                onTap: () {
                  controller.onClickPayNow();
                },
                textSize: 20,
              ),
            ),
          ),
        ],
      ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        spreadRadius: 0)
                  ]),
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
                    EnumLocale.txtPayment.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                  ),
                  45.width,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.height,
                  SizedBox(
                    height: Get.height - 202, // adjust if needed
                    child: SingleChildScrollView(
                      child: GetBuilder<PaymentScreenController>(
                        id: AppConstant.onChangePaymentMethod,
                        builder: (controller) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Visibility(visible: Utils.isShowRazorPayPaymentMethod, child: const PaymentItemUi(0)),
                            // Visibility(visible: Utils.isShowStripePaymentMethod, child: const PaymentItemUi(1)),
                            // Visibility(visible: Utils.isShowFlutterWavePaymentMethod, child: const PaymentItemUi(2)),
                            // Visibility(visible: Utils.isShowInAppPurchasePaymentMethod, child: const PaymentItemUi(3)),
                            // Visibility(visible: Utils.isShowInAppPurchasePaymentMethod, child: const PaymentItemUi(4)),
                            // Visibility(visible: Utils.isShowInAppPurchasePaymentMethod, child: const PaymentItemUi(5)),
                            // Visibility(visible: Utils.isShowInAppPurchasePaymentMethod, child: const PaymentItemUi(6)),

                            if ((Platform.isAndroid &&
                                    Utils.isShowRazorPayAndroid == true) ||
                                (Platform.isIOS &&
                                    Utils.isShowRazorPayIos == true))
                              const PaymentItemUi(0),
                            if ((Platform.isAndroid &&
                                    Utils.isShowStripeAndroid == true) ||
                                (Platform.isIOS &&
                                    Utils.isShowStripeIos == true))
                              const PaymentItemUi(1),
                            if ((Platform.isAndroid &&
                                    Utils.isShowFlutterWaveAndroid == true) ||
                                (Platform.isIOS &&
                                    Utils.isShowFlutterWaveIos == true))
                              const PaymentItemUi(2),
                            if ((Platform.isAndroid &&
                                    Utils.isShowGooglePayAndroid == true) ||
                                (Platform.isIOS &&
                                    Utils.isShowGooglePayIos == true))
                              const PaymentItemUi(3),
                            if ((Platform.isAndroid &&
                                    Utils.isShowPayPalAndroid == true) ||
                                (Platform.isIOS &&
                                    Utils.isShowPayPalIos == true))
                              const PaymentItemUi(4),
                            if ((Platform.isAndroid &&
                                    Utils.isShowPayStackAndroid == true) ||
                                (Platform.isIOS &&
                                    Utils.isShowPayStackIos == true))
                              const PaymentItemUi(5),
                            if ((Platform.isAndroid &&
                                    Utils.isShowCashFreeAndroid == true) ||
                                (Platform.isIOS &&
                                    Utils.isShowCashFreeIos == true))
                              const PaymentItemUi(6),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const Spacer(),
            // GetBuilder<PaymentScreenController>(
            //   id: AppConstant.onChangePaymentMethod,
            //   builder: (controller) => CustomGradientButton(
            //     height: 56,
            //     text: EnumLocale.txtPayNow.name.tr,
            //     onTap: () {
            //       controller.onClickPayNow();
            //     },
            //     textSize: 20,
            //   ),
            // ),
            10.height,
          ],
        ),
      ),
    );
  }
}

class PaymentItemUi extends StatelessWidget {
  const PaymentItemUi(this.index, {super.key});

  final int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentScreenController>(
      id: AppConstant.onChangePaymentMethod,
      builder: (logic) {
        return GestureDetector(
          onTap: () => logic.onChangePaymentMethod(index),
          child: Container(
            width: Get.width,
            margin: const EdgeInsets.only(bottom: 13),
            decoration: BoxDecoration(
              color: AppColors.settingColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: AppColors.whiteColor.withValues(alpha: 0.12)),
            ),
            child: Row(
              children: [
                Container(
                  height: 57,
                  width: 57,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Image.asset(
                      logic.paymentMethodList[index]["icon"]!,
                      width:
                          double.parse(logic.paymentMethodList[index]["size"]!),
                    ),
                  ),
                ),
                24.width,
                Text(
                  logic.paymentMethodList[index]["title"]!,
                  style: AppFontStyle.styleW800(AppColors.whiteColor, 18),
                ),
                const Spacer(),
                logic.selectedPaymentMethod != index
                    ? Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          border: Border.all(
                            color: AppColors.whiteColor.withValues(alpha: 0.12),
                          ),
                          shape: BoxShape.circle,
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          border: Border.all(color: AppColors.checkColor),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: AppColors.checkColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Image.asset(
                            AppAsset.whiteCheckIcon,
                            height: 12,
                            width: 10,
                          )),
                        ),
                      ),
                15.width,
              ],
            ).paddingOnly(left: 6, top: 6, bottom: 6),
          ),
        );
      },
    );
  }
}
