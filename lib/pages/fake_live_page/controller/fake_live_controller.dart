import 'dart:async';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:LoveBirds/custom/gift_bottom_sheet/gift_bottom_sheet.dart';
import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/fake_live_page/widget/fake_comment_data.dart';
import 'package:LoveBirds/pages/login_page/api/fetch_login_user_profile_api.dart';
import 'package:LoveBirds/socket/socket_services.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FakeLiveController extends GetxController {
  bool isFrontCamera = false;
  bool isFlashOn = false;
  bool isMicOn = true;
  Timer? time;

  String userId = "";
  String image = "";
  String name = "";
  String userName = "";
  bool isFollow = false;
  String videoUrl = "";
  int countTime = 0;
  bool isLivePage = false;

  String liveHistoryId = "";
  String hostId = "";

  ScrollController scrollController = ScrollController();
  TextEditingController commentController = TextEditingController();

  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;
  bool isVideoLoading = true;

  @override
  void onInit() {
    addFakeComment();
    onChangeTime();

    GiftBottomSheetWidget.getGiftCategoryApi();
    super.onInit();
  }

  addFakeComment() {
    log("object::::initState");
    time = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      log("object::::initState");
      addItems();
    });
  }

  @override
  void onClose() {
    time?.cancel();
    scrollController.dispose();
    onDisposeVideoPlayer();
    super.onClose();
  }

  Future<void> initializeVideoPlayer() async {
    try {
      log("Video Url =>'${Api.baseUrl + videoUrl}'");
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(Api.baseUrl + videoUrl));

      await videoPlayerController?.initialize();

      if (videoPlayerController != null &&
          (videoPlayerController?.value.isInitialized ?? false)) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          looping: true,
          allowedScreenSleep: false,
          allowMuting: false,
          showControlsOnInitialize: false,
          showControls: false,
          maxScale: 1,
        );
        videoPlayerController?.play();
        update([AppConstant.initializeVideoPlayer]);
      }
    } catch (e) {
      onDisposeVideoPlayer();
      Utils.showLog("Reels Video Initialization Failed !!! => $e");
    }
  }

  void onDisposeVideoPlayer() {
    try {
      videoPlayerController?.dispose();
      chewieController?.dispose();
      chewieController = null;
      videoPlayerController = null;
    } catch (e) {
      Utils.showLog(">>>> On Dispose VideoPlayer Error => $e");
    }
  }

  void addItems() {
    fakeHostCommentList.shuffle();
    log("object::::  1${fakeHostCommentList.first.message}");

    fakeHostCommentListBlank.add(fakeHostCommentList.first);
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 50), curve: Curves.easeOut);
    update();
  }

  Future<void> onSendComment() async {
    if (commentController.text.trim().isNotEmpty) {
      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();
      CustomFetchUserCoin.fetchLoginUserProfileModel =
          await FetchLoginUserProfileApi.callApi(
        token: token ?? "",
        uid: uid ?? "",
      );

      fakeHostCommentListBlank.add(
        HostComment(
          message: commentController.text.toString(),
          user:
              CustomFetchUserCoin.fetchLoginUserProfileModel?.user?.name ?? "",
          image: (Api.baseUrl +
              (CustomFetchUserCoin.fetchLoginUserProfileModel?.user?.image ??
                  "")),
        ),
      );
    }
    commentController.clear();
  }

  void onChangeTime() {
    isLivePage = true;

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (isLivePage) {
          countTime++;
          Utils.showLog(
              "Live Streaming Time => ${onConvertSecondToHMS(countTime)}");
          update([AppConstant.onChangeTime]);
        } else {
          timer.cancel();
          countTime = 0;
          update([AppConstant.onChangeTime]);
        }
      },
    );
  }

  String onConvertSecondToHMS(int totalSeconds) {
    Duration duration = Duration(seconds: totalSeconds);

    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String time = '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';

    return time;
  }

  void onSendGift() async {
    CustomFetchUserCoin.init();

    if (GiftBottomSheetWidget.giftCoin *
            GiftBottomSheetWidget.giftCount.toInt() <=
        Database.coin) {
      SocketServices.onLiveSendGift(
        liveHistoryId: liveHistoryId,
        senderUserId: Database.loginUserId,
        receiverUserId: hostId,
        giftId: GiftBottomSheetWidget.selectedGiftId,
        giftCount: GiftBottomSheetWidget.giftCount,
        giftUrl: GiftBottomSheetWidget.giftUrl,
        giftType: GiftBottomSheetWidget.giftType,
        callerName: Database.userName,
      );
    } else {
      Utils.showToast(EnumLocale.txtYouHaveInsufficientCoins.name.tr);
    }

    Get.back();
  }
}

///
// import 'dart:async';
// import 'dart:developer';
//
// import 'package:chewie/chewie.dart';
// import 'package:LoveBirds/custom/gift_bottom_sheet/gift_bottom_sheet.dart';
// import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
// import 'package:LoveBirds/firebase/firebase_access_token.dart';
// import 'package:LoveBirds/firebase/firebase_uid.dart';
// import 'package:LoveBirds/pages/fake_live_page/api/fake_live_chat_gift_api.dart';
// import 'package:LoveBirds/pages/fake_live_page/widget/fake_comment_data.dart';
// import 'package:LoveBirds/pages/login_page/api/fetch_login_user_profile_api.dart';
// import 'package:LoveBirds/utils/api.dart';
// import 'package:LoveBirds/utils/constant.dart';
// import 'package:LoveBirds/utils/database.dart';
// import 'package:LoveBirds/utils/enum.dart';
// import 'package:LoveBirds/utils/utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
//
// class FakeLiveController extends GetxController {
//   bool isFrontCamera = false;
//   bool isFlashOn = false;
//   bool isMicOn = true;
//   Timer? time;
//
//   String userId = "";
//   String image = "";
//   String name = "";
//   String userName = "";
//   bool isFollow = false;
//   String videoUrl = "";
//   int countTime = 0;
//   bool isLivePage = false;
//
//   String liveHistoryId = "";
//   String hostId = "";
//
//   ScrollController scrollController = ScrollController();
//   TextEditingController commentController = TextEditingController();
//
//   ChewieController? chewieController;
//   VideoPlayerController? videoPlayerController;
//   bool isVideoLoading = true;
//
//   @override
//   void onInit() {
//     addFakeComment();
//     onChangeTime();
//
//     GiftBottomSheetWidget.getGiftCategoryApi();
//     super.onInit();
//   }
//
//   addFakeComment() {
//     log("object::::initState");
//     time = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//       log("object::::initState");
//       addItems();
//     });
//   }
//
//   @override
//   void onClose() {
//     time?.cancel();
//     scrollController.dispose();
//     onDisposeVideoPlayer();
//     super.onClose();
//   }
//
//   Future<void> initializeVideoPlayer() async {
//     try {
//       log("Video Url =>'${Api.baseUrl + videoUrl}'");
//       videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(Api.baseUrl + videoUrl));
//
//       await videoPlayerController?.initialize();
//
//       if (videoPlayerController != null && (videoPlayerController?.value.isInitialized ?? false)) {
//         chewieController = ChewieController(
//           videoPlayerController: videoPlayerController!,
//           looping: true,
//           allowedScreenSleep: false,
//           allowMuting: false,
//           showControlsOnInitialize: false,
//           showControls: false,
//           maxScale: 1,
//         );
//         videoPlayerController?.play();
//         update([AppConstant.initializeVideoPlayer]);
//       }
//     } catch (e) {
//       onDisposeVideoPlayer();
//       Utils.showLog("Reels Video Initialization Failed !!! => $e");
//     }
//   }
//
//   void onDisposeVideoPlayer() {
//     try {
//       videoPlayerController?.dispose();
//       chewieController?.dispose();
//       chewieController = null;
//       videoPlayerController = null;
//     } catch (e) {
//       Utils.showLog(">>>> On Dispose VideoPlayer Error => $e");
//     }
//   }
//
//   void addItems() {
//     fakeHostCommentList.shuffle();
//     log("object::::  1${fakeHostCommentList.first.message}");
//
//     fakeHostCommentListBlank.add(fakeHostCommentList.first);
//
//     // Check if scroll controller is attached to any scroll view before animating
//     if (scrollController.positions.isNotEmpty) {
//       scrollController.animateTo(
//         scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 50),
//         curve: Curves.easeOut,
//       );
//     }
//
//     update();
//   }
//
//   Future<void> onSendComment() async {
//     if (commentController.text.trim().isNotEmpty) {
//       final uid = FirebaseUid.onGet();
//       final token = await FirebaseAccessToken.onGet();
//       CustomFetchUserCoin.fetchLoginUserProfileModel = await FetchLoginUserProfileApi.callApi(
//         token: token ?? "",
//         uid: uid ?? "",
//       );
//
//       fakeHostCommentListBlank.add(
//         HostComment(
//           message: commentController.text.toString(),
//           user: CustomFetchUserCoin.fetchLoginUserProfileModel?.user?.name ?? "",
//           image: (Api.baseUrl + (CustomFetchUserCoin.fetchLoginUserProfileModel?.user?.image ?? "")),
//         ),
//       );
//     }
//     commentController.clear();
//   }
//
//   void onChangeTime() {
//     isLivePage = true;
//
//     Timer.periodic(
//       const Duration(seconds: 1),
//           (timer) {
//         if (isLivePage) {
//           countTime++;
//           Utils.showLog("Live Streaming Time => ${onConvertSecondToHMS(countTime)}");
//           update([AppConstant.onChangeTime]);
//         } else {
//           timer.cancel();
//           countTime = 0;
//           update([AppConstant.onChangeTime]);
//         }
//       },
//     );
//   }
//
//   String onConvertSecondToHMS(int totalSeconds) {
//     Duration duration = Duration(seconds: totalSeconds);
//
//     int hours = duration.inHours;
//     int minutes = duration.inMinutes.remainder(60);
//     int seconds = duration.inSeconds.remainder(60);
//
//     String time = '${hours.toString().padLeft(2, '0')}:'
//         '${minutes.toString().padLeft(2, '0')}:'
//         '${seconds.toString().padLeft(2, '0')}';
//
//     return time;
//   }
//
//   void onSendGiftViaApi() async {
//     // Check if user has enough coins
//     if (GiftBottomSheetWidget.giftCoin * GiftBottomSheetWidget.giftCount.toInt() <= Database.coin) {
//       // Get authentication details
//       final uid = FirebaseUid.onGet();
//       final token = await FirebaseAccessToken.onGet();
//
//       if (uid != null && token != null) {
//         // Log gift details for debugging
//         Utils.showLog("Fake Live Gift API - SenderID: ${Database.loginUserId}, HostID: $hostId, GiftID: ${GiftBottomSheetWidget.selectedGiftId}");
//
//         // Call the API
//         await FakeLiveChatGiftApi.callApi(
//           token: token,
//           uid: uid,
//           senderId: Database.loginUserId,
//           receiverId: hostId,
//           giftId: GiftBottomSheetWidget.selectedGiftId,
//           type: 'liveGift',
//           giftCount: GiftBottomSheetWidget.giftCount.toString(),
//         );
//       } else {
//         Utils.showLog("Error: Missing authentication details");
//       }
//     } else {
//       Utils.showToast(EnumLocale.txtYouHaveInsufficientCoins.name.tr);
//     }
//
//     Get.back();
//   }
// }
