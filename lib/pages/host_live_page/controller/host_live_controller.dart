import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/custom/dialog/block_dialog.dart';
import 'package:LoveBirds/custom/gift_bottom_sheet/gift_bottom_sheet.dart';
import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/host_detail_page/api/follow_unfollow_api.dart';
import 'package:LoveBirds/pages/host_detail_page/api/host_detail_api.dart';
import 'package:LoveBirds/pages/host_detail_page/model/follow_unfollow_model.dart';
import 'package:LoveBirds/pages/host_detail_page/model/host_detail_model.dart';
import 'package:LoveBirds/pages/host_live_stream/model/create_host_live_model.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/socket/socket_services.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/internet_connection.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostLiveController extends GetxController {
  CreateHostLive? createHostLive;
  bool isFrontCamera = false;
  bool isMicOn = true;

  String hostId = "";
  String image = "";
  String name = "";
  bool isHost = false;
  String liveHistoryId = "";

  int countTime = 0;
  bool isLivePage = false;

  // This is use to when live status check
  bool liveStatus = true;

  TextEditingController commentController = TextEditingController();

  void init() {
    SocketServices.mainLiveComments.clear();

    isHost = Get.arguments["isHost"] ?? "";
    name = Get.arguments["name"];
    image = Get.arguments["image"];
    liveHistoryId = Get.arguments["liveHistoryId"];
    hostId = Get.arguments["hostId"];
    token = Get.arguments["token"];
    channel = Get.arguments["channel"];

    Utils.showLog("Live Streaming isHost :: $isHost");
    Utils.showLog("Live Streaming name :: $name");
    Utils.showLog("Live Streaming image :: $image");
    Utils.showLog("Live Streaming liveHistoryId :: $liveHistoryId");
    Utils.showLog("Live Streaming hostId :: $hostId");
    Utils.showLog("Live Streaming token :: $token");
    Utils.showLog("Live Streaming channelId :: $channel");

    if (!Database.isHost) {
      SocketServices.onLiveStreamStatusCheck(
          liveHistoryId: liveHistoryId, hostId: hostId);
    }

    onCreateEngine();

    if (liveStatus) {
      onConnectSocketLive();
    }

    GiftBottomSheetWidget.getGiftCategoryApi();

    getHostProfileApi();
  }

  void onDispose() {
    isLivePage = false;
    engine?.leaveChannel();
    engine?.release();
    engine = null;
    onDisConnectSocketLive();
  }

  //================= Agora Method =================//

  RtcEngine? engine;
  int? remoteId;
  String token = "";
  String channel = "";

  Future<void> onCreateEngine() async {
    try {
      if (engine == null) {
        engine = createAgoraRtcEngine();
        await engine?.initialize(
          RtcEngineContext(
            appId: Database.agoraAppId,
            channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
          ),
        );
        Utils.showLog("Agora Create Engine Success");
        onJoinChannel();
        // onAutoExit();
      }
    } catch (e) {
      Utils.showLog("Agora Create Engine Failed => $e");
    }
  }

  Future<void> onJoinChannel() async {
    await onEvenHandler();

    await engine?.joinChannel(
      uid: 0,
      token: token,
      channelId: channel,
      options: ChannelMediaOptions(
        clientRoleType: isHost
            ? ClientRoleType.clientRoleBroadcaster
            : ClientRoleType.clientRoleAudience,
      ),
    );

    await engine?.enableVideo();

    if (isHost) {
      await engine?.startPreview();
      Utils.showLog("Live Streaming => Start Preview");
    }

    update([AppConstant.onCreateEngine]);
  }

  Future<void> onEvenHandler() async {
    engine?.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          Utils.showLog("Live Streaming => Join Channel Success");
          if (engine != null && isHost) {
            onChangeTime();
          }
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          Utils.showLog("Live Streaming => User Join Channel Success");
          remoteId = remoteUid;
          update([AppConstant.onCreateEngine]);
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) async {
          Utils.showLog("Live Streaming => User Leave Channel Success");

          await 500.milliseconds.delay();
          Get.toNamed(
            AppRoutes.liveEndPage,
            arguments: {
              "hostName": name,
              "hostImage": image,
            },
          );
        },
        onError: (e, message) {
          Utils.showLog("Live Streaming => Join Channel Failed => $e");
        },
        onLeaveChannel: (connection, stats) {
          Utils.showLog("Live Streaming => On Leave Channel => $connection");
          Utils.showLog("Live Streaming => On Leave Channel => $stats");
        },
      ),
    );
  }

  void onAutoExit() async {
    Timer(
      const Duration(seconds: 5),
      () {
        if (isHost == false &&
            remoteId == null &&
            Get.currentRoute == AppRoutes.hostLivePage) {
          Get.back();
        }
      },
    );
  }

  void onConnectSocketLive() {
    if (isHost) {
      SocketServices.userWatchCount.value = 0;
      SocketServices.userChats.clear();

      SocketServices.onLiveRoomConnect(liveHistoryId: liveHistoryId);
    } else {
      SocketServices.userChats.clear();
      SocketServices.onAddView(
          liveHistoryId: liveHistoryId, userId: Database.loginUserId);
    }
  }

  void onDisConnectSocketLive() {
    SocketServices.onLiveRoomExit(
        isHost: isHost, liveHistoryId: liveHistoryId, hostId: hostId);
  }

  Future<void> onSwitchMic() async {
    if (isMicOn) {
      isMicOn = false;
      update([AppConstant.idSwitchMic]);
      await engine?.muteLocalAudioStream(true);
    } else {
      isMicOn = true;
      update([AppConstant.idSwitchMic]);
      await engine?.muteLocalAudioStream(false);
    }
  }

  Future<void> onSwitchCamera() async {
    Get.dialog(const LoadingWidget(),
        barrierDismissible: false); // Start Loading...
    await engine?.switchCamera();
    Get.back(); // Stop Loading...
  }

  Future<void> onSendComment() async {
    if (commentController.text.trim().isNotEmpty) {
      SocketServices.onComment(
        liveHistoryId: Get.arguments["liveHistoryId"],
        loginUserId: Database.loginUserId,
        userName: Database.userName,
        userImage: Database.profileImage,
        commentText: commentController.text,
        hostId: hostId,
      );
      commentController.clear();
    }
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
        svgaThumbUrl: GiftBottomSheetWidget.giftsvgaImage,
      );
    } else {
      Utils.showToast(EnumLocale.txtYouHaveInsufficientCoins.name.tr);
    }

    Get.back();
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

  HostDetailModel? hostDetailModel;
  bool isFollow = false;
  List<dynamic>? photoGallery;
  List? receivedGifts;
  static FollowFollowingModel? followFollowModel;

  List<String> language = [];
  List<String> impression = [];

  Future<void> getHostProfileApi() async {
    if (InternetConnection.isConnect) {
      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      hostDetailModel = await HostDetailApi.callApi(
        hostId: hostId,
        token: token ?? "",
        uid: uid ?? "",
      );
      photoGallery = hostDetailModel?.host?.photoGallery ?? [];
      receivedGifts = hostDetailModel?.receivedGifts ?? [];
      isFollow = hostDetailModel?.host?.isFollowing ?? false;

      impression = (hostDetailModel?.host?.impression ?? [])
          .join(",")
          .split(",")
          .map((e) => e.trim())
          .toList();
      language = (hostDetailModel?.host?.language ?? [])
          .join(",")
          .split(",")
          .map((e) => e.trim())
          .toList();

      log("photoGallery: $photoGallery");
    } else {
      Utils.showToast(EnumLocale.txtPleaseCheckYourInternetConnection.name.tr);
    }

    update();
  }

  void onFollowToggle() {
    isFollow = !isFollow;

    getFollowUnfollowApi();

    update([AppConstant.idFollowToggle]);
  }

  Future<void> getFollowUnfollowApi() async {
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    followFollowModel = await FollowUnfollowApi.callApi(
        followingId: hostId, token: token ?? "", uid: uid ?? "");
    isFollow = followFollowModel?.isFollow ?? true;

    update([AppConstant.idFollowToggle]);
  }

  //**************** Block
  void getBlock({required BuildContext context}) async {
    Utils.showLog("hostDetailModel?.host?.id${hostId}");
    Utils.showLog("Database.loginUserId${Database.loginUserId}");

    Get.dialog(
      barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
      Dialog(
        backgroundColor: AppColors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        child: BlockDialog(
          hostId: hostId,
          isHost: false,
          userId: Database.loginUserId,
          // isVideoCall: true,
          isLive: true,
        ),
      ),
    );
  }
}
