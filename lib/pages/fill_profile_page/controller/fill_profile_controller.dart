import 'dart:async';
import 'dart:developer';

import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/custom/bottom_sheet/image_picker_bottom_sheet.dart';
import 'package:LoveBirds/custom/country_picker.dart';
import 'package:LoveBirds/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:LoveBirds/custom/custom_image_piker.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/edit_profile_page/api/edit_profile_api.dart';
import 'package:LoveBirds/pages/edit_profile_page/model/edit_profile_model.dart';
import 'package:LoveBirds/pages/host_detail_page/api/get_host_profile_api.dart';
import 'package:LoveBirds/pages/host_detail_page/model/get_user_profile_model.dart';
import 'package:LoveBirds/pages/login_page/api/fetch_login_user_profile_api.dart';
import 'package:LoveBirds/pages/login_page/model/fetch_login_user_profile_model.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FillProfileController extends GetxController {
  String pickImage = "";
  String profileImage = "";
  String hostProfileImage = "";

  int? loginType;

  final profile = FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user;
  final hostProfile = GetHostProfileApi.getHostProfileModel?.host;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController bioDetailsController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController flagController = TextEditingController();

  DatePickerController datePickerController = Get.put(DatePickerController());

  EditProfileModel? editProfileModel;
  FetchLoginUserProfileModel? fetchLoginUserProfileModel;
  GetHostProfileModel? getHostProfileModel;

  String? flag = "";

  String getFlagEmoji(String countryCode) {
    return countryCode
        .toUpperCase()
        .runes
        .map((code) => String.fromCharCode(code + 127397))
        .join();
  }

  @override
  void onInit() {
    getDataFromArgs();

    super.onInit();
  }

  getDataFromArgs() {
    log("Enter fill profile*******************");

    loginType = Get.arguments["loginType"];
    profileImage = Get.arguments["image"];
    nameController.text = Get.arguments["name"];
    emailController.text = Get.arguments["email"];
    flag = getFlagEmoji(Database.countryCode);
    flagController.text = flag ?? "";
    countryController.text = Database.country;

    log("nameController.text: ${nameController.text}");
    log("emailController.text: ${emailController.text}");
    log("flagController.text: ${flagController.text}");
    log("countryController.text: ${countryController.text}");
    log("loginType: $loginType");
    log("profileImage: $profileImage");
    log("flag: $flag");

    update();
  }

  Future<void> onChangeCountry(BuildContext context) async {
    CustomCountryPicker.pickCountry(
      context,
      false,
      (country) {
        flagController.text = country.flagEmoji;
        countryController.text = country.name;
        update([AppConstant.idChangeCountry]);
      },
    );

    update([AppConstant.idChangeCountry]);
  }

  Future<void> onProfileImage(BuildContext context) async {
    // FocusManager.instance.primaryFocus?.unfocus();
    log("message");
    await ImagePickerBottomSheetUi.show(
      context: context,
      onClickCamera: () async => _pickImage(ImageSource.camera),
      onClickGallery: () async => _pickImage(ImageSource.gallery),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final imagePath = await CustomImagePicker.pickImage(source);
    if (imagePath != null) {
      pickImage = imagePath;
      update();
    }
  }

  Future<void> onSaveProfile() async {
    Utils.showLog("Click On Save Profile => ${Database.loginUserId}");

    if (nameController.text.trim().isEmpty) {
      Utils.showToast("Please enter your full name");
      return;
    }

    try {
      Get.dialog(
        const PopScope(canPop: false, child: LoadingWidget()),
        barrierDismissible: false,
      );

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      if (nameController.text.isNotEmpty) {
        editProfileModel = await EditProfileApi.callApi(
          image: pickImage.isEmpty == true ? null : pickImage,
          name: nameController.text,
          country: countryController.text,
          bio: bioDetailsController.text,
          countryFlagImage: flagController.text,
          loginUserId: Database.loginUserId,
          token: token ?? "",
          uid: uid ?? "",
          date: datePickerController.selectedDateString,
        );

        if (editProfileModel?.status == true) {
          Utils.showToast(editProfileModel?.message ?? "");
          await getProfileData(uid: uid ?? "", token: token ?? "");
        } else {
          Utils.showToast(editProfileModel?.message ?? "");
        }
      } else {
        Utils.showToast("Please enter details");
      }

      Get.back();
    } catch (e) {
      Get.back();
      Utils.showLog("Error updating profile: $e");
      Utils.showToast(
          "Failed to update profile. Please check your internet connection.");
    }
  }

  Future<void> getProfileData(
      {required String uid, required String token}) async {
    Database.isHost
        ? getHostProfileModel =
            await GetHostProfileApi.callApi(hostId: Database.hostId)
        : fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(
            token: token,
            uid: uid,
          );

    Database.onSetLoginUserId(fetchLoginUserProfileModel?.user?.id ?? "");
    Database.onSetLoginType(fetchLoginUserProfileModel?.user?.loginType ?? 0);
    Database.onSetVip(fetchLoginUserProfileModel?.user?.isVip ?? false);
    Database.onSetImpression(getHostProfileModel?.host?.impression ?? []);
    Database.isHost
        ? Database.onSetEmail(getHostProfileModel?.host?.email ?? "")
        : Database.onSetEmail(fetchLoginUserProfileModel?.user?.email ?? "");

    Database.isHost
        ? Database.onSetUniqueId(getHostProfileModel?.host?.uniqueId ?? "")
        : Database.onSetUniqueId(
            fetchLoginUserProfileModel?.user?.uniqueId ?? "");

    Database.isHost
        ? Database.onSetUserProfileImage(getHostProfileModel?.host?.image ?? "")
        : Database.onSetUserProfileImage(
            fetchLoginUserProfileModel?.user?.image ?? "");
    Database.isHost
        ? Database.onSetUserName(getHostProfileModel?.host?.name ?? "")
        : Database.onSetUserName(fetchLoginUserProfileModel?.user?.name ?? "");
    Database.isHost
        ? Database.onSetCoin(getHostProfileModel?.host?.coin ?? 0)
        : Database.onSetCoin(fetchLoginUserProfileModel?.user?.coin ?? 0);

    Utils.showLog("Database.loginUserId :: ${Database.loginUserId}");
    Utils.showLog("Database.loginType :: ${Database.loginType}");
    Utils.showLog("Database.isVip :: ${Database.isVip}");
    Utils.showLog("Database.impression :: ${Database.impression}");
    Utils.showLog("Database.email :: ${Database.email}");
    Utils.showLog("Database.profileImage :: ${Database.profileImage}");
    Utils.showLog("Database.userName :: ${Database.userName}");
    Utils.showLog("Database.coin :: ${Database.coin}");

    Get.back();
    Database.onSetProfile(true);

    Database.isHost
        ? Get.offAllNamed(AppRoutes.hostBottomBar)
        : Get.offAllNamed(AppRoutes.bottomBar);
  }
}
