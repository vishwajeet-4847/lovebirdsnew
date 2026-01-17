import 'package:figgy/custom/custom_image/custom_profile_image.dart';
import 'package:figgy/pages/vip_page/controller/vip_controller.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VipUserDetailWidget extends StatelessWidget {
  const VipUserDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Database.isVip ? 5.height : 15.height,
        Row(
          children: [
            GetBuilder<VipController>(
              id: AppConstant.idOnCarouselTap1,
              builder: (logic) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 65,
                      width: 65,
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.only(left: 20),
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Container(
                        color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                        height: 65,
                        width: 65,
                        child: CustomImage(
                          image: Database.profileImage,
                          fit: BoxFit.cover,
                          padding: 12,
                        ),
                      ),
                    ),
                    Database.isVip
                        ? Container(
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.only(left: 20),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Image.network(
                              Api.baseUrl + Database.isVipFrameBadge,
                              fit: BoxFit.cover,
                              height: 90,
                              width: 90,
                            ),
                          )
                        : const Offstage()
                  ],
                );
              },
            ),
            10.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Database.userName,
                  style: AppFontStyle.styleW800(AppColors.whiteColor, 25),
                ),
                Text(
                  Database.isVip ? EnumLocale.txtYouReVIP.name.tr : EnumLocale.txtYouReNotVIP.name.tr,
                  style: AppFontStyle.styleW700(AppColors.vipTextColor, 15),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
