// import 'package:LoveBirds/pages/profile_page/controller/profile_controller.dart';
// import 'package:LoveBirds/pages/profile_page/widget/setting_option_widget.dart';
// import 'package:LoveBirds/routes/app_routes.dart';
// import 'package:LoveBirds/utils/asset.dart';
// import 'package:LoveBirds/utils/colors_utils.dart';
// import 'package:LoveBirds/utils/database.dart';
// import 'package:LoveBirds/utils/enum.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class BottomProfileWidget extends StatelessWidget {
//   const BottomProfileWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor.withValues(alpha: 0.1),
//         borderRadius: const BorderRadius.all(Radius.circular(15)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           //*********** Host request
//           Database.isHost == true
//               ? Container()
//               : GetBuilder<ProfileViewController>(
//                   builder: (logic) {
//                     return SettingsOptionItemWidget(
//                       icon: AppAsset.icHostRequest,
//                       text: EnumLocale.txtHostRequest.name.tr,
//                       onTap: () => logic.onGetVerifyPage(),
//                     );
//                   },
//                 ),
//
//           //*********** Block List
//           SettingsOptionItemWidget(
//             icon: AppAsset.icSettingBlackList,
//             text: EnumLocale.txtBlockList.name.tr,
//             onTap: () => Get.toNamed(AppRoutes.blockPage),
//           ),
//
//           //*********** Wallet History
//           Database.isHost == true
//               ? Container()
//               : SettingsOptionItemWidget(
//                   icon: AppAsset.icWallet,
//                   text: EnumLocale.txtHistory.name.tr,
//                   onTap: () => Get.toNamed(AppRoutes.myWalletPage),
//                 ),
//
//           //*********** Languages
//           SettingsOptionItemWidget(
//             icon: AppAsset.icLanguage,
//             text: EnumLocale.txtAppLanguage.name.tr,
//             onTap: () => Get.toNamed(AppRoutes.appLanguagePage),
//           ),
//
//           //*********** Setting
//           Database.isHost == true
//               ? Container()
//               : SettingsOptionItemWidget(
//                   icon: AppAsset.icSetting,
//                   text: EnumLocale.txtSettings.name.tr,
//                   onTap: () => Get.toNamed(AppRoutes.appSettingPage),
//                 ),
//         ],
//       ),
//     );
//   }
// }
import 'package:LoveBirds/custom/dialog/daily_check_in_dialog.dart';
import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/pages/profile_page/controller/profile_controller.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common_info_tile.dart';

class BottomProfileWidget extends StatelessWidget {
  const BottomProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<ProfileViewController>(
          builder: (controller) {
            return CommonInfoTile(
              onTap: () {
                Get.toNamed(AppRoutes.topUpPage)
                    ?.then((val) => controller.update());
              },
              text: EnumLocale.txtMyWallet.name.tr,
              imageAsset: AppAsset.hostWithDrawIcon,
              gradient: AppColors.walletGradiant,
            );
          },
        ),
        20.height,
        CommonInfoTile(
          onTap: () async {
            Get.dialog(
              barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
              Dialog(
                alignment: Alignment.center,
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                backgroundColor: AppColors.transparent,
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                child: const DailyCheckInDialog(),
              ),
            );
          },
          text: EnumLocale.txtDailyCheckIn.name.tr,
          imageAsset: AppAsset.checkInIcon,
          gradient: AppColors.dailyCheckIn,
        ),
        20.height,
        GetBuilder<ProfileViewController>(
          builder: (logic) {
            return Database.isHost == true
                ? Container()
                : CommonInfoTile(
                    onTap: () => logic.onGetVerifyPage(),
                    text: EnumLocale.txtHostRequest.name.tr,
                    imageAsset: AppAsset.hostRequest1,
                    gradient: AppColors.hostRequest,
                  );
          },
        ),
        20.height,
        CommonInfoTile(
          onTap: () => Get.toNamed(AppRoutes.appLanguagePage),
          text: EnumLocale.txtAppLanguage.name.tr,
          imageAsset: AppAsset.hostLanguageIcon,
          gradient: AppColors.language,
        ),
        20.height,
        CommonInfoTile(
          onTap: () => Get.toNamed(AppRoutes.historyView)?.then(
            (value) {
              CustomFetchUserCoin.init();
            },
          ),
          text: EnumLocale.txtHistory.name.tr,
          imageAsset: AppAsset.walletHistoryIcon,
          gradient: AppColors.history,
        ),
        20.height,
        CommonInfoTile(
          onTap: () => Get.toNamed(AppRoutes.blockPage),
          text: EnumLocale.txtBlockList.name.tr,
          imageAsset: AppAsset.hostBlockIcon,
          gradient: AppColors.blockList,
        ),
        20.height,
        CommonInfoTile(
          onTap: () => Get.toNamed(AppRoutes.appSettingPage),
          text: EnumLocale.txtSetting.name.tr,
          imageAsset: AppAsset.hostSettingIcon,
          gradient: AppColors.hostRequest,
        ),
        110.height,
      ],
    );
  }
}
