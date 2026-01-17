import 'dart:developer';

import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/chat_page/model/usre_block_host_api.dart';
import 'package:figgy/pages/host_detail_page/api/follow_unfollow_api.dart';
import 'package:figgy/pages/host_detail_page/api/host_detail_api.dart';
import 'package:figgy/pages/host_detail_page/model/follow_unfollow_model.dart';
import 'package:figgy/pages/host_detail_page/model/host_detail_model.dart';
import 'package:figgy/pages/host_detail_page/widget/user_photos_widget.dart';
import 'package:figgy/pages/vip_page/api/vip_plan_privilege_api.dart';
import 'package:figgy/pages/vip_page/model/vip_plan_privilege_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/internet_connection.dart';
import 'package:figgy/utils/utils.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class HostDetailController extends GetxController {
  Map<String, dynamic> argumentsList = Get.arguments;
  String? isOnline;

  static FollowFollowingModel? followFollowModel;

  HostDetailModel? hostDetailModel;

  List<dynamic>? photoGallery;
  List<ReceivedGift> receivedGifts = [];

  List<String> impression = [];

  List<String> language = [];

  bool isLoading = false;
  bool isFollow = false;
  int? currentIndex = 0;

  UserBlockHostApiModel? userBlockHostApiModel;

  List<String> thumbnails = [];
  List<String> videoUrls = [];

  List<MediaItem> mixedMedia = [];

  @override
  void onInit() async {
    isOnline = argumentsList["isOnline"];

    log("isOnline: $isOnline");
    log("hostId: ${argumentsList["isOnline"]}");
    await getHostProfileApi();
    await getVipPrivilege();

    prepareMixedMedia();
    await generateAllThumbnails();

    super.onInit();
  }

  VipPlanPrivilegeModel? vipPlanPrivilegeModel;
  String? frameBadge;
  bool frameLoading = false;
  int? videoCallDiscount = 0;
  num? finalCallRate;

  Future<void> getVipPrivilege() async {
    frameLoading = true;
    vipPlanPrivilegeModel = await VipPlanPrivilegeApi.callApi();

    frameBadge = vipPlanPrivilegeModel?.data?.vipFrameBadge ?? '';
    videoCallDiscount = vipPlanPrivilegeModel?.data?.videoCallDiscount ?? 0;

    Database.onVipFrameBadge(frameBadge ?? "");
    Database.onVipPlanPurchase(true);

    num originalRate = Database.videoPrivateCallRate;
    num rawDiscount = (originalRate * videoCallDiscount!) / 100;

    int discountAmount;
    if (rawDiscount - rawDiscount.floor() >= 0.5) {
      discountAmount = rawDiscount.ceil();
    } else {
      discountAmount = rawDiscount.floor();
    }

    finalCallRate = originalRate - discountAmount;

    frameLoading = false;
    update([AppConstant.idVipChangeTab]);
  }

  void changeTab({required int index}) {
    currentIndex = index;

    update([AppConstant.idUserBroder]);
  }

  void onFollowToggle() {
    isFollow = !isFollow;

    getFollowUnfollowApi();

    update([AppConstant.idFollowToggle]);
  }

  Future<void> getFollowUnfollowApi() async {
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    if (argumentsList["hostId"]!.isNotEmpty) {
      followFollowModel = await FollowUnfollowApi.callApi(followingId: argumentsList["hostId"] ?? "", token: token ?? "", uid: uid ?? "");
      isFollow = followFollowModel?.isFollow ?? true;
    }
    update([AppConstant.idFollowToggle]);
  }

  Future<void> getHostProfileApi() async {
    if (InternetConnection.isConnect) {
      if (argumentsList["hostId"]?.isNotEmpty ?? false) {
        isLoading = true;

        final uid = FirebaseUid.onGet();
        final token = await FirebaseAccessToken.onGet();

        hostDetailModel = await HostDetailApi.callApi(
          hostId: argumentsList["hostId"]!,
          token: token ?? "",
          uid: uid ?? "",
        );
        photoGallery = hostDetailModel?.host?.photoGallery ?? [];
        isFollow = hostDetailModel?.host?.isFollowing ?? false;
        receivedGifts = (hostDetailModel?.receivedGifts ?? []).where((gift) => (gift.giftImage?.isNotEmpty ?? false)).toList();
        impression = (hostDetailModel?.host?.impression ?? []).join(",").split(",").map((e) => e.trim()).toList();
        language = (hostDetailModel?.host?.language ?? []).join(",").split(",").map((e) => e.trim()).toList();
        videoUrls = hostDetailModel?.host?.profileVideo ?? [];

        isLoading = false;
      }
    } else {
      Utils.showToast(EnumLocale.txtPleaseCheckYourInternetConnection.name.tr);
    }

    update();
  }

  Future<void> generateAllThumbnails() async {
    for (var url in videoUrls) {
      final thumb = await generateThumbnail("${Api.baseUrl}$url");
      thumbnails.add(thumb ?? "");
      Utils.showLog("Thumbnails=============== $thumbnails");
    }
    update([AppConstant.idShowThumbnail]);
  }

  Future<String?> generateThumbnail(String videoUrl) async {
    final tempDir = await getTemporaryDirectory();
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 400,
      quality: 75,
    );
    return thumbnailPath;
  }

  void prepareMixedMedia() {
    mixedMedia.clear();

    final photos = hostDetailModel?.host?.photoGallery ?? [];
    final videos = videoUrls;

    final photoItems = photos.map((e) => MediaItem(url: e, isVideo: false)).toList();
    final videoItems = videos.map((e) => MediaItem(url: e, isVideo: true)).toList();

    final allItems = [...photoItems, ...videoItems]..shuffle();

    if (allItems.isNotEmpty && allItems.first.isVideo) {
      final firstPhotoIndex = allItems.indexWhere((e) => !e.isVideo);
      if (firstPhotoIndex != -1) {
        final firstPhoto = allItems.removeAt(firstPhotoIndex);
        allItems.insert(0, firstPhoto);
      }
    }

    mixedMedia = allItems;

    update([AppConstant.idShowThumbnail]);
  }
}
