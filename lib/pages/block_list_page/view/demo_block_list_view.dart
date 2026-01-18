import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DemoBlockListView extends StatelessWidget {
  const DemoBlockListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
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
                  ),
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
                    EnumLocale.txtBlockList.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                  ),
                  45.width,
                ],
              ),
            ),
            const Expanded(child: DemoUserBlockListView()),
          ],
        ),
      ),
    );
  }
}

class DemoUserBlockListView extends StatelessWidget {
  const DemoUserBlockListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> hostName = [
      "Amara Hassan",
      "Mei Lin",
      "Valentina Torres",
    ];
    List<String> hostImage = [
      "https://images.pexels.com/photos/9637811/pexels-photo-9637811.jpeg",
      "https://images.pexels.com/photos/14829693/pexels-photo-14829693.jpeg",
      "https://images.pexels.com/photos/28174878/pexels-photo-28174878.jpeg",
    ];
    List<String> hostCountryImage = [
      "🇺🇸",
      "🇷🇺",
      "🇯🇵",
    ];
    List<String> hostCountryName = [
      "United States",
      "Russia",
      "Japan",
    ];

    List<String> userName = [
      "Ava Brown",
      "Camila Martínez",
      "Hye-jin Lee",
    ];
    List<String> userImage = [
      "https://images.unsplash.com/photo-1684361436133-45520d9f90cb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzN8fHdvbWFuJTIwcG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
      "https://plus.unsplash.com/premium_photo-1712736395790-dafc5a950401?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTJ8fHdvbWFuJTIwcG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
      "https://images.unsplash.com/photo-1521567097888-2c5fc40a8660?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTE1fHx3b21hbiUyMHBvcnRyYWl0fGVufDB8fDB8fHww",
    ];
    List<String> userCountryImage = [
      "🇺🇸",
      "🇷🇺",
      "🇯🇵",
    ];
    List<String> userCountryName = [
      "United States",
      "Russia",
      "Japan",
    ];

    return LayoutBuilder(
      builder: (context, box) {
        return SingleChildScrollView(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.settingColor,
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.whiteColor.withValues(alpha: 0.70),
                        ),
                      ),
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              AppColors.colorTextGrey.withValues(alpha: 0.22),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CustomImage(
                          padding: 8,
                          image: Database.isHost
                              ? hostImage[index]
                              : userImage[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    16.width,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Database.isHost ? hostName[index] : userName[index],
                          style:
                              AppFontStyle.styleW700(AppColors.whiteColor, 20),
                        ),
                        1.height,
                        Row(
                          children: [
                            Text(
                              Database.isHost
                                  ? hostCountryImage[index]
                                  : userCountryImage[index],
                              style: AppFontStyle.styleW400(
                                  AppColors.colorGry, 19),
                            ),
                            8.width,
                            Text(
                              Database.isHost
                                  ? hostCountryName[index]
                                  : userCountryName[index],
                              style: AppFontStyle.styleW400(
                                  AppColors.colorCountryTxt, 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Utils.showToast(
                            "Oops! you don't have permission.This is demo login");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: const BoxDecoration(
                          color: AppColors.unBlockColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AppAsset.unBlockIcon2,
                              width: 18,
                              height: 18,
                              color: AppColors.whiteColor,
                            ),
                            Text(
                              EnumLocale.txtUnblock.name.tr,
                              style: AppFontStyle.styleW700(
                                  AppColors.whiteColor, 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(right: 11, left: 11, top: 15);
            },
          ),
        ).paddingOnly(top: 3);
      },
    );
  }
}
