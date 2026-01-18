import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:LoveBirds/custom/radio_button/custom_radio_button.dart';
import 'package:LoveBirds/pages/random_match_page/controller/random_match_controller.dart';
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
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class RandomBottomViewWidget extends StatelessWidget {
  const RandomBottomViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /*// ============ vip Button ===============
        GestureDetector(
          onTap: () => Get.dialog(
            barrierDismissible: true,
            const RandomDialogBox(),
          ),
          child: AnimatedContainer(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 35,
            width: 180,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.colorGold,
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            duration: const Duration(seconds: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  height: 30,
                  width: 75,
                  child: Image.asset(
                    AppAsset.icVip,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    "600/${EnumLocale.txtMin.name.tr}",
                    style: AppFontStyle.styleW500(AppColors.colorVipText, 17),
                  ),
                ),
              ],
            ),
          ),
        ),*/

        // ============ Random Match Button ================
        12.height,
        GetBuilder<RandomMatchController>(
          id: AppConstant.onChangeGender,
          builder: (logic) {
            return GestureDetector(
              onTap: () {
                if (Database.coin <
                    (logic.selectedGender == "both"
                        ? Database.generalRandomCallRate
                        : logic.selectedGender == "male"
                            ? Database.maleRandomCallRate
                            : Database.femaleRandomCallRate)) {
                  Get.toNamed(AppRoutes.topUpPage);
                } else {
                  logic.getAvailableHostApi();
                }
              },
              child: Container(
                // height: 50,
                // alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                decoration: BoxDecoration(
                  gradient: AppColors.randomButtonGradient,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  EnumLocale.txtRandomMatch.name.tr,
                  style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        ),

        // ============ Gender ================
        30.height,
        GetBuilder<RandomMatchController>(
          id: AppConstant.onChangeGender,
          builder: (logic) {
            return BlurryContainer(
              blur: 4,
              height: 55,
              elevation: 0,
              color: AppColors.whiteColor.withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FillProfileRadioItem(
                    isSelected: logic.selectedGender == "both",
                    title: EnumLocale.txtBoth.name.tr,
                    callback: () => logic.onChangeGender("both"),
                    image: AppAsset.icGenderBoth,
                    size: 16,
                  ),
                  const VerticalDivider(
                    thickness: 1.2,
                    indent: 8,
                    endIndent: 9,
                    color: Colors.white,
                  ),
                  FillProfileRadioItem(
                    isSelected: logic.selectedGender == "male",
                    title: EnumLocale.txtMale.name.tr,
                    callback: () => logic.onChangeGender("male"),
                    size: 13,
                    image: AppAsset.icGenderMale,
                  ),
                  const VerticalDivider(
                    thickness: 1.2,
                    indent: 8,
                    endIndent: 9,
                    color: Colors.white,
                  ),
                  FillProfileRadioItem(
                    isSelected: logic.selectedGender == "female",
                    title: EnumLocale.txtFemale.name.tr,
                    callback: () => logic.onChangeGender("female"),
                    image: AppAsset.icGenderFemale,
                  ),
                ],
              ),
            ).paddingOnly(left: 10, right: 10);
          },
        ),
        105.height,
      ],
    );
  }
}

class FillProfileRadioItem extends StatelessWidget {
  const FillProfileRadioItem({
    super.key,
    required this.isSelected,
    required this.title,
    required this.image,
    required this.callback,
    this.size,
  });

  final bool isSelected;
  final String title;
  final String image;
  final Callback callback;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          color: AppColors.transparent,
          child: Row(
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: isSelected ? null : AppColors.borderColorLiveButton.withValues(alpha: 0.2),
              //     // gradient: isSelected ? AppColors.primaryLinearGradient : null,
              //   ),
              //   child: Container(
              //     height: 25,
              //     width: 25,
              //     margin: const EdgeInsets.all(1.5),
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: isSelected ? null : AppColors.borderColorLiveButton,
              //       border: Border.all(color: isSelected ? AppColors.colorWhite : AppColors.colorPrimary.withValues(alpha: 0.3), width: 1.5),
              //     ),
              //   ),
              // ),
              CustomRadioButtonWidget(
                isSelected: isSelected,
                size: 20,
                borderColor: AppColors.whiteColor,
                activeColor: AppColors.transparent,
              ),
              4.width,

              Image.asset(image, height: size ?? 15, width: size ?? 15),
              4.width,
              Text(
                title,
                style: AppFontStyle.styleW700(AppColors.whiteColor, 15),
              ),
            ],
          )),
    );
  }
}
