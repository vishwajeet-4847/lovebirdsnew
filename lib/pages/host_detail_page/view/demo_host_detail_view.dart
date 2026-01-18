import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:LoveBirds/custom/app_background/custom_app_background.dart';
import 'package:LoveBirds/custom/app_title/custom_title.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:photo_view/photo_view.dart';

class DemoHostDetailView extends StatelessWidget {
  final String name;
  final String profileImage;
  final String follower;
  final String aboutMe;
  final bool isFollow;
  const DemoHostDetailView({
    super.key,
    required this.name,
    required this.profileImage,
    required this.follower,
    required this.aboutMe,
    required this.isFollow,
  });

  @override
  Widget build(BuildContext context) {
    double calculateTextWidth(String text, TextStyle style) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();
      return textPainter.size.width;
    }

    final textStyle = AppFontStyle.styleW800(AppColors.whiteColor, 20);
    final containerWidth = Get.width * 0.40;
    final textWidth = calculateTextWidth(name, textStyle);
    final isOverflow = textWidth > containerWidth;

    String generateRandom7DigitId() {
      final random = Random();
      int number = 10000000 + random.nextInt(90000000);
      return number.toString();
    }

    List<String> language = [
      "English",
      "Thai",
      "Hindi",
      "Russian",
      "Vietnamese",
    ];

    List<String> impression = [
      "Calm and Soothing",
      "Hypnotic Talker",
      "Killer",
      "Beautiful Eyes",
      "Photogenic Queen",
      "Flirty and Fun",
      "Rising",
      "Angelic Aura",
      "Elegant Personality",
      "Bold and Beautiful",
      "Spicy & Sweet",
      "Full of Surprises",
    ];

    List<String> images = [
      "https://images.unsplash.com/photo-1635085834453-7fdc877e0ba1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDUwfHx8ZW58MHx8fHx8",
      "https://plus.unsplash.com/premium_photo-1668896123985-edc26d57cab3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzY5fHxnaXJsJTIwcG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
      "https://images.unsplash.com/photo-1633671400430-cc4d3f2b76aa?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDE4fHxnaXJsJTIwcG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
      "https://plus.unsplash.com/premium_photo-1668896123844-be3aec7a4776?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDU3fHxnaXJsJTIwcG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
      "https://images.unsplash.com/photo-1611154373925-004cfa33cad6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTMwfHxnaXJsJTIwcG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
      "https://images.unsplash.com/photo-1637768034405-240c6bddf308?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDQ2fHx8ZW58MHx8fHx8",
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.primaryColor1,
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // =================== Header with Circle Image ====================
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                    width: Get.width,
                    height: 360,
                    child: CustomImage(
                      image: profileImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        color: AppColors.transparent,
                        child: Image.asset(
                          AppAsset.whiteBackArrow,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // =================== Profile Content ====================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.primaryColor1,
                    padding:
                        const EdgeInsets.only(bottom: 10, top: 10, left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  AppColors.whiteColor.withValues(alpha: 0.50),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.all(0.8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              height: 78,
                              width: 78,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.colorTextGrey
                                    .withValues(alpha: 0.22),
                              ),
                              child: CustomImage(
                                image: profileImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        8.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: containerWidth,
                              height: 26,
                              child: isOverflow
                                  ? Marquee(
                                      text: name,
                                      style: textStyle,
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      blankSpace: 10.0,
                                      velocity: 30.0,
                                      pauseAfterRound:
                                          const Duration(seconds: 1),
                                      startPadding: 0.0,
                                      accelerationDuration:
                                          const Duration(seconds: 1),
                                      accelerationCurve: Curves.linear,
                                      decelerationDuration:
                                          const Duration(milliseconds: 500),
                                      decelerationCurve: Curves.easeOut,
                                    )
                                  : Text(
                                      name,
                                      style: textStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                            4.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  generateRandom7DigitId(),
                                  maxLines: 1,
                                  style: AppFontStyle.styleW500(
                                      AppColors.uniqueIdTxtColor, 14),
                                ),
                                5.width,
                                GestureDetector(
                                  onTap: () {
                                    Utils.copyText(generateRandom7DigitId());
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      AppAsset.copy,
                                      height: 17,
                                      width: 17,
                                      color: AppColors.colorGry,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            8.height,
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color: AppColors.colorPink1),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        AppAsset.genderIcon,
                                        height: 13,
                                        width: 13,
                                      ),
                                      3.width,
                                      Text(
                                        "Female",
                                        style: AppFontStyle.styleW700(
                                            AppColors.whiteColor, 12),
                                      ),
                                    ],
                                  ).paddingSymmetric(
                                      vertical: 4, horizontal: 9),
                                ),
                                8.width,
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.followerBgColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                        topRight: Radius.circular(16)),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Follower : ",
                                        style: AppFontStyle.styleW600(
                                            AppColors.whiteColor, 12),
                                      ),
                                      Text(
                                        follower,
                                        style: AppFontStyle.styleW800(
                                            AppColors.whiteColor, 12),
                                      ),
                                    ],
                                  ).paddingOnly(
                                      top: 3, bottom: 3, left: 7, right: 7),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Database.isHost
                            ? const Offstage()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(right: 8, top: 2),
                                child: Container(
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: isFollow
                                        ? null
                                        : AppColors.followBgColor,
                                    gradient: isFollow
                                        ? AppColors.gradientButtonColor
                                        : null,
                                    border: isFollow
                                        ? null
                                        : Border.all(
                                            color: AppColors.whiteColor
                                                .withValues(alpha: 0.34)),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          isFollow
                                              ? AppAsset.followingIcon2
                                              : AppAsset.followIcon2,
                                          width: 14,
                                          height: 14),
                                      const SizedBox(width: 7),
                                      Text(
                                        isFollow
                                            ? EnumLocale.txtFollowing.name.tr
                                            : EnumLocale.txtFollow.name.tr,
                                        style: AppFontStyle.styleW700(
                                            Colors.white, 13),
                                      ),
                                    ],
                                  ).paddingSymmetric(horizontal: 9),
                                ),
                              ),
                      ],
                    ),
                  ),
                  18.height,
                  HostDetailTitle(title: EnumLocale.txtAboutMe.name.tr)
                      .paddingOnly(left: 14),
                  10.height,
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: AppColors.secondaryColor1,
                        borderRadius: BorderRadius.circular(14)),
                    child: Text(
                      aboutMe,
                      style: AppFontStyle.styleW500(AppColors.whiteColor, 12),
                    ).paddingAll(10),
                  ).paddingOnly(left: 14, right: 14),
                  19.height,
                  HostDetailTitle(title: EnumLocale.txtLanguages.name.tr)
                      .paddingOnly(left: 14),
                  10.height,
                  Wrap(
                    spacing: 12,
                    runSpacing: 2,
                    children: language.map(
                      (text) {
                        return Chip(
                          label: Text(
                            text,
                            style: AppFontStyle.styleW600(
                              AppColors.whiteColor,
                              15,
                            ),
                          ),
                          backgroundColor: AppColors.languageBgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: AppColors.whiteColor
                                    .withValues(alpha: 0.20),
                                width: 0.6),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 7),
                          labelPadding: EdgeInsets.zero,
                        );
                      },
                    ).toList(),
                  ).paddingOnly(right: 14, left: 14),
                  16.height,
                  HostDetailTitle(title: EnumLocale.txtImpression.name.tr)
                      .paddingOnly(left: 14),
                  10.height,
                  Wrap(
                    spacing: 12,
                    runSpacing: 2,
                    children: impression.map(
                      (text) {
                        return Chip(
                          label: Text(
                            text,
                            style: AppFontStyle.styleW600(
                              AppColors.whiteColor,
                              15,
                            ),
                          ),
                          backgroundColor: AppColors.impressionBgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: AppColors.whiteColor
                                    .withValues(alpha: 0.20),
                                width: 0.6),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 9),
                          labelPadding: EdgeInsets.zero,
                        );
                      },
                    ).toList(),
                  ).paddingOnly(right: 14, left: 14),
                  18.height,
                  HostDetailTitle(title: EnumLocale.txtPhotos.name.tr)
                      .paddingOnly(left: 14),
                  10.height,
                  SizedBox(
                    height: Get.height * 0.17,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 10),
                      itemCount: images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Container(
                        clipBehavior: Clip.antiAlias,
                        width: 123,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              AppColors.colorTextGrey.withValues(alpha: 0.22),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => imageView((images[index])),
                            );
                          },
                          child: CustomImage(
                            image: images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  19.height,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageView(String imageUrl) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: PhotoView(
                  imageProvider: CachedNetworkImageProvider(imageUrl),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  basePosition: Alignment.center,
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.covered,
                  maxScale: PhotoViewComputedScale.covered * 2.5,
                  heroAttributes:
                      const PhotoViewHeroAttributes(tag: "zoomable_image"),
                ),
              ),
            ),

            // Close button
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(Get.overlayContext ?? Get.context!).pop(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
