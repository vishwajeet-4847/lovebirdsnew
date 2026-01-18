import 'package:LoveBirds/pages/random_match_page/controller/random_match_controller.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RandomTopViewWidget extends StatelessWidget {
  const RandomTopViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.03, left: 10, right: 10),
      child: Row(
        children: [
          GetBuilder<RandomMatchController>(
            id: AppConstant.idRandomMatchView,
            builder: (logic) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.topUpPage)?.then((val) async {
                    await logic.getUpdatedCoin();
                  });
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    height: 29,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorDimButton),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        gradient: AppColors.gradientButtonColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage(AppAsset.coinIcon2),
                          height: 24,
                          width: 24,
                        ),
                        4.width,
                        GetBuilder<RandomMatchController>(
                            id: AppConstant.idUpdateCoin,
                            builder: (logic) {
                              return Text(
                                Database.coin.toString().split('.')[0],
                                style: AppFontStyle.styleW800(
                                    AppColors.whiteColor, 18),
                              ).paddingOnly(right: 5);
                            }),
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 10, vertical: 15),
                ),
              );
            },
          ),
          const Spacer(),
          GetBuilder<RandomMatchController>(
            builder: (logic) {
              return GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.vipPage)?.then(
                  (val) => logic.update([AppConstant.idUpdateCoin]),
                ),
                child: SizedBox(
                  height: 30,
                  width: 70,
                  child: Image.asset(AppAsset.icNaviVipMatch),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
