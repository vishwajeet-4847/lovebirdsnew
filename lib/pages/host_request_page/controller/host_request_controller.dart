import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:figgy/common/loading_widget.dart';
import 'package:figgy/custom/bottom_sheet/image_picker_bottom_sheet.dart';
import 'package:figgy/custom/country_picker.dart';
import 'package:figgy/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:figgy/custom/custom_image_piker.dart';
import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/host_request_page/api/create_verification_request_api.dart';
import 'package:figgy/pages/host_request_page/api/fetch_impression_api.dart';
import 'package:figgy/pages/host_request_page/api/host_request_api.dart';
import 'package:figgy/pages/host_request_page/api/validate_agency_code_api.dart';
import 'package:figgy/pages/host_request_page/model/fetch_impression_model.dart';
import 'package:figgy/pages/host_request_page/model/get_identity_proof_model.dart';
import 'package:figgy/pages/host_request_page/model/host_request_model.dart';
import 'package:figgy/pages/host_request_page/model/validate_agency_code_model.dart';
import 'package:figgy/pages/host_request_page/widget/host_request_widget.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class HostRequestController extends GetxController {
  int currentStep = 1;

  //************** Host Details
  List<dynamic> images = List.generate(3, (index) => null);

  TextEditingController hostNameController = TextEditingController();
  TextEditingController hostBioController = TextEditingController();
  DatePickerController datePickerController = Get.put(DatePickerController());
  TextEditingController countryController = TextEditingController();
  TextEditingController flagController = TextEditingController();
  bool isMale = true;

  //**************** Host Select Impression
  FetchImpressionModel? fetchImpressionModel;

  List<String> impressionList = [];
  List<String> selectedImpressionList = [];

  //************** Host Select Language
  Map<String, dynamic> allLanguageData = {};
  TextEditingController languageSearchController = TextEditingController();
  List<String> allLanguages = [];
  List<String> filteredLanguages = [];
  List<String> selectedLanguages = [];

  //************ Host Request Agency Code
  TextEditingController hostReferenceCodeController = TextEditingController();

  //*********** Host Request Identity Proof
  String? fontImage;
  String? backImage;
  String? selectedIdentityType;
  String? selectedDocumentType;

  List<String> identityProof = [];
  List<Type> proofType = [];

  GetIdentityProofModel? getIdentityProofModel;

  //***************** Validate Agency Code
  ValidateAgencyCodeModel? validateAgencyCodeModel;

  //***************** Host Request send API
  HostRequestModel? hostRequestModel;

  //*********** Host Request upload video
  final ImagePicker imagePicker = ImagePicker();
  List<dynamic> mediaFileList = [];
  List<Uint8List?> videoThumbnails = [];

  @override
  void onInit() {
    getImpression();
    allLanguage();
    onIdentityProof();

    super.onInit();
  }

  //******************** Host Request Stepper view
  Future<void> nextStep() async {
    log("message========================= $currentStep");

    if (currentStep < 3) {
      if (currentStep == 1) {
        if (images.any((image) => image == null)) {
          Utils.showToast(EnumLocale.txtPleaseSelectImage.name.tr);
        } else if (hostNameController.text.isEmpty) {
          Utils.showToast(EnumLocale.txtPleaseEnterYourName.name.tr);
        } else if (datePickerController.selectedDateString.isEmpty) {
          Utils.showToast(EnumLocale.txtPleaseEnterYourDOB.name.tr);
        } else if (hostBioController.text.isEmpty) {
          Utils.showToast(EnumLocale.txtPleaseEnterYourBio.name.tr);
        } else if (countryController.text.isEmpty) {
          Utils.showToast(EnumLocale.txtPleaseSelectCountry.name.tr);
        } else {
          currentStep++;
        }
      } else {
        if (hostReferenceCodeController.text.isNotEmpty) {
          validateAgencyCodeModel = await ValidateAgencyCodeApi.callApi(
            agencyCode: hostReferenceCodeController.text.trim(),
          );

          if (validateAgencyCodeModel?.status == true) {
            if (selectedImpressionList.isEmpty) {
              Utils.showToast("Please select at least one impression");
            } else if (selectedLanguages.isEmpty) {
              Utils.showToast("Please select at least one language");
            } else {
              currentStep++;
            }
          } else {
            Utils.showToast(validateAgencyCodeModel?.message ?? "");
          }
        } else {
          if (selectedImpressionList.isEmpty) {
            Utils.showToast("Please select at least one impression");
          } else if (selectedLanguages.isEmpty) {
            Utils.showToast("Please select at least one language");
          } else {
            currentStep++;
          }
        }
      }

      update();
    } else {
      log("message=========================");

      if (selectedDocumentType == null || selectedDocumentType!.isEmpty) {
        return Utils.showToast(EnumLocale.txtPleaseSelectADocumentType.name.tr);
      } else if (fontImage == null || backImage == null) {
        return Utils.showToast(EnumLocale.txtPleaseSelectImage.name.tr);
      } else if (mediaFileList.isEmpty == true) {
        return Utils.showToast(EnumLocale.txtPleaseSelectVideo.name.tr);
      } else {
        log("mediaFileLis================= ${mediaFileList.map((e) => e.path).toList()}");

        hostRequestApiCall();
      }
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      currentStep--;
      update();
    } else {
      Get.back(); // Exit screen if on step 0
    }
  }

  Widget getCurrentStepView() {
    switch (currentStep) {
      case 1:
        return const HostRequestStep1View();
      case 2:
        return const HostRequestStep2View();
      case 3:
        return const HostRequestStep3View();
      default:
        return const SizedBox();
    }
  }

  //****************** Host Request Image View
  Future<void> onHostPickImage(int index, BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await ImagePickerBottomSheetUi.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);

        if (imagePath != null) {
          images[index] = imagePath;
          update();
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);

        if (imagePath != null) {
          images[index] = imagePath;
          update();
        }
      },
    );
  }

  Future<void> onCancelMainProfileImage({required int index}) async {
    images[index] = null;
    update();
    _validateImagesAfterDelete();
  }

  void _validateImagesAfterDelete() {
    int selectedImages = images.where((e) => e != null).length;
    bool isProfileImageSelected = images[0] != null;

    if (!isProfileImageSelected) {
      Utils.showToast("Profile image is required");
    } else if (selectedImages < 3) {
      Utils.showToast("Minimum 3 images are required");
    }
  }

  //****************** Host Request Other Details View
  void onChangeGender(bool isMale) {
    this.isMale = isMale;
    log(this.isMale.toString());

    update([AppConstant.onChangeGender]);
  }

  void onChangeCountry(BuildContext context) {
    CustomCountryPicker.pickCountry(
      context,
      false,
      (country) {
        flagController.text = country.flagEmoji;
        countryController.text = country.name;
        update([AppConstant.idChangeCountry]);
        log("aa=>${country.flagEmoji}");
      },
    );
  }

  //**************** Host Request Select Impression View
  void toggleSelectionCategories(String category) {
    if (selectedImpressionList.contains(category)) {
      selectedImpressionList.remove(category);
    } else {
      selectedImpressionList.add(category);
    }
    log("selectedCategories: $selectedImpressionList");
    update();
  }

  Future<void> getImpression() async {
    fetchImpressionModel = await FetchImpressionApi.callApi();

    if (fetchImpressionModel != null) {
      impressionList = fetchImpressionModel!.personalityImpressions.map((e) => e.name).toList();
    } else {
      impressionList = [];
    }

    update();
  }

  //*************** Host Request Select Language View
  allLanguage() async {
    final String response = await rootBundle.loadString(AppAsset.getAllLanguage);
    allLanguageData = jsonDecode(response);

    allLanguages = allLanguageData.values.map((e) => e as String).toList();
    filteredLanguages = List.from(allLanguages);
    update();

    return allLanguageData;
  }

  void onLanguageSearch(String query) {
    if (query.isEmpty) {
      filteredLanguages = List.from(allLanguages);
    } else {
      filteredLanguages = allLanguages.where((lang) => lang.toLowerCase().contains(query.toLowerCase())).toList();
    }
    update();
  }

  void toggleSelectionLanguage(String category) {
    if (selectedLanguages.contains(category)) {
      selectedLanguages.remove(category);
    } else {
      selectedLanguages.add(category);
    }
    log("selectedCategories1: $selectedLanguages");
    update();
  }

  // **************** Host Request Identity proof view
  Future<void> onPickProfileImage(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (selectedDocumentType == null) {
      Utils.showToast(EnumLocale.txtPleaseSelectDocument.name.tr);
    } else {
      await ImagePickerBottomSheetUi.show(
        context: context,
        onClickCamera: () async {
          final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);

          if (imagePath != null) {
            fontImage = imagePath;
            identityProof.add(fontImage ?? "");

            Utils.showLog("image>>>>>>>>>>>>>>$identityProof");
            update([AppConstant.idChangeProfileImage]);
          }
        },
        onClickGallery: () async {
          final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);

          if (imagePath != null) {
            fontImage = imagePath;
            identityProof.add(fontImage ?? "");

            Utils.showLog("image>>>>>>>>>>>>>>$identityProof");

            update([AppConstant.idChangeProfileImage]);
          }
        },
      );
    }
  }

  Future<void> onIdentityProof() async {
    getIdentityProofModel = await GetIdentityProof.callApi();
    proofType = getIdentityProofModel?.data ?? <Type>[];
    update([AppConstant.idIdentityProof]);
  }

  Future<void> onPickDocumentImage(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (selectedDocumentType == null) {
      Utils.showToast(EnumLocale.txtPleaseSelectDocument.name.tr);
    } else {
      await ImagePickerBottomSheetUi.show(
        context: context,
        onClickCamera: () async {
          final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);

          if (imagePath != null) {
            backImage = imagePath;
            identityProof.add(backImage ?? "");
            Utils.showLog("image>>>>>>>>>>>>>>$identityProof");

            update([AppConstant.idChangeDocumentImage]);
          }
        },
        onClickGallery: () async {
          final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);

          if (imagePath != null) {
            backImage = imagePath;
            identityProof.add(backImage ?? "");
            Utils.showLog("image>>>>>>>>>>>>>>$identityProof");

            update([AppConstant.idChangeDocumentImage]);
          }
        },
      );
    }
  }

  Future<void> onCancelProfileImage() async {
    if (fontImage != null) {
      identityProof.remove(fontImage); // remove from list
    }

    fontImage = null;
    update([AppConstant.idChangeProfileImage]);

    Utils.showLog("image>>>>>>>>>>>>>>$backImage");
    Utils.showLog("image>>>>>>>>>>>>>>$identityProof");
  }

  Future<void> onCancelDocumentImage() async {
    if (backImage != null) {
      identityProof.remove(backImage); // remove from list
    }

    backImage = null;
    update([AppConstant.idChangeDocumentImage]);

    Utils.showLog("image>>>>>>>>>>>>>>$backImage");
    Utils.showLog("image>>>>>>>>>>>>>>$identityProof");
  }

  // **************** Host Request upload video
  Future<void> onPickProfileVideo(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await ImagePickerBottomSheetUi.show(
        context: context,
        mainTitle: EnumLocale.txtChooseVideo.name.tr,
        title: EnumLocale.txtTakeVideo.name.tr,
        onClickCamera: () async {
          final XFile? video = await imagePicker.pickVideo(
            source: ImageSource.camera,
          );
          if (video != null) {
            mediaFileList.add(File(video.path));

            final uint8list = await VideoThumbnail.thumbnailData(
              video: video.path,
              imageFormat: ImageFormat.PNG,
              maxWidth: 128,
              quality: 25,
            );

            videoThumbnails.add(uint8list);
          }
          update([AppConstant.idChangeProfileImage]);
        },
        onClickGallery: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.video,
            allowMultiple: true,
          );

          if (result != null) {
            for (var file in result.files) {
              if (file.path != null) {
                final videoFile = File(file.path!);
                mediaFileList.add(videoFile);

                final uint8list = await VideoThumbnail.thumbnailData(
                  video: videoFile.path,
                  imageFormat: ImageFormat.PNG,
                  maxWidth: 128,
                  quality: 25,
                );

                videoThumbnails.add(uint8list);
              }
            }
            update([AppConstant.idChangeProfileImage]);
          }
        });
  }

  //****************** Host Request Send API
  void hostRequestApiCall() async {
    log("Call Host Request Api Calling...");

    try {
      Get.dialog(
        const PopScope(canPop: false, child: LoadingWidget()),
        barrierDismissible: false,
      );

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();
      final fcmToken = await FirebaseMessaging.instance.getToken();

      hostRequestModel = await HostRequestApi.callApi(
        fcmToken: fcmToken ?? "",
        uid: uid ?? '',
        token: token ?? '',
        name: hostNameController.text.trim(),
        email: Database.email,
        bio: hostBioController.text.trim(),
        dob: datePickerController.date,
        gender: isMale == true ? "male" : "female",
        country: countryController.text.trim(),
        countryFlagImage: flagController.text.trim(),
        photoGallery: images,
        identityProof: identityProof,
        impression: selectedImpressionList.join(","),
        agencyCode: hostReferenceCodeController.text.trim(),
        language: selectedLanguages.join(','),
        identityProofType: selectedDocumentType ?? "",
        profileVideo: mediaFileList.map((e) => e.path).toList(),
      );

      Get.back();

      if (hostRequestModel?.status == true) {
        Utils.showToast(hostRequestModel?.message ?? "");

        Get.toNamed(AppRoutes.verificationPage);
      } else {
        Utils.showToast(hostRequestModel?.message ?? "");
      }
    } catch (e) {
      Get.back();
      Utils.showLog("Error Host Request Api Calling: $e");
    }
  }
}
