import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/splash_screen_page/api/get_setting_api.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/socket/socket_services.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/asset.dart';
import '../../utils/colors_utils.dart';
import '../../utils/enum.dart';

class LogoutUserDialogUi extends StatelessWidget {
  const LogoutUserDialogUi({super.key});

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
              AppAsset.icLogOut,
              width: 90,
              color: AppColors.redColor2,
            ),
            10.height,
            Text(
              EnumLocale.txtLogOut.name.tr,
              style: AppFontStyle.styleW800(AppColors.blackColor, 30),
            ),
            10.height,
            Text(
              EnumLocale.txtDoYouWantToSureExitThisApp.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.styleW600(AppColors.colorGryTxt, 18),
            ),
            20.height,
            GestureDetector(
              onTap: () async {
                Get.back();
                final identityLogOut = Database.identity;
                final fcmTokenLogOut = Database.fcmToken;

                if (Database.loginType == 2) {
                  Utils.showLog("Google Logout Success");
                  await GoogleSignIn().signOut();
                }

                Database.localStorage.erase();

                SocketServices.disconnectSocket();

                Database.onSetFcmToken(fcmTokenLogOut);
                Database.onSetIdentity(identityLogOut);

                Get.offAllNamed(AppRoutes.loginView);

                Database.onSetIsAutoRefreshEnabled(false);

                final uid = FirebaseUid.onGet();
                final token = await FirebaseAccessToken.onGet();

                GetSettingApi.getSettingApi(uid: uid ?? "", token: token ?? "");
              },
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
                      Text(EnumLocale.txtLogOut.name.tr,
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
