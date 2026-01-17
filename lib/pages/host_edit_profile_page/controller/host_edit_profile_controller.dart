import 'dart:convert';
import 'dart:developer';

import 'package:figgy/common/loading_widget.dart';
import 'package:figgy/custom/bottom_sheet/image_picker_bottom_sheet.dart';
import 'package:figgy/custom/country_picker.dart';
import 'package:figgy/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:figgy/custom/custom_image_piker.dart';
import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/host_detail_page/api/get_host_profile_api.dart';
import 'package:figgy/pages/host_detail_page/model/get_user_profile_model.dart';
import 'package:figgy/pages/host_edit_profile_page/api/host_edit_profile.dart';
import 'package:figgy/pages/host_edit_profile_page/model/host_edit_profile_model.dart';
import 'package:figgy/pages/host_request_page/api/fetch_impression_api.dart';
import 'package:figgy/pages/host_request_page/model/fetch_impression_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class HostEditProfileController extends GetxController {
  HostEditProfileModel? hostEditProfileModel;
  GetHostProfileModel? getHostProfileModel;

  DatePickerController datePickerController = Get.put(DatePickerController());
  String? flag = "";
  bool isMale = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController bioDetailsController = TextEditingController();
  TextEditingController randomCallRateForMaleController = TextEditingController();
  TextEditingController randomCallRateForFeMaleController = TextEditingController();
  TextEditingController randomCallRateForBothController = TextEditingController();
  TextEditingController privetCallRateController = TextEditingController();
  TextEditingController audioCallRateController = TextEditingController();
  TextEditingController chatRateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController flagController = TextEditingController();

  //******************** Impression
  List<dynamic> selectedCategories = [];
  List<String> categories = [];
  FetchImpressionModel? fetchImpressionModel;

  //******************** Language
  TextEditingController languageSearchController = TextEditingController();
  List<String> allLanguages = [];
  List<String> filteredLanguages = [];
  List<String> selectedLanguages = [];
  Map<String, dynamic> allLanguageData = {};

  //******************** Profile image
  String profileImage = "";
  String hostProfileImage = "";
  String pickImages = "";

  //******************* Images
  List img = Database.hostAllImage;
  List<String?> images = [];
  String? imagePath;

  List<String> localImages = [];

  bool isLoading = false;

  //******************* Profile Video
  List<String> thumbnails = [];
  List<String> videoUrls = [];
  List<String> newLocalVideos = [];
  Map<int, String> serverVideosWithIndex = {};
  List<int> removedImageIndexes = [];
  List<int> removedVideoIndexes = [];
  final ImagePicker imagePicker = ImagePicker();

  @override
  Future<void> onInit() async {
    onInitData();

    super.onInit();
  }

  onInitData() async {
    isLoading = true;
    update();

    flag = getFlagEmoji(Database.countryCode);
    flagController.text = flag ?? "";
    countryController.text = Database.country;

    getHostProfileModel = await GetHostProfileApi.callApi(hostId: Database.hostId);

    getHostData();
    allLanguage();
    await getImpression();

    generateAllThumbnails();

    isLoading = false;
    update();
  }

  getHostData() {
    nameController.text = getHostProfileModel?.host?.name ?? "";
    emailController.text = getHostProfileModel?.host?.email ?? "";
    dateOfBirthController.text = getHostProfileModel?.host?.dob ?? "";
    bioDetailsController.text = getHostProfileModel?.host?.bio ?? "";
    countryController.text = getHostProfileModel?.host?.country ?? "";
    flagController.text = getHostProfileModel?.host?.countryFlagImage ?? "";
    randomCallRateForMaleController.text = getHostProfileModel?.host?.randomCallMaleRate.toString() ?? "";
    randomCallRateForFeMaleController.text = getHostProfileModel?.host?.randomCallFemaleRate.toString() ?? "";
    randomCallRateForBothController.text = getHostProfileModel?.host?.randomCallRate.toString() ?? "";
    privetCallRateController.text = getHostProfileModel?.host?.privateCallRate.toString() ?? "";
    audioCallRateController.text = getHostProfileModel?.host?.audioCallRate.toString() ?? "";
    chatRateController.text = getHostProfileModel?.host?.chatRate.toString() ?? "";
    selectedCategories = (getHostProfileModel?.host?.impression ?? []).where((e) => e.toString().trim().isNotEmpty).toList();
    selectedLanguages = getHostProfileModel?.host?.language ?? [];
    profileImage = getHostProfileModel?.host?.image ?? "";
    serverVideosWithIndex.clear();
    for (int i = 0; i < (getHostProfileModel?.host?.profileVideo?.length ?? 0); i++) {
      final url = getHostProfileModel?.host?.profileVideo?[i];
      if (url != null && url.trim().isNotEmpty) {
        serverVideosWithIndex[i] = url;
      }
    }
    videoUrls = serverVideosWithIndex.values.toList();

    isMale = getHostProfileModel?.host?.gender?.toLowerCase() == "male" ? true : false;
    datePickerController.selectedDateString = getHostProfileModel?.host?.dob ?? "";

    images = List.generate(3, (index) => null);

    for (int i = 0; i < (getHostProfileModel?.host?.photoGallery?.length ?? 0); i++) {
      final photoPath = getHostProfileModel?.host?.photoGallery?[i] ?? '';
      images[i] = getFullImageUrl(photoPath);
    }

    update([AppConstant.onChangeGender, AppConstant.idChangeCountry, AppConstant.idShowThumbnail]);
    datePickerController.update([AppConstant.idUpdateDate]);
  }

  //******************** Impression
  void toggleSelectionCategories(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    log("selectedCategories: $selectedCategories");
    update([AppConstant.idSelectedCategories]);
  }

  Future<void> getImpression() async {
    fetchImpressionModel = await FetchImpressionApi.callApi();

    if (fetchImpressionModel != null) {
      categories = fetchImpressionModel!.personalityImpressions.map((e) => e.name).toList();
    } else {
      categories = [];
    }

    update([AppConstant.idSelectedCategories]);
  }

  //******************** Profile image
  Future<void> onProfileImage(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await ImagePickerBottomSheetUi.show(
      context: context,
      onClickCamera: () async => _pickImage(ImageSource.camera),
      onClickGallery: () async => _pickImage(ImageSource.gallery),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final imagePath = await CustomImagePicker.pickImage(source);
    if (imagePath != null) {
      pickImages = imagePath;
      update();
    }
  }

  //******************** Language
  Future allLanguage() async {
    final String response = await rootBundle.loadString(AppAsset.getAllLanguage);
    allLanguageData = jsonDecode(response);
    log("AllLanguage: $allLanguageData");

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

  //******************** Country
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

  String getFlagEmoji(String countryCode) {
    return countryCode.toUpperCase().runes.map((code) => String.fromCharCode(code + 127397)).join();
  }

  //******************** Gender
  void onChangeGender(bool isMale) {
    this.isMale = isMale;
    log(this.isMale.toString());

    update([AppConstant.onChangeGender]);
  }

  //******************** Images
  String getFullImageUrl(String? path) {
    log("getFullImageUrl: $path");
    if (path == null || path.isEmpty) return '';

    if (path.startsWith('http')) {
      path = path.replaceAll('///', '/');
      path = path.replaceAll('//', '/');
      path = path.replaceFirst('http:/', 'http://');
      path = path.replaceFirst('https:/', 'https://');
      return path;
    }

    path = path.replaceAll('\\', '/');

    if (!path.startsWith('/')) {
      path = '/$path';
    }

    String fullPath = Api.baseUrl + path;
    fullPath = fullPath.replaceAll('///', '/');
    fullPath = fullPath.replaceAll('//', '/');
    fullPath = fullPath.replaceFirst('http:/', 'http://');
    fullPath = fullPath.replaceFirst('https:/', 'https://');

    return fullPath;
  }

  Future<void> onHostPickImage(int index, BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await ImagePickerBottomSheetUi.show(
      context: context,
      onClickCamera: () async {
        final pickedImagePath = await CustomImagePicker.pickImage(ImageSource.camera);
        if (pickedImagePath != null) {
          images[index] = pickedImagePath;
          update();
        }
      },
      onClickGallery: () async {
        final pickedImagePath = await CustomImagePicker.pickImage(ImageSource.gallery);
        if (pickedImagePath != null) {
          images[index] = pickedImagePath;
          update();
        }
      },
    );
  }

  void onCancelProfileImage({required int index}) {
    if (index < 0 || index >= images.length) return;

    removedImageIndexes.add(index);

    images.removeAt(index);
    images.add(null);

    update();
  }

  bool isNetworkImage(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }

  Future<List<String>> buildLocalGalleryList() async {
    final List<String> localPaths = [];

    for (final img in images) {
      if (img == null || img.isEmpty) continue;

      if (!isNetworkImage(img)) {
        localPaths.add(img);
      }
    }

    return localPaths;
  }

  Future<void> generateAllThumbnails() async {
    thumbnails.clear();

    for (var url in videoUrls) {
      final full = "${Api.baseUrl}$url";
      final thumb = await generateThumbnail(full, isNetwork: true);
      thumbnails.add(thumb ?? "");
    }

    for (var path in newLocalVideos) {
      final thumb = await generateThumbnail(path, isNetwork: false);
      thumbnails.add(thumb ?? "");
    }

    update([AppConstant.idShowThumbnail]);
  }

  Future<String?> generateThumbnail(String videoPathOrUrl, {required bool isNetwork}) async {
    final tempDir = await getTemporaryDirectory();
    return await VideoThumbnail.thumbnailFile(
      video: videoPathOrUrl,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 400,
      quality: 75,
    );
  }

  Future<void> pickMultipleVideos() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: true,
      );

      if (result != null) {
        List<String> paths = result.paths.whereType<String>().toList();
        for (var path in paths) {
          await addLocalVideo(path);
        }
      } else {
        Utils.showToast("No video selected");
      }
    } catch (e) {
      Utils.showToast("Error picking videos: $e");
      Utils.showLog("Error picking videos: $e");
    }
  }

  Future<void> onAddVideoSheet(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await ImagePickerBottomSheetUi.show(
      context: context,
      mainTitle: EnumLocale.txtChooseVideo.name.tr,
      title: EnumLocale.txtTakeVideo.name.tr,
      onClickCamera: () async {
        final XFile? video = await imagePicker.pickVideo(source: ImageSource.camera);
        if (video != null) {
          await addLocalVideo(video.path);
        }
        update([AppConstant.idShowThumbnail]);
      },
      onClickGallery: () async {
        await pickMultipleVideos();

        update([AppConstant.idShowThumbnail]);
      },
    );
  }

  Future<void> addLocalVideo(String path) async {
    newLocalVideos.add(path);

    final tempDir = await getTemporaryDirectory();
    final thumbPath = await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 400,
      quality: 75,
    );

    thumbnails.add(thumbPath ?? "");
  }

  Future<void> onReplaceVideo(int index, {required bool isServer}) async {
    final picker = ImagePicker();
    final XFile? vid = await picker.pickVideo(source: ImageSource.gallery);
    if (vid == null) return;

    if (isServer) {
      final originalIndex = serverVideosWithIndex.keys.elementAt(index);
      removedVideoIndexes.add(originalIndex);

      serverVideosWithIndex.remove(originalIndex);
      videoUrls.removeAt(index);
    } else {
      final localIdx = index - videoUrls.length;
      if (localIdx >= 0 && localIdx < newLocalVideos.length) {
        newLocalVideos.removeAt(localIdx);
      }
      thumbnails.removeAt(index);
    }

    newLocalVideos.add(vid.path);
    final thumb = await generateThumbnail(vid.path, isNetwork: false);
    thumbnails.insert(index, thumb ?? "");
    update([AppConstant.idShowThumbnail]);
  }

  void onDeleteVideo(int index, {required bool isServer}) {
    if (isServer) {
      final originalIndex = serverVideosWithIndex.keys.elementAt(index);
      removedVideoIndexes.add(originalIndex);

      serverVideosWithIndex.remove(originalIndex);
      videoUrls.removeAt(index);
    } else {
      final localIdx = index - videoUrls.length;
      if (localIdx >= 0 && localIdx < newLocalVideos.length) {
        newLocalVideos.removeAt(localIdx);
      }
    }
    thumbnails.removeAt(index);
    update([AppConstant.idShowThumbnail]);
  }

  Future<void> onSaveProfile() async {
    Utils.showLog("Click On Save Profile => ${Database.loginUserId}");
    Utils.showLog("Click On Save Profile => ${datePickerController.date}");

    if (profileImage.isEmpty && pickImages.isEmpty == true) {
      Utils.showToast("Please select a profile image.");
      return;
    }

    if (nameController.text.trim().isEmpty) {
      Utils.showToast("Please enter your full name.");
      return;
    }

    final selectedImageCount = images.where((element) => element != null && element.toString().isNotEmpty).length;

    if (selectedImageCount < 3) {
      Utils.showToast("Please select minimum 3 images.");
      return;
    }

    final totalVideoCount = videoUrls.length + newLocalVideos.length;
    if (totalVideoCount < 1) {
      Utils.showToast("Please add at least 1 profile video.");
      return;
    }

    try {
      Get.dialog(
        const PopScope(canPop: false, child: LoadingWidget()),
        barrierDismissible: false,
      );

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      final localImages = await buildLocalGalleryList();

      log("📸 Local File Images Only --> $localImages");

      hostEditProfileModel = await HostEditProfileApi.callApi(
        token: token ?? "",
        uid: uid ?? "",
        name: nameController.text,
        country: countryController.text,
        bio: bioDetailsController.text,
        countryFlagImage: flagController.text,
        randomCallRate: randomCallRateForBothController.text,
        randomCallFemaleRate: randomCallRateForFeMaleController.text,
        randomCallMaleRate: randomCallRateForMaleController.text,
        privateCallRate: privetCallRateController.text,
        audioCallRate: audioCallRateController.text,
        chatRate: chatRateController.text,
        gender: isMale == true ? "male" : "female",
        dob: datePickerController.date,
        impression: selectedCategories,
        language: selectedLanguages,
        photoGallery: localImages,
        image: pickImages,
        newProfileVideoPaths: newLocalVideos,
        removeProfileVideoIndex: removedVideoIndexes,
        removePhotoGalleryIndex: removedImageIndexes,
      );
      Get.back();

      if (hostEditProfileModel?.status == true) {
        Utils.showToast(hostEditProfileModel?.message ?? "");
        update();
        Get.back();
      } else {
        Utils.showToast(hostEditProfileModel?.message ?? "");
      }
    } catch (e) {
      Get.back();
      Utils.showLog("Error updating profile: $e");
      Utils.showToast("Failed to update profile. Please check your internet connection.");
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }

  //******************** Update profile
  Future<void> onSaveProfileWhenCallRate() async {
    Utils.showLog("Click On Save Profile => ${Database.loginUserId}");

    if (profileImage.isEmpty && pickImages.isEmpty == true) {
      Utils.showToast("Please select a profile image.");
      return;
    }

    if (nameController.text.trim().isEmpty) {
      Utils.showToast("Please enter your full name.");
      return;
    }

    final selectedImageCount = images.where((element) => element != null && element.toString().isNotEmpty).length;

    if (selectedImageCount < 3) {
      Utils.showToast("Please select minimum 3 images.");
      return;
    }

    final totalVideoCount = videoUrls.length + newLocalVideos.length;
    if (totalVideoCount < 1) {
      Utils.showToast("Please add at least 1 profile video.");
      return;
    }

    try {
      Get.dialog(
        const PopScope(canPop: false, child: LoadingWidget()),
        barrierDismissible: false,
      );

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      final localImages = await buildLocalGalleryList();

      log("📸 Local File Images Only --> $localImages");
      log("📸 Local File Images Only --> ${datePickerController.date}");

      hostEditProfileModel = await HostEditProfileApi.callApi(
        token: token ?? "",
        uid: uid ?? "",
        name: nameController.text,
        country: countryController.text,
        bio: bioDetailsController.text,
        countryFlagImage: flagController.text,
        randomCallRate: randomCallRateForBothController.text,
        randomCallFemaleRate: randomCallRateForFeMaleController.text,
        randomCallMaleRate: randomCallRateForMaleController.text,
        privateCallRate: privetCallRateController.text,
        audioCallRate: audioCallRateController.text,
        chatRate: chatRateController.text,
        gender: isMale == true ? "male" : "female",
        dob: datePickerController.date,
        impression: selectedCategories,
        language: selectedLanguages,
        photoGallery: localImages,
        image: pickImages,
        newProfileVideoPaths: newLocalVideos,
        removeProfileVideoIndex: removedVideoIndexes,
        removePhotoGalleryIndex: removedImageIndexes,
      );
      Get.back();

      if (hostEditProfileModel?.status == true) {
        Utils.showToast(hostEditProfileModel?.message ?? "");
        update();
        Get.back();
        Get.back();
      } else {
        Utils.showToast(hostEditProfileModel?.message ?? "");
      }
    } catch (e) {
      Get.back();
      Utils.showLog("Error updating profile: $e");
      Utils.showToast("Failed to update profile. Please check your internet connection.");
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }
}
