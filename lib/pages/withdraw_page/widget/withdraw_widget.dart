import 'package:figgy/pages/withdraw_page/controller/withdraw_controller.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterCoinFieldUi extends StatelessWidget {
  const EnterCoinFieldUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            EnumLocale.txtEnterAmount.name.tr,
            style: AppFontStyle.styleW500(AppColors.walletTxtColor, 14),
          ),
          14.height,
          GetBuilder<WithdrawController>(
            id: AppConstant.onChangePaymentMethod,
            builder: (logic) {
              return Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.settingColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 54,
                      width: 54,
                      decoration: const BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          bottomLeft: Radius.circular(14),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          AppAsset.icCoin,
                          height: 32,
                        ),
                      ),
                    ),
                    15.width,
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        controller: logic.coinController,
                        style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                        cursorColor: AppColors.whiteColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: EnumLocale.txtEnterWithdrawCoin.name.tr,
                          hintStyle: AppFontStyle.styleW400(AppColors.colorGry, 14),
                        ),
                        onChanged: (value) {
                          logic.calculateText(value);
                        },
                      ),
                    ),
                    15.width,
                    Text(
                      "= ${logic.currencySymbol} ${logic.autoCalculatedText}",
                      style: AppFontStyle.styleW600(
                        Colors.white,
                        15,
                      ),
                    ),
                    15.width,
                  ],
                ),
              );
            },
          ),
          10.height,
          GetBuilder<WithdrawController>(
            builder: (logic) {
              return Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${EnumLocale.txtMinimumWithdraw.name.tr} ${logic.getSettingModel?.data?.minCoinsForHostPayout} ${EnumLocale.txtCoins.name.tr}",
                  style: AppFontStyle.styleW800(AppColors.yellowColorTxt, 12),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class EnterGooglePayNumberFieldUi extends GetView<WithdrawController> {
  const EnterGooglePayNumberFieldUi({super.key, required this.title, required this.controller1});

  final String title;
  final TextEditingController controller1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFontStyle.styleW500(AppColors.walletTxtColor, 14),
          ),
          10.height,
          Container(
            height: 50,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.settingColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextFormField(
              controller: controller1,
              maxLines: 1,
              keyboardType: TextInputType.text,
              style: AppFontStyle.styleW700(AppColors.whiteColor, 17),
              cursorColor: AppColors.whiteColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "${EnumLocale.txtEnter.name.tr} $title",
                hintStyle: AppFontStyle.styleW400(AppColors.colorGry, 14),
              ),
            ),
          ),
          15.height,
        ],
      ),
    );
  }
}
