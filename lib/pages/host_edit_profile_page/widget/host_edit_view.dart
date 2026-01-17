import 'dart:io';

import 'package:figgy/custom/gender.dart';
import 'package:figgy/pages/host_edit_profile_page/controller/host_edit_profile_controller.dart';
import 'package:figgy/pages/host_edit_profile_page/widget/edit_reels_player_view.dart';
import 'package:figgy/pages/host_edit_profile_page/widget/language.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HostEditView extends StatelessWidget {
  final Function? buildLabel;
  const HostEditView({super.key, required this.buildLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.height,
        Text(
          EnumLocale.txtSelectCountry.name.tr,
          style: AppFontStyle.styleW400(AppColors.walletTxtColor, 14),
        ),
        14.height,
        GetBuilder<HostEditProfileController>(
          id: AppConstant.idChangeCountry,
          builder: (logic) {
            return GestureDetector(
              onTap: () {
                logic.onChangeCountry(context);
              },
              child: Container(
                height: 55,
                width: Get.width,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: AppColors.settingColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      logic.flagController.text,
                      style: AppFontStyle.styleW500(AppColors.whiteColor, 20),
                    ),
                    10.width,
                    Text(
                      logic.countryController.text,
                      style: AppFontStyle.styleW600(AppColors.whiteColor, 15),
                    ),
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Image.asset(
                          AppAsset.downArrow,
                          height: 20,
                          width: 20,
                        )),
                    10.width,
                  ],
                ),
              ),
            );
          },
        ),
        24.height,
        Text(
          EnumLocale.txtSelectGender.name.tr,
          style: AppFontStyle.styleW500(AppColors.walletTxtColor, 14),
        ),
        14.height,
        GetBuilder<HostEditProfileController>(
          id: AppConstant.onChangeGender,
          builder: (controller) => Row(
            children: [
              GenderButtonWidget(
                title: EnumLocale.txtMale.name.tr,
                image: AppAsset.icMale,
                isSelected: controller.isMale,
                callback: () => controller.onChangeGender(true),
              ),
              20.width,
              GenderButtonWidget(
                title: EnumLocale.txtFemale.name.tr,
                image: AppAsset.icFemale,
                isSelected: !(controller.isMale),
                callback: () => controller.onChangeGender(false),
              ),
            ],
          ),
        ),
        36.height,
        Text(
          EnumLocale.txtSelectImpression.name.tr,
          style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
        ),
        20.height,
        GetBuilder<HostEditProfileController>(
          id: AppConstant.idSelectedCategories,
          builder: (logic) {
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: logic.categories.map((category) {
                bool isSelected = logic.selectedCategories.contains(category);
                return GestureDetector(
                  onTap: () => logic.toggleSelectionCategories(category),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.selectImpressionColor : AppColors.unselectImpressionColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      category,
                      style: AppFontStyle.styleW600(AppColors.whiteColor, 15),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        36.height,
        GetBuilder<HostEditProfileController>(
          builder: (logic) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  EnumLocale.txtAllLanguage.name.tr,
                  style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                ),
                logic.selectedLanguages.isEmpty
                    ? Container()
                    : GestureDetector(
                        onTap: () => CustomLanguagePicker.pickLanguage(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.settingColor,
                              border: Border.all(
                                color: AppColors.colorGry1.withValues(alpha: 0.50),
                              ),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            EnumLocale.txtAddMore.name.tr,
                            style: AppFontStyle.styleW600(AppColors.whiteColor.withValues(alpha: 0.40), 12),
                          ).paddingOnly(left: 8, right: 7, top: 5, bottom: 5),
                        ),
                      ),
              ],
            );
          },
        ),
        22.height,
        GetBuilder<HostEditProfileController>(
          builder: (logic) {
            return GestureDetector(
              onTap: () => CustomLanguagePicker.pickLanguage(context),
              child: Container(
                decoration: BoxDecoration(
                  color: logic.selectedLanguages.isEmpty ? AppColors.colorSelectedImpression.withValues(alpha: 0.7) : AppColors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.centerLeft,
                child: GetBuilder<HostEditProfileController>(
                  builder: (logic) {
                    if (logic.selectedLanguages.isEmpty) {
                      return Text(
                        EnumLocale.txtSelectLanguage.name.tr,
                        style: const TextStyle(color: Colors.white70, fontSize: 18),
                      );
                    }
                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: logic.selectedLanguages.map(
                        (category) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                            decoration: BoxDecoration(
                              color: AppColors.unselectImpressionColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  category,
                                  style: AppFontStyle.styleW400(AppColors.whiteColor, 15),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () => logic.toggleSelectionLanguage(category),
                                  child: Icon(
                                    Icons.close,
                                    size: 18,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
              ),
            );
          },
        ),
        15.height,
        Text(
          EnumLocale.txtUploadYourImages.name.tr,
          style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
        ),
        15.height,
        GetBuilder<HostEditProfileController>(
          builder: (logic) {
            return Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(15),
              ),
              child: GridView.custom(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  pattern: [
                    const QuiltedGridTile(2, 2),
                    const QuiltedGridTile(1, 1),
                    const QuiltedGridTile(1, 1),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (logic.images[index] != null) {
                      return imageTile(imageUrl: logic.images[index] ?? "", index: index, context: context);
                    } else {
                      return buildAddButton(index: index, context: context);
                    }
                  },
                  childCount: logic.images.length,
                ),
              ),
            );
          },
        ),
        30.height,
        Row(
          children: [
            Text(
              EnumLocale.txtMyVideo.name.tr,
              style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
            ),
            const Spacer(),
            GetBuilder<HostEditProfileController>(
              builder: (logic) {
                return GestureDetector(
                  onTap: () => logic.onAddVideoSheet(context),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.settingColor,
                        border: Border.all(
                          color: AppColors.colorGry1.withValues(alpha: 0.50),
                        ),
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      EnumLocale.txtAddMore.name.tr,
                      style: AppFontStyle.styleW600(AppColors.whiteColor.withValues(alpha: 0.40), 12),
                    ).paddingOnly(left: 8, right: 7, top: 5, bottom: 5),
                  ),
                );
              },
            ),
          ],
        ),
        15.height,
        GetBuilder<HostEditProfileController>(
          id: AppConstant.idShowThumbnail,
          builder: (logic) {
            final totalVideos = logic.videoUrls.length + logic.newLocalVideos.length;
            final itemCount = totalVideos;

            return SizedBox(
              height: 190,
              child: ListView.builder(
                itemCount: itemCount,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final isServer = index < logic.videoUrls.length;

                  String? thumbPath;
                  if (index >= 0 && index < logic.thumbnails.length) {
                    thumbPath = logic.thumbnails[index];
                  }

                  return GestureDetector(
                    onTap: () {
                      final allVideos = [...logic.videoUrls, ...logic.newLocalVideos];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditReelsPlayerView(
                            videoUrls: allVideos,
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 185,
                          width: 145,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black12,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: (thumbPath != null && thumbPath.isNotEmpty)
                              ? Image.file(File(thumbPath), fit: BoxFit.cover)
                              : Center(child: Image.asset(AppAsset.icPlaceHolder, width: 100, height: 100)),
                        ),
                        Positioned(
                          right: 5,
                          top: 3,
                          child: InkWell(
                            onTap: () => Get.find<HostEditProfileController>().onDeleteVideo(index, isServer: isServer),
                            child: Image.asset(AppAsset.icEditDelete, height: 45, width: 45),
                          ),
                        ),
                        Positioned(
                          right: 40,
                          top: 3,
                          child: InkWell(
                            onTap: () => Get.find<HostEditProfileController>().onReplaceVideo(index, isServer: isServer),
                            child: Image.asset(AppAsset.icEditImage, height: 45, width: 45),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(AppAsset.icPlay, height: 50, width: 50),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

// ======================== Image ========================
Widget imageTile({
  required String imageUrl,
  required int index,
  required BuildContext context,
}) {
  return Stack(
    children: [
      GetBuilder<HostEditProfileController>(
        builder: (logic) {
          final isNet = logic.isNetworkImage(imageUrl);

          final BorderRadius radius = index == 0
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )
              : index == 1
                  ? const BorderRadius.only(topRight: Radius.circular(10))
                  : index == 2
                      ? const BorderRadius.only(bottomRight: Radius.circular(10))
                      : BorderRadius.zero;

          final bool hasImage = logic.images[index] != null && logic.images[index]!.isNotEmpty;

          return GestureDetector(
            onTap: () => logic.onHostPickImage(index, context),
            child: ClipRRect(
              borderRadius: radius,
              child: hasImage
                  ? (isNet
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          height: Get.height,
                          width: Get.width,
                        )
                      : Image.file(
                          File(imageUrl),
                          fit: BoxFit.cover,
                          height: Get.height,
                          width: Get.width,
                        ))
                  : const SizedBox.shrink(),
            ),
          );
        },
      ),
      Positioned(
        top: 5,
        right: 5,
        child: GetBuilder<HostEditProfileController>(
          builder: (logic) {
            return GestureDetector(
              onTap: () => logic.onCancelProfileImage(index: index),
              child: Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blackColor,
                  border: Border.all(color: AppColors.colorGry, width: 2),
                ),
                child: Center(
                  child: Image.asset(
                    AppAsset.icVipClose,
                    color: AppColors.whiteColor,
                    width: 15,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget buildAddButton({required int index, required BuildContext context}) {
  return GetBuilder<HostEditProfileController>(
    builder: (logic) {
      return GestureDetector(
        onTap: () {
          logic.onHostPickImage(index, context);
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withValues(alpha: 0.2),
                borderRadius: index == 0
                    ? const BorderRadius.only(topLeft: Radius.circular(10))
                    : index == 1
                        ? const BorderRadius.only(topRight: Radius.circular(10))
                        : index == 3
                            ? const BorderRadius.only(bottomLeft: Radius.circular(10))
                            : index == 5
                                ? const BorderRadius.only(bottomRight: Radius.circular(10))
                                : null,
              ),
              child: Center(
                child: Icon(Icons.add, color: AppColors.whiteColor, size: 40),
              ),
            ),
          ],
        ),
      );
    },
  );
}
