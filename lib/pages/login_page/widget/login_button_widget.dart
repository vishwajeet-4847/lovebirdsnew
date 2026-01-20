import 'package:LoveBirds/pages/login_page/controller/login_controller.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColors.whiteColor.withValues(alpha: 0.1),
      ),
      child: GetBuilder<LoginController>(
        builder: (logic) {
          return Column(
            children: [
              30.height,
              GestureDetector(
                onTap: () => logic.onQuickLogin(),
                child: Container(
                  height: 55,
                  width: Get.width,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    gradient: AppColors.hostNextButton,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAsset.icQuick,
                        height: 45,
                      ).paddingOnly(left: 5),
                      const Spacer(),
                      Text(
                        EnumLocale.txtLetsStart.name.tr,
                        style: AppFontStyle.styleW700(AppColors.whiteColor, 17),
                      ).paddingOnly(right: 45),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => logic.onGoogleLogin(),
                child: Container(
                  height: 55,
                  width: Get.width,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [AppColors.transparent, AppColors.transparent]),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: AppColors.whiteColor.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAsset.icGoogle1,
                        height: 45,
                      ).paddingOnly(left: 5),
                      const Spacer(),
                      Text(
                        EnumLocale.txtGoogle.name.tr,
                        style: AppFontStyle.styleW700(AppColors.whiteColor, 17),
                      ).paddingOnly(right: 45),
                      const Spacer(),
                    ],
                  ),
                ),
              ),

              ///===================== DEMO DATA REMOVE START =====================///
              10.height,
              Row(
                children: [
                  15.width,
                  Expanded(
                    child: Divider(
                      color: AppColors.whiteColor.withValues(alpha: 0.3),
                      thickness: 0.5,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    EnumLocale.txtDemoApp.name.tr,
                    style: TextStyle(
                      color: AppColors.loginText,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.whiteColor.withValues(alpha: 0.3),
                      thickness: 0.5,
                      indent: 10,
                    ),
                  ),
                  15.width,
                ],
              ),
              // 10.height,
              // GestureDetector(
              //   onTap: () => logic.onDemoHostLogin(),
              //   child: Container(
              //     height: 50,
              //     width: Get.width,
              //     margin:
              //         const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //     decoration: BoxDecoration(
              //       color: AppColors.loginButtonHost,
              //       borderRadius: BorderRadius.circular(50),
              //     ),
              //     child: Center(
              //       child: Text(
              //         EnumLocale.txtDemoHost.name.tr,
              //         style: AppFontStyle.styleW700(AppColors.whiteColor, 17),
              //       ),
              //     ),
              //   ),
              // ),

              ///===================== DEMO DATA REMOVE END =====================///

              20.height,
              Text(
                EnumLocale.txtByLoggingInYouAgreeToOur.name.tr,
                style: AppFontStyle.styleW400(AppColors.colorGry, 14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.privacyPolicy);
                    },
                    child: Text(
                      EnumLocale.txtPrivacyPolicy.name.tr,
                      style: AppFontStyle.styleW600(AppColors.whiteColor, 15),
                    ),
                  ),
                  Text(
                    EnumLocale.txtAnd.name.tr,
                    style: const TextStyle(color: AppColors.colorGry),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.termsAndConditionView);
                    },
                    child: Text(
                      EnumLocale.txtTermsAndConditions.name.tr,
                      style: AppFontStyle.styleW600(AppColors.whiteColor, 15),
                    ),
                  ),
                ],
              ),
              25.height,
            ],
          );
        },
      ),
    );
  }
}
