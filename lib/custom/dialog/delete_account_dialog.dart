import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../utils/asset.dart';
import '../../utils/colors_utils.dart';
import '../../utils/enum.dart';

class DeleteAccountDialog extends StatelessWidget {
  final void Function()? deleteAccountOnTap;
  const DeleteAccountDialog({super.key, this.deleteAccountOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      width: 320,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            10.height,
            Image.asset(
              AppAsset.icDeleteAccount,
              width: 90,
              color: AppColors.redColor2,
            ),
            10.height,
            Text(
              EnumLocale.txtDeleteAccount.name.tr,
              style: AppFontStyle.styleW800(AppColors.blackColor, 30),
            ),
            10.height,
            Text(
              EnumLocale.txtDoYouWantToSureDeleteAccountThisApp.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.styleW600(AppColors.colorGryTxt, 18),
            ),
            20.height,
            GestureDetector(
              onTap: deleteAccountOnTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.redColor2,
                ),
                height: 52,
                width: Get.width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(EnumLocale.txtDeleteAccount.name.tr,
                          style:
                              AppFontStyle.styleW700(AppColors.whiteColor, 18)),
                    ],
                  ),
                ),
              ),
            ),
            20.height,
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.colorGry.withValues(alpha: 0.3),
                  ),
                  child: Text(EnumLocale.txtCancel.name.tr,
                      style: AppFontStyle.styleW700(
                          AppColors.cancelTxtColor, 18))),
            ),
          ],
        ),
      ),
    );
  }
}
