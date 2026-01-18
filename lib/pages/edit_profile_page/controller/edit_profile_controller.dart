import 'dart:developer';

import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/custom/bottom_sheet/image_picker_bottom_sheet.dart';
import 'package:LoveBirds/custom/country_picker.dart';
import 'package:LoveBirds/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:LoveBirds/custom/custom_image_piker.dart';
import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/edit_profile_page/api/edit_profile_api.dart';
import 'package:LoveBirds/pages/edit_profile_page/model/edit_profile_model.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  EditProfileModel? editProfileModel;
  String profileImage = "";
  String pickImages = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioDetailsController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController flagController = TextEditingController();

  DatePickerController datePickerController = Get.put(DatePickerController());

  bool isLoading = false;

  @override
  void onInit() async {
    await onSetData();
    super.onInit();
  }

  onSetData() async {
    isLoading = true;
    update();

    await CustomFetchUserCoin.init();

    nameController.text =
        CustomFetchUserCoin.fetchLoginUserProfileModel?.user?.name ?? "";
    emailController.text =
        CustomFetchUserCoin.fetchLoginUserProfileModel?.user?.email ?? "";
    bioDetailsController.text =
        CustomFetchUserCoin.fetchLoginUserProfileModel?.user?.bio ?? "";
    countryController.text =
        CustomFetchUserCoin.fetchLoginUserProfileModel?.user?.country ?? "";
    flagController.text = CustomFetchUserCoin
            .fetchLoginUserProfileModel?.user?.countryFlagImage ??
        "";
    profileImage =
        CustomFetchUserCoin.fetchLoginUserProfileModel?.user?.image ?? "";
    datePickerController.selectedDateString =
        CustomFetchUserCoin.fetchLoginUserProfileModel?.user?.dob ?? "";

    isLoading = false;
    update([AppConstant.idChangeCountry, AppConstant.idChangeCountry]);
    datePickerController.update([AppConstant.idUpdateDate]);
    update();
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

  Future<void> onProfileImage(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await ImagePickerBottomSheetUi.show(
      context: context,
      onClickCamera: () async => pickImage(ImageSource.camera),
      onClickGallery: () async => pickImage(ImageSource.gallery),
    );
    update();
  }

  Future<void> pickImage(ImageSource source) async {
    final imagePath = await CustomImagePicker.pickImage(source);
    if (imagePath != null) {
      pickImages = imagePath;
      update();
    }
  }

  Future<void> onSaveProfile() async {
    Utils.showLog("Click On Save Profile => ${Database.loginUserId}");

    if (nameController.text.trim().isEmpty) {
      Utils.showToast(EnumLocale.txtPleaseEnterYourName.name.tr);
      return;
    }

    try {
      Get.dialog(
        const PopScope(canPop: false, child: LoadingWidget()),
        barrierDismissible: false,
      );

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();
      log("image=>$pickImages");

      editProfileModel = await EditProfileApi.callApi(
        image: pickImages.isEmpty == true ? null : pickImages,
        name: nameController.text,
        country: countryController.text,
        bio: bioDetailsController.text,
        countryFlagImage: flagController.text,
        loginUserId: Database.loginUserId,
        token: token ?? "",
        uid: uid ?? "",
        date: datePickerController.selectedDateString,
      );
      Get.back();

      if (editProfileModel?.status == true) {
        Utils.showToast(editProfileModel?.message ?? "");

        log("profileImage************* ${Database.profileImage}");
        Database.onSetUserProfileImage(pickImages);
        Database.onSetUserName(nameController.text);
        update();
        Get.back();
      } else {
        Utils.showToast(editProfileModel?.message ?? "");
      }
    } catch (e) {
      Get.back();
      Utils.showLog("Error updating profile: $e");
      Utils.showToast(
          "Failed to update profile. Please check your internet connection.");
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
