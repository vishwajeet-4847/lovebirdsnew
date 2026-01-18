import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:LoveBirds/custom/app_title/custom_title.dart';
import 'package:LoveBirds/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:LoveBirds/custom/cupertino_date_picker/date_picker.dart';
import 'package:LoveBirds/custom/gender.dart';
import 'package:LoveBirds/custom/gradiant_border_container.dart';
import 'package:LoveBirds/custom/text_field/custom_text_field.dart';
import 'package:LoveBirds/pages/host_request_page/controller/host_request_controller.dart';
import 'package:LoveBirds/pages/host_request_page/widget/host_request_language.dart';
import 'package:LoveBirds/pages/host_request_page/widget/video_player_screen.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

//***************** Host Request Step 1
class HostRequestStep1View extends StatelessWidget {
  const HostRequestStep1View({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UploadImageWidget(),
        HostOtherDetailsView(),
      ],
    );
  }
}

class UploadImageWidget extends StatelessWidget {
  const UploadImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostRequestController>(
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              EnumLocale.txtUploadYourImages.name.tr,
              style: AppFontStyle.styleW400(AppColors.whiteColor, 18),
            ),
            20.height,
            Container(
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
                      return imageTile(
                          imageUrl: logic.images[index] ?? "",
                          index: index,
                          context: context);
                    } else {
                      return buildAddButton(index: index, context: context);
                    }
                  },
                  childCount: logic.images.length,
                ),
              ),
            ),
            25.height,
          ],
        );
      },
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
      GetBuilder<HostRequestController>(
        builder: (logic) {
          return GestureDetector(
            onTap: () => logic.onHostPickImage(index, context),
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: index == 0
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )
                    : index == 1
                        ? const BorderRadius.only(topRight: Radius.circular(10))
                        : index == 2
                            ? const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              )
                            : null,
              ),
              child: logic.images[index] != null
                  ? ClipRRect(
                      borderRadius: index == 0
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            )
                          : index == 1
                              ? const BorderRadius.only(
                                  topRight: Radius.circular(10))
                              : index == 2
                                  ? const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                    )
                                  : BorderRadius.circular(0),
                      child: Image.file(
                        File(logic.images[index]!),
                        height: Get.height,
                        width: Get.width,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(),
            ),
          );
        },
      ),
      Positioned(
        top: 0,
        left: 0,
        child: index == 0
            ? Container(
                clipBehavior: Clip.antiAlias,
                height: 30,
                width: 86,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withValues(alpha: 0.22),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  EnumLocale.txtProfileImage.name.tr,
                  style: AppFontStyle.styleW500(
                    AppColors.whiteColor,
                    11,
                  ),
                ),
              )
            : Container(),
      ),
      Positioned(
        top: 5,
        right: 5,
        child: GetBuilder<HostRequestController>(
          builder: (logic) {
            return GestureDetector(
              onTap: () => logic.onCancelMainProfileImage(index: index),
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

// =========================== Container ===========================
Widget buildAddButton({required int index, required BuildContext context}) {
  return GetBuilder<HostRequestController>(
    builder: (logic) {
      return GestureDetector(
        onTap: () {
          logic.onHostPickImage(index, context);
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withValues(alpha: 0.2),
                borderRadius: index == 0
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )
                    : index == 1
                        ? const BorderRadius.only(topRight: Radius.circular(10))
                        : index == 2
                            ? const BorderRadius.only(
                                bottomRight: Radius.circular(10))
                            : null,
              ),
              child: Center(
                child: Image.asset(
                  AppAsset.addPurpleIcon,
                  width: 28,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: index == 0
                  ? Container(
                      clipBehavior: Clip.antiAlias,
                      height: 30,
                      width: 86,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withValues(alpha: 0.22),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(EnumLocale.txtProfileImage.name.tr,
                          style:
                              AppFontStyle.styleW500(AppColors.whiteColor, 11)),
                    )
                  : Container(),
            ),
          ],
        ),
      );
    },
  );
}

//******************* Host details
class HostOtherDetailsView extends StatelessWidget {
  const HostOtherDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle1(title: EnumLocale.txtName.name.tr),
        GetBuilder<HostRequestController>(
          builder: (logic) {
            return CustomTextField(
              hintText: EnumLocale.txtEnterYourName.name.tr,
              controller: logic.hostNameController,
              hintTextSize: 16,
              hintTextColor: AppColors.colorGry.withValues(alpha: 0.7),
              fontColor: AppColors.whiteColor,
              fillColor: AppColors.whiteColor.withValues(alpha: 0.2),
              cursorColor: AppColors.whiteColor,
              keyboardType: TextInputType.name,
              filled: true,
            );
          },
        ),
        15.height,
        CustomTitle1(title: EnumLocale.txtDob.name.tr),
        GetBuilder<DatePickerController>(
          id: AppConstant.idUpdateDate,
          builder: (logic) {
            return GestureDetector(
              onTap: () {
                showCupertinoDatePicker(context: context);
              },
              child: Container(
                height: 55,
                width: Get.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  logic.date.split(" ")[0],
                  style: AppFontStyle.styleW600(AppColors.whiteColor, 15),
                ),
              ),
            );
          },
        ),
        15.height,
        CustomTitle1(title: EnumLocale.txtCountry.name.tr),
        GetBuilder<HostRequestController>(
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
                  color: AppColors.whiteColor.withValues(alpha: 0.2),
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
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    10.width,
                  ],
                ),
              ),
            );
          },
        ),
        15.height,
        CustomTitle1(title: EnumLocale.txtGender.name.tr),
        GetBuilder<HostRequestController>(
          id: AppConstant.onChangeGender,
          builder: (controller) => Row(
            children: [
              GenderButtonWidget(
                title: EnumLocale.txtMale.name.tr,
                image: AppAsset.icMale,
                isSelected: controller.isMale,
                callback: () => controller.onChangeGender(true),
              ),
              15.width,
              GenderButtonWidget(
                title: EnumLocale.txtFemale.name.tr,
                image: AppAsset.icFemale,
                isSelected: !controller.isMale,
                callback: () => controller.onChangeGender(false),
              ),
            ],
          ),
        ),
        15.height,
        CustomTitle1(title: EnumLocale.txtBio.name.tr),
        GetBuilder<HostRequestController>(
          builder: (logic) {
            return CustomTextField(
              textInputAction: TextInputAction.next,
              filled: true,
              controller: logic.hostBioController,
              fillColor: AppColors.whiteColor.withValues(alpha: 0.2),
              fontColor: AppColors.whiteColor,
              hintText: EnumLocale.txtEnterBio.name.tr,
              hintTextSize: 16,
              hintTextColor: AppColors.colorGry.withValues(alpha: 0.7),
              cursorColor: AppColors.whiteColor,
              keyboardType: TextInputType.text,
              maxLines: 5,
            );
          },
        ),
        10.height,
      ],
    );
  }
}

//***************** Host Request Step 2
class HostRequestStep2View extends StatelessWidget {
  const HostRequestStep2View({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectImpressionView(),
        SelectLanguageView(),
        HostRequestAgencyCodeView(),
      ],
    );
  }
}

//***************** Host Select Impression
class SelectImpressionView extends StatelessWidget {
  const SelectImpressionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle1(
          title: EnumLocale.txtSelectImpression.name.tr,
        ).paddingOnly(top: 15, bottom: 15),
        GetBuilder<HostRequestController>(
          builder: (logic) {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: logic.impressionList.map(
                (category) {
                  bool isSelected =
                      logic.selectedImpressionList.contains(category);
                  return GestureDetector(
                    onTap: () => logic.toggleSelectionCategories(category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 9),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.selectImpressionColor
                            : AppColors.unselectImpressionColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(category,
                          style:
                              AppFontStyle.styleW600(AppColors.whiteColor, 15)),
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ],
    );
  }
}

class SelectLanguageView extends StatelessWidget {
  const SelectLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostRequestController>(
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.height,
            CustomTitle1(title: EnumLocale.txtSelectMultipleLanguage.name.tr),
            GestureDetector(
              onTap: () =>
                  HostRequestLanguagePicker.pickLanguageForHostRequest(context),
              child: Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.unselectImpressionColor,
                ),
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  children: [
                    Text(
                      EnumLocale.txtSelectLanguage.name.tr,
                      style: AppFontStyle.styleW500(AppColors.colorGry, 14),
                    ),
                    const Spacer(),
                    Image.asset(
                      AppAsset.icBottomArrow,
                      height: 14,
                      width: 14,
                      color: AppColors.whiteColor,
                    ).paddingOnly(right: 5),
                  ],
                ),
              ),
            ),
            logic.selectedLanguages.isEmpty
                ? const SizedBox()
                : Text(
                    EnumLocale.txtMyLanguage.name.tr,
                    style:
                        AppFontStyle.styleW600(AppColors.myLanguageColor, 16),
                  ).paddingOnly(top: 20),
            15.height,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: logic.selectedLanguages.map(
                (category) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                    decoration: BoxDecoration(
                      color: AppColors.unselectImpressionColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(category,
                            style: AppFontStyle.styleW600(
                                AppColors.whiteColor, 15)),
                        const SizedBox(width: 8),
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
            ),
          ],
        );
      },
    );
  }
}

class HostRequestAgencyCodeView extends StatelessWidget {
  const HostRequestAgencyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostRequestController>(
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,
            CustomTitle1(
              title:
                  "${EnumLocale.txtAgencyCode.name.tr} (${EnumLocale.txtOptional.name.tr})",
            ),
            CustomTextField(
              maxLines: 1,
              textInputAction: TextInputAction.next,
              filled: true,
              controller: logic.hostReferenceCodeController,
              fillColor: AppColors.unselectImpressionColor,
              fontColor: AppColors.whiteColor,
              hintText: EnumLocale.txtEnterAgencyCode.name.tr,
              hintTextSize: 16,
              hintTextColor: AppColors.colorGry.withValues(alpha: 0.7),
              cursorColor: AppColors.whiteColor,
              keyboardType: TextInputType.text,
            ),
          ],
        );
      },
    );
  }
}

//****************** Host Request Step 3
class HostRequestStep3View extends StatelessWidget {
  const HostRequestStep3View({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SelectDocumentsView(),
        SelectProfileVideoView(),
      ],
    );
  }
}

//*************** Host Select document View
class SelectDocumentsView extends StatelessWidget {
  const SelectDocumentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.height,
        GetBuilder<HostRequestController>(
          id: AppConstant.idIdentityProof,
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle1(title: EnumLocale.txtSelectDocumentType.name.tr),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    value: controller.selectedDocumentType?.isEmpty ?? true
                        ? null
                        : controller.selectedDocumentType,
                    hint: Text(
                      EnumLocale.txtSelectDocument.name.tr,
                      style: AppFontStyle.styleW500(AppColors.whiteColor, 14),
                    ),
                    items: controller.proofType.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.title,
                        child: Text(
                          item.title ?? "",
                          style:
                              AppFontStyle.styleW500(AppColors.whiteColor, 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      log("selectedProofTitle (Dropdown2): $value");
                      controller.selectedDocumentType = value ?? "";
                      controller.update([
                        AppConstant.idIdentityProof,
                        AppConstant.idDocumentType
                      ]);
                    },
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: AppColors.whiteColor),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: AppColors.colorWalletText,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        20.height,
        Row(
          children: [
            Expanded(
              child: GetBuilder<HostRequestController>(
                id: AppConstant.idChangeProfileImage,
                builder: (controller) => ImageUploadContainer(
                  childTxt: EnumLocale.txtAttach.name.tr,
                  imagePath: controller.fontImage,
                  placeholderAsset: AppAsset.icIdImage,
                  title:
                      "${EnumLocale.txtUploadIdPhotos.name.tr} ${EnumLocale.txtFront.name.tr}",
                  onPick: () => controller.onPickProfileImage(context),
                  onCancel: controller.onCancelProfileImage,
                ),
              ),
            ),
            15.width,
            Expanded(
              child: GetBuilder<HostRequestController>(
                id: AppConstant.idChangeDocumentImage,
                builder: (controller) => ImageUploadContainer(
                  childTxt: EnumLocale.txtAttach.name.tr,
                  imagePath: controller.backImage,
                  placeholderAsset: AppAsset.icIdImage,
                  title:
                      "${EnumLocale.txtUploadIdPhotos.name.tr} ${EnumLocale.txtBack.name.tr}",
                  onPick: () => controller.onPickDocumentImage(context),
                  onCancel: controller.onCancelDocumentImage,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ImageUploadContainer extends StatelessWidget {
  final String? imagePath;
  final String placeholderAsset;
  final String title;
  final String childTxt;
  final VoidCallback onPick;
  final VoidCallback onCancel;

  const ImageUploadContainer({
    super.key,
    required this.imagePath,
    required this.placeholderAsset,
    required this.title,
    required this.childTxt,
    required this.onPick,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return GradiantBorderContainer(
      height: 200,
      radius: 20,
      child: imagePath != null
          ? Container(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(1.5),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(18)),
              child: Stack(
                children: [
                  Image.file(
                    File(imagePath!),
                    height: 210,
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 5,
                    right: 6,
                    child: GestureDetector(
                      onTap: onCancel,
                      child: Container(
                        height: 60,
                        width: 60,
                        color: AppColors.transparent,
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.blackColor,
                            border:
                                Border.all(color: AppColors.colorGry, width: 2),
                          ),
                          child: Center(
                            child: Image.asset(
                              AppAsset.icVipClose,
                              color: AppColors.whiteColor,
                              width: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(placeholderAsset, width: 72),
                  Text(title,
                      style: AppFontStyle.styleW500(AppColors.colorGry2, 14)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: GestureDetector(
                      onTap: onPick,
                      child: Container(
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.purpleLight,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(childTxt,
                            style: AppFontStyle.styleW700(
                                AppColors.whiteColor, 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

//*************** Host Select profile video
class SelectProfileVideoView extends StatelessWidget {
  const SelectProfileVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostRequestController>(
      id: AppConstant.idChangeProfileImage,
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle1(title: EnumLocale.txtProfileVideo.name.tr),
            Row(
              children: [
                VideoUploadContainer(
                  childTxt: EnumLocale.txtUpload.name.tr,
                  placeholderAsset: AppAsset.icUpload,
                  title: EnumLocale.txtUploadVideo.name.tr,
                  onPick: () => controller.onPickProfileVideo(context),
                ),
                controller.mediaFileList.isEmpty == true
                    ? const SizedBox()
                    : Expanded(
                        child: SizedBox(
                          height: 190,
                          child: ListView.builder(
                            itemCount: controller.mediaFileList.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        ChewiePlayerScreen(
                                          file: File(controller
                                              .mediaFileList[index].path),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 185,
                                      width: 145,
                                      margin: const EdgeInsets.only(left: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: controller
                                                    .videoThumbnails[index] !=
                                                null
                                            ? DecorationImage(
                                                image: MemoryImage(controller
                                                    .videoThumbnails[index]!),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                        color: Colors.black12,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    top: 3,
                                    child: InkWell(
                                      onTap: () {
                                        controller.mediaFileList
                                            .removeAt(index);
                                        controller.videoThumbnails
                                            .removeAt(index);
                                        controller.update(
                                            [AppConstant.idChangeProfileImage]);
                                      },
                                      child: Image.asset(
                                        AppAsset.icDelete,
                                        height: 45,
                                        width: 45,
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            ChewiePlayerScreen(
                                              file: File(controller
                                                  .mediaFileList[index].path),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          AppAsset.icPlay,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ).paddingOnly(top: 15);
      },
    );
  }
}

class VideoUploadContainer extends StatelessWidget {
  final String placeholderAsset;
  final String title;
  final String childTxt;
  final VoidCallback onPick;

  const VideoUploadContainer({
    super.key,
    required this.placeholderAsset,
    required this.title,
    required this.childTxt,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return GradiantBorderContainer(
      height: 190,
      width: 150,
      radius: 20,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(placeholderAsset, width: 72),
            Text(title, style: AppFontStyle.styleW500(AppColors.colorGry2, 14)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: GestureDetector(
                onTap: onPick,
                child: Container(
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.purpleLight,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(childTxt,
                      style: AppFontStyle.styleW700(AppColors.whiteColor, 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
