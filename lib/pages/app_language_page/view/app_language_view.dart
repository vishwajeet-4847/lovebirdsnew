import 'package:LoveBirds/pages/app_language_page/controller/app_language_controller.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLanguageView extends StatelessWidget {
  const AppLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    spreadRadius: 0,
                  )
                ],
              ),
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
                    EnumLocale.txtAppLanguage.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                  ),
                  45.width,
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<AppLanguageController>(
                id: AppConstant.idSelectedLanguage,
                builder: (logic) {
                  return Container(
                    clipBehavior: Clip.antiAlias,
                    height: Get.height -
                        (MediaQuery.of(context).viewPadding.top + 70),
                    width: Get.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: logic.languages.length,
                      itemBuilder: (context, index) {
                        var allLanguage = logic.languages[index];
                        return GestureDetector(
                          onTap: () => logic.setSelectedLanguage(
                              allLanguage.languageCode,
                              allLanguage.countryCode,
                              allLanguage.language),
                          child: Container(
                            width: Get.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                            alignment: Alignment.centerLeft,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.settingColor,
                                border: Border.all(
                                    color: AppColors.whiteColor
                                        .withValues(alpha: 0.10),
                                    width: 0.7)),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    allLanguage.symbol,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  allLanguage.language,
                                  style: AppFontStyle.styleW600(
                                      AppColors.whiteColor, 17),
                                ),
                                const Spacer(),
                                allLanguage.language != logic.selectedLanguage
                                    ? Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: AppColors.transparent,
                                            border: Border.all(
                                              color: AppColors.whiteColor
                                                  .withValues(alpha: 0.12),
                                            ),
                                            shape: BoxShape.circle),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                            color: AppColors.transparent,
                                            border: Border.all(
                                                color: AppColors.checkColor),
                                            shape: BoxShape.circle),
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: AppColors.checkColor,
                                              shape: BoxShape.circle),
                                          child: Center(
                                              child: Image.asset(
                                            AppAsset.whiteCheckIcon,
                                            height: 12,
                                            width: 10,
                                          )),
                                        ),
                                      ),
                              ],
                            ),
                          ).paddingOnly(top: 14, right: 14, left: 14),
                        );
                      },
                    ).paddingOnly(bottom: 10),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
