import 'package:figgy/pages/profile_page/controller/profile_controller.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreContainerWidget extends StatelessWidget {
  const MoreContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        width: Get.width,
        decoration: BoxDecoration(
            gradient: AppColors.blueHostSetting,
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(image: AssetImage(AppAsset.imgMineVip), fit: BoxFit.cover)),
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 10.height,
                const SizedBox(
                  height: 45,
                  child: Image(
                    image: AssetImage(AppAsset.icVipLogo2),
                    fit: BoxFit.cover,
                  ),
                ),
                7.height,
                Text(
                  EnumLocale.txtBecomeAVIPEnjoyPrivilege.name.tr,
                  maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                  style: AppFontStyle.styleW500(AppColors.whiteColor, 14),
                ),
              ],
            ).paddingOnly(left: 19, top: 10),
            GetBuilder<ProfileViewController>(builder: (logic) {
              return GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.vipPage)?.then((val) async {
                  await 300.milliseconds.delay();
                  logic.update();
                }),
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 15, right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        EnumLocale.txtMore.name.tr,
                        style: AppFontStyle.styleW600(AppColors.colorBlue, 16),
                      ).paddingOnly(left: 12, right: 5, bottom: 3, top: 3),
                      Image.asset(
                        AppAsset.icBlueMineMore,
                        height: 15,
                        width: 15,
                      ).paddingOnly(right: 12),
                    ],
                  ),
                ).paddingOnly(top: 25),
              );
            }),
          ],
        ));
  }
}
