import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:figgy/custom/bottom_sheet/image_picker_bottom_sheet.dart';
import 'package:figgy/custom/custom_image_piker.dart';
import 'package:figgy/custom/dialog/block_dialog.dart';
import 'package:figgy/custom/gift_bottom_sheet/gift_bottom_sheet.dart';
import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/chat_page/api/fetch_chat_history_from_host_api.dart';
import 'package:figgy/pages/chat_page/api/fetch_chat_history_from_user_api.dart';
import 'package:figgy/pages/chat_page/api/send_file_api_host.dart';
import 'package:figgy/pages/chat_page/api/send_file_api_user.dart';
import 'package:figgy/pages/chat_page/model/fetch_chat_history_from_host_model.dart';
import 'package:figgy/pages/chat_page/model/fetch_chat_history_from_user_model.dart';
import 'package:figgy/pages/chat_page/model/get_socket_data_model.dart';
import 'package:figgy/pages/chat_page/model/host_send_file_api_model.dart';
import 'package:figgy/pages/chat_page/model/user_send_file_api_model.dart';
import 'package:figgy/pages/host_detail_page/api/host_detail_api.dart';
import 'package:figgy/pages/host_detail_page/model/host_detail_model.dart';
import 'package:figgy/pages/host_live_streamers_page/controller/host_live_streamers_controller.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/socket/socket_emit.dart';
import 'package:figgy/socket/socket_services.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/internet_connection.dart';
import 'package:figgy/utils/socket_params.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class ChatController extends GetxController {
  TextEditingController messageController = TextEditingController();
  HostLiveStreamersController controller = HostLiveStreamersController();

  bool isPaginating = false;
  bool isLoadingHost = false;
  bool isLoadingUser = false;

  ScrollController scrollController = ScrollController();

  String? image;
  bool isRecordingAudio = false;
  bool isLoadingAudio = false;
  AudioRecorder audioRecorder = AudioRecorder();
  bool isSendingAudioFile = false;

  bool isLoadingImage = false;

  Timer? timer;
  int countTime = 0;
  List<GetSocketDataModel> giftData = <GetSocketDataModel>[];
  GetSocketDataModel? getSocketDataModel;

  final Set<String> svgaShouldAutoPlayOnce = {};
  final Set<String> svgaPlayedOnce = {};
  String? svgaCurrentlyPlayingId;
  final List<String> svgaPending = [];
  Timer? svgaPlayGuard;

  String receiverId = Get.arguments["receiverId"] ?? ""; /* User Id from Host */
  String hostId = Get.arguments["hostId"] ?? ""; /* host Id from User */
  String hostName = Get.arguments["hostName"] ?? "";
  String profileImage = Get.arguments["profileImage"] ?? "";
  bool isOnline = Get.arguments["isOnline"] ?? false;
  bool isChatHostDetail = Get.arguments["isChatHostDetail"] ?? false;

  UserSendFileApiModel? userSendFileApiModel;
  HostSendFileApiModel? hostSendFileApiModel;

  List<UserChat> userChats = <UserChat>[];
  List<HostChat> hostChats = <HostChat>[];

  FetchChatHistoryFromHostModel? fetchChatHistoryFromHostModel;
  FetchChatHistoryFromUserModel? fetchChatHistoryFromUserModel;

  String get chatTopicId => Database.isHost ? fetchChatHistoryFromHostModel?.chatTopic ?? "" : fetchChatHistoryFromUserModel?.chatTopic ?? "";

  HostDetailModel? hostDetailModel;

  List dummyChat = [
    "🔥 Hey you!",
    "🥰 Missing’ you.",
    "🌹 You there?",
    "😜 Let’s chat.",
    "💬 What’s up?",
  ];

  @override
  void onInit() {
    scrollController.addListener(onPagination);

    Database.isHost ? hostChats.clear() : userChats.clear();

    Database.isHost ? FetchChatHistoryFromHostApi.startPagination = 0 : FetchChatHistoryFromUserApi.startUserPagination = 0;

    Database.isHost ? getHostChatHistory(isPagination: false) : getUserChatHistory(isPagination: false);

    GiftBottomSheetWidget.getGiftCategoryApi();

    getHostProfileApi();
    svgaCurrentlyPlayingId = null;
    svgaPending.clear();
    svgaShouldAutoPlayOnce.clear();
    svgaPlayedOnce.clear();

    super.onInit();
  }

  @override
  Future<void> onClose() async {
    if (SocketServices.isMessageSeenEvent.value == true) {
      if (Database.isHost) {
        await getHostChatHistory(isPagination: false);
      } else {
        await getUserChatHistory(isPagination: false);
      }
    }

    messageController.dispose();
    svgaCurrentlyPlayingId = null;
    svgaPending.clear();
    svgaShouldAutoPlayOnce.clear();
    super.onClose();
  }

  bool shouldAutoPlayFor(String id) => svgaShouldAutoPlayOnce.contains(id) && !svgaPlayedOnce.contains(id);

  Future<bool> onTryStartManualPlay(String id) async {
    if (svgaCurrentlyPlayingId == null) {
      return true;
    }
    if (svgaCurrentlyPlayingId == id) return true;
    Utils.showToast("Only one animation can play at a time.");
    return false;
  }

  void onManualReplayStart(String id) {
    svgaCurrentlyPlayingId = id;
    svgaPlayGuard?.cancel();
    svgaPlayGuard = Timer(const Duration(seconds: 8), () {
      if (svgaCurrentlyPlayingId == id) {
        svgaCurrentlyPlayingId = null;
        update([AppConstant.onChatList]);
      }
    });
    update([AppConstant.onChatList]);
  }

  void onGiftMessageInserted(String id) {
    if (svgaPlayedOnce.contains(id)) return;

    if (svgaCurrentlyPlayingId == null) {
      svgaCurrentlyPlayingId = id;
      svgaShouldAutoPlayOnce.add(id);

      svgaPlayGuard?.cancel();
      svgaPlayGuard = Timer(const Duration(seconds: 10), () {
        if (svgaCurrentlyPlayingId == id && !svgaPlayedOnce.contains(id)) {
          svgaCurrentlyPlayingId = null;
          update([AppConstant.onChatList]);
        }
      });
    } else {
      svgaPending.add(id);
    }
    update([AppConstant.onChatList]);
  }

  void markAutoPlayConsumed(String id) {
    svgaPlayedOnce.add(id);
    svgaShouldAutoPlayOnce.remove(id);

    if (svgaCurrentlyPlayingId == id) {
      if (svgaPending.isNotEmpty) {
        final next = svgaPending.removeAt(0);
        svgaCurrentlyPlayingId = next;
        svgaShouldAutoPlayOnce.add(next);
      } else {
        svgaCurrentlyPlayingId = null;
      }
    }
    update([AppConstant.onChatList]);
  }

  void onManualReplayFinished(String id) {
    if (svgaCurrentlyPlayingId == id) {
      svgaCurrentlyPlayingId = null;
    }
    svgaPlayGuard?.cancel();
    svgaPlayGuard = null;
    update([AppConstant.onChatList]);
  }

  void onManualReplayError(String id) {
    onManualReplayFinished(id);
  }

  void onAutoPlayFailed(String id) {
    if (svgaCurrentlyPlayingId == id) {
      svgaCurrentlyPlayingId = null;
      svgaPlayGuard?.cancel();
      svgaPlayGuard = null;
      update([AppConstant.onChatList]);
    }
  }

  Future<void> getUserChatHistory({required bool isPagination}) async {
    try {
      if (!isPagination) {
        isLoadingUser = true;
        update([AppConstant.onChatList]);
      } else {
        isPaginating = true;
        update([AppConstant.onPaginationLoader]);
      }

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      final chatHistory = await FetchChatHistoryFromUserApi.callApi(
        receiverId: hostId,
        token: token ?? "",
        uid: uid ?? "",
      );

      if (chatHistory != null) {
        fetchChatHistoryFromUserModel = chatHistory;
        userChats.addAll(fetchChatHistoryFromUserModel!.chat!);

        log("Chat history loaded for chatTopic: ${chatHistory.chatTopic}");
      } else {
        FetchChatHistoryFromUserApi.startUserPagination--;
      }
    } catch (e) {
      log("Error loading user chat history: $e");
    } finally {
      if (!isPagination) {
        isLoadingUser = false;
        update([AppConstant.onChatList]);
        await onScrollDown();
      } else {
        isPaginating = false;
        update([AppConstant.onPaginationLoader]);
      }
    }
  }

  Future<void> getHostChatHistory({required bool isPagination}) async {
    try {
      if (!isPagination) {
        isLoadingHost = true;
        update([AppConstant.onChatList]);
      } else {
        isPaginating = true;
        update([AppConstant.onPaginationLoader]);
      }

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      final chatHistory = await FetchChatHistoryFromHostApi.callApi(
        token: token ?? "",
        uid: uid ?? "",
        senderId: Database.hostId,
        receiverId: receiverId,
      );

      if (chatHistory != null) {
        fetchChatHistoryFromHostModel = chatHistory;
        hostChats.addAll(fetchChatHistoryFromHostModel?.chat ?? []);
      } else {
        FetchChatHistoryFromHostApi.startPagination--;
      }
    } catch (e) {
      log("Error loading host chat history: $e");
    } finally {
      if (!isPagination) {
        isLoadingHost = false;
        update([AppConstant.onChatList]);
        await onScrollDown();
      } else {
        isPaginating = false;
        update([AppConstant.onPaginationLoader]);
      }
    }
  }

  //**************** Message
  Future<void> onSendMessage({
    required int messageType,
    required String message,
    required String senderRole,
    required String receiverRole,
    String? messageId,
  }) async {
    if (chatTopicId.isNotEmpty) {
      SocketEmit.onSendMessage(
        chatTopicId: chatTopicId,
        messageType: messageType,
        messageId: messageId ?? "",
        receiverId: Database.isHost ? receiverId : hostId,
        senderId: Database.isHost ? Database.hostId : Database.loginUserId,
        message: message,
        senderRole: senderRole,
        receiverRole: receiverRole,
        date: formatTime(),
      );
    } else {
      log("Failed to send message: chatTopicId is empty");
    }
  }

  Future<void> onClickSendDummyChat({required int index}) async {
    if (Database.coin > Database.chatRate) {
      await onSendMessage(
        messageType: 1,
        message: dummyChat[index],
        senderRole: Database.isHost ? "host" : "user",
        receiverRole: Database.isHost ? "user" : "host",
      );

      if (!Database.isHost) {
        userChats.insert(
          0,
          UserChat(
            message: dummyChat[index],
            date: formatTime(),
            messageType: 1,
            senderId: Database.loginUserId,
          ),
        );
      } else {
        hostChats.insert(
          0,
          HostChat(
            message: dummyChat[index],
            date: formatTime(),
            messageType: 1,
            senderId: Database.loginUserId,
          ),
        );
      }
      update([AppConstant.onChatList]);
      await onScrollDown();
    } else {
      Utils.showToast("You have Insufficient coins");
      await Future.delayed(600.milliseconds);
      Get.toNamed(AppRoutes.topUpPage)?.then((val) => update());
    }
  }

  Future<void> onClickSend() async {
    final text = messageController.text.trim();

    if (text.isNotEmpty) {
      if (Database.isHost) {
        await onSendMessage(
          messageType: 1,
          message: text,
          senderRole: "host",
          receiverRole: "user",
        );

        // Optimistic UI update
        hostChats.insert(
          0,
          HostChat(
            message: text,
            date: formatTime(),
            messageType: 1,
            senderId: Database.loginUserId,
          ),
        );

        update([AppConstant.onChatList]);
        await onScrollDown();

        messageController.clear();
      } else {
        if (Database.coin > Database.chatRate) {
          await onSendMessage(
            messageType: 1,
            message: text,
            senderRole: "user",
            receiverRole: "host",
          );

          userChats.insert(
            0,
            UserChat(
              message: text,
              date: formatTime(),
              messageType: 1,
              senderId: Database.loginUserId,
            ),
          );

          update([AppConstant.onChatList]);
          await onScrollDown();

          messageController.clear();
        } else {
          Utils.showToast(EnumLocale.txtYouHaveInsufficientCoins.name.tr);
          await Future.delayed(600.milliseconds);
          Get.toNamed(AppRoutes.topUpPage)?.then((val) => update());
        }
      }
    }
  }

  Future<void> onMessageReceived(Map<String, dynamic> response) async {
    await onScrollDown();

    if (Database.isHost) {
      if (receiverId == response['senderId'] || receiverId == response['receiverId']) {
        if (response["messageType"] == 2) {
          if (response["senderId"] == Database.hostId) {
            hostChats.removeAt(0);
          }

          isLoadingImage = false;
          update([AppConstant.onChatList]);

          hostChats.insert(
            0,
            HostChat(
              message: response["message"],
              date: formatTime(),
              messageType: 2,
              senderId: response["senderId"],
              image: response["message"],
            ),
          );
        } else {
          log("response[audio] ===================== ${response["audio"]}");
          if (response["messageType"] == 3) {
            if (response["senderId"] == Database.hostId) {
              hostChats.removeAt(0);
            }

            isLoadingAudio = false;
            update([AppConstant.onChatList]);

            hostChats.insert(
              0,
              HostChat(
                message: response["message"],
                date: formatTime(),
                messageType: 3,
                senderId: response["senderId"],
                audio: response["message"],
              ),
            );
          } else {
            if (response["senderId"] == Database.hostId) {
              hostChats.removeAt(0);
            }

            hostChats.insert(0, HostChat.fromJson(response));
          }
        }

        log("HostChats=>${hostChats.length}");

        await onScrollDown();
        update([AppConstant.onChatList]);
      }
    } else {
      if (hostId == response['senderId'] || hostId == response['receiverId']) {
        if (response['messageType'] == 2) {
          log("Enter in here messageType'] != 1=================");

          if (response["senderId"] == Database.loginUserId) {
            userChats.removeAt(0);
          }

          isLoadingImage = false;
          update([AppConstant.onChatList]);

          userChats.insert(
            0,
            UserChat(
              message: response["message"],
              date: formatTime(),
              messageType: 2,
              senderId: response["senderId"],
              image: response["message"],
            ),
          );
        } else if (response['messageType'] == 3) {
          log("response audio============== ${response["audio"]}");

          if (response["senderId"] == Database.loginUserId) {
            userChats.removeAt(0);
          }

          isLoadingAudio = false;
          update([AppConstant.onChatList]);

          userChats.insert(
            0,
            UserChat(
              message: response["message"],
              date: formatTime(),
              messageType: 3,
              senderId: response["senderId"],
              audio: response["message"],
            ),
          );
        } else {
          if (response["senderId"] == Database.loginUserId) {
            userChats.removeAt(0);
          }

          userChats.insert(0, UserChat.fromJson(response));
        }

        log("UserChats=>${userChats.length}");

        await onScrollDown();
        update([AppConstant.onChatList]);
      }
    }
  }

  void onMessageSeen(Map<String, dynamic> response) {
    log("onMessageSeen => $response");

    if (response[SocketParams.messageId] != null) {
      if (Database.isHost) {
        if (receiverId == response['senderId'] || receiverId == response['receiverId']) {
          hostChats[hostChats.indexWhere((element) => element.id == response[SocketParams.messageId])].isRead = true;
          update([AppConstant.onChatList]);
        }
      } else {
        if (hostId == response['senderId'] || hostId == response['receiverId']) {
          userChats[userChats.indexWhere((element) => element.id == response[SocketParams.messageId])].isRead = true;
          update([AppConstant.onChatList]);
        }
      }
    }
  }

  //**************** Profile Image & Send Image
  Future<void> onProfileImage() async {
    FocusManager.instance.primaryFocus?.unfocus();

    await ImagePickerBottomSheetUi.show(
      context: Get.context!,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);

        if (imagePath != null) {
          onInsertImage(imagePath);
          update([AppConstant.onChatList]);
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);

        if (imagePath != null) {
          onInsertImage(imagePath);
          update([AppConstant.onChatList]);
        }
      },
    );
  }

  Future<void> onInsertImage(String imagePath) async {
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    final now = formatTime();
    final tempId = DateTime.now().millisecondsSinceEpoch.toString();

    if (Database.isHost) {
      hostChats.insert(
        0,
        HostChat(
          id: tempId,
          image: imagePath,
          date: now,
          messageType: 2,
          senderId: Database.hostId,
        ),
      );
      isLoadingImage = true;
      update([AppConstant.onChatList]);
      await onScrollDown();

      hostSendFileApiModel = await HostSendFileApi.callApi(
        chatTopicId: chatTopicId,
        receiverId: receiverId,
        messageType: 2,
        filePath: imagePath,
        token: token ?? "",
        uid: uid ?? "",
        senderId: Database.hostId,
      );

      final index = hostChats.indexWhere((c) => c.id == tempId);
      if (index != -1 && hostSendFileApiModel?.chat?.image != null) {
        hostChats[index] = HostChat(
          id: hostSendFileApiModel?.chat?.id,
          image: hostSendFileApiModel?.chat?.image,
          date: now,
          messageType: 2,
          senderId: Database.hostId,
        );
        update([AppConstant.onChatList]);

        await onSendMessage(
          messageType: 2,
          message: hostSendFileApiModel?.chat?.image ?? "",
          messageId: hostSendFileApiModel?.chat?.id ?? "",
          senderRole: "host",
          receiverRole: "user",
        );
      }
    } else {
      if (Database.coin < Database.chatRate) {
        Utils.showToast(EnumLocale.txtYouHaveInsufficientCoins.name.tr);
        await 600.milliseconds.delay();
        Get.toNamed(AppRoutes.topUpPage)?.then((val) => update());
        return;
      }

      userChats.insert(
        0,
        UserChat(
          id: tempId,
          image: imagePath,
          date: now,
          messageType: 2,
          senderId: Database.loginUserId,
        ),
      );
      isLoadingImage = true;
      update([AppConstant.onChatList]);
      await onScrollDown();

      userSendFileApiModel = await UserSendFileApi.callApi(
        chatTopicId: chatTopicId,
        receiverId: hostId,
        messageType: 2,
        filePath: imagePath,
        token: token ?? "",
        uid: uid ?? "",
      );

      final index = userChats.indexWhere((c) => c.id == tempId);
      if (index != -1 && userSendFileApiModel?.chat?.image != null) {
        userChats[index] = UserChat(
          id: userSendFileApiModel?.chat?.id,
          image: userSendFileApiModel?.chat?.image,
          date: now,
          messageType: 2,
          senderId: Database.loginUserId,
        );
        update([AppConstant.onChatList]);

        await onSendMessage(
          messageType: 2,
          message: userSendFileApiModel?.chat?.image ?? "",
          messageId: userSendFileApiModel?.chat?.id ?? "",
          senderRole: "user",
          receiverRole: "host",
        );
      }
    }
  }

  /// **************** Send Audio
  Future<void> onStartAudioRecording() async {
    Utils.showLog("Audio Recording Start");
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = "${appDocDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.mp3";

    await audioRecorder.start(const RecordConfig(), path: filePath);

    isRecordingAudio = true;
    update([AppConstant.idOnChangeAudioRecordingEvent]);

    onChangeTimer();
  }

  Future<void> onStopAudioRecording() async {
    try {
      Utils.showLog("Audio Recording Stop");

      isSendingAudioFile = true;

      final audioPath = await audioRecorder.stop();

      isRecordingAudio = false;
      update([AppConstant.idOnChangeAudioRecordingEvent]);
      onChangeTimer();

      Utils.showLog("Recording Audio Path => $audioPath");

      if (audioPath != null) {
        onInsertAudio(audioPath);
      } else {
        Utils.showToast("Failed to send audio. Please try again!");
      }

      isSendingAudioFile = false;
      updateAudioUI();
    } catch (e) {
      isSendingAudioFile = false;
      Utils.showLog("Audio Recording Stop Failed => $e");
    }
  }

  Future<void> onLongPressStartMic() async {
    FocusManager.instance.primaryFocus?.unfocus();
    PermissionStatus status = await Permission.microphone.status;

    if (status.isDenied) {
      PermissionStatus request = await Permission.microphone.request();

      if (request == PermissionStatus.denied) {
        Utils.showToast(EnumLocale.txtPleaseAllowPermission.name.tr);
      }
    } else {
      Utils.showLog("Audio Recording Started...");
      onStartAudioRecording();
    }
    update([AppConstant.idOnChangeAudioRecordingEvent]);
  }

  Future<void> onLongPressEndMic() async {
    PermissionStatus status = await Permission.microphone.status;

    if (isRecordingAudio && status.isGranted) {
      onStopAudioRecording();
    }
    update([AppConstant.idOnChangeAudioRecordingEvent]);
  }

  Future<void> onInsertAudio(String audioPath) async {
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();
    final now = formatTime();
    final tempId = DateTime.now().millisecondsSinceEpoch.toString();

    if (Database.isHost) {
      hostChats.insert(
        0,
        HostChat(
          id: tempId,
          audio: audioPath,
          date: now,
          messageType: 3,
          senderId: Database.hostId,
        ),
      );
      isLoadingAudio = true;
      update([AppConstant.onChatList]);
      await onScrollDown();

      hostSendFileApiModel = await HostSendFileApi.callApi(
        messageType: 3,
        filePath: audioPath,
        chatTopicId: chatTopicId,
        receiverId: receiverId,
        token: token ?? "",
        uid: uid ?? "",
        senderId: Database.hostId,
      );

      final index = hostChats.indexWhere((c) => c.id == tempId);
      if (index != -1 && hostSendFileApiModel?.chat?.audio != null) {
        hostChats[index] = HostChat(
          id: hostSendFileApiModel?.chat?.id,
          audio: hostSendFileApiModel?.chat?.audio,
          date: now,
          messageType: 3,
          senderId: Database.hostId,
        );
        update([AppConstant.onChatList]);

        await onSendMessage(
          messageType: 3,
          message: hostSendFileApiModel?.chat?.audio ?? "",
          messageId: hostSendFileApiModel?.chat?.id ?? "",
          senderRole: "host",
          receiverRole: "user",
        );
      }
    } else {
      if (Database.coin < Database.chatRate) {
        Utils.showToast(EnumLocale.txtYouHaveInsufficientCoins.name.tr);
        await 600.milliseconds.delay();
        Get.toNamed(AppRoutes.topUpPage)?.then((val) => update());
        return;
      }

      userChats.insert(
        0,
        UserChat(
          id: tempId,
          audio: audioPath,
          date: now,
          messageType: 3,
          senderId: Database.loginUserId,
        ),
      );

      isLoadingAudio = true;
      update([AppConstant.onChatList]);
      await onScrollDown();

      userSendFileApiModel = await UserSendFileApi.callApi(
        messageType: 3,
        filePath: audioPath,
        chatTopicId: chatTopicId,
        receiverId: hostId,
        token: token ?? "",
        uid: uid ?? "",
      );

      final index = userChats.indexWhere((c) => c.id == tempId);
      if (index != -1 && userSendFileApiModel?.chat?.audio != null) {
        userChats[index] = UserChat(
          id: userSendFileApiModel?.chat?.id,
          audio: userSendFileApiModel?.chat?.audio,
          date: now,
          messageType: 3,
          senderId: Database.loginUserId,
        );
        update([AppConstant.onChatList]);

        await onSendMessage(
          messageType: 3,
          message: userSendFileApiModel?.chat?.audio ?? "",
          messageId: userSendFileApiModel?.chat?.id ?? "",
          senderRole: "user",
          receiverRole: "host",
        );
      }
    }
  }

  Future<void> onChangeTimer() async {
    if (isRecordingAudio && timer == null) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          countTime++;
          log("Recording time: $countTime sec");
          updateAudioUI();
          if (!isRecordingAudio) {
            countTime = 0;
            timer.cancel();
            this.timer = null;
            updateAudioUI();
          }
        },
      );
    } else {
      countTime = 0;
      timer?.cancel();
      timer = null;
      updateAudioUI();
    }
  }

  Future<void> updateAudioUI() async {
    await Future.delayed(const Duration(milliseconds: 100));
    update([AppConstant.idOnChangeAudioRecordingEvent]);
  }

  //**************** Send GIFT
  onSendGift() async {
    if (GiftBottomSheetWidget.selectedGiftId.isEmpty || GiftBottomSheetWidget.giftUrl.isEmpty || GiftBottomSheetWidget.giftType == -1) {
      Utils.showToast("Please select a gift first");
      return;
    }

    final totalCost = GiftBottomSheetWidget.giftCoin * GiftBottomSheetWidget.giftCount.toInt();
    if (totalCost > Database.coin) {
      Utils.showToast(EnumLocale.txtYouHaveInsufficientCoins.name.tr);
      await 600.milliseconds.delay();
      Get.toNamed(AppRoutes.topUpPage)?.then((_) => update());
      return;
    }

    if (chatTopicId.isEmpty) {
      Utils.showLog("Failed to send gift: chatTopicId is empty");
      return;
    }

    // Log senderId, hostId, and giftId for debugging
    print(
        "Chat Gift - SenderID: ${Database.isHost ? Database.hostId : Database.loginUserId}, HostID: ${Database.isHost ? receiverId : hostId}, GiftID: ${GiftBottomSheetWidget.selectedGiftId}");

    SocketEmit.onSendGift(
      chatTopicId: chatTopicId,
      giftCount: GiftBottomSheetWidget.giftCount.toString(),
      giftId: GiftBottomSheetWidget.selectedGiftId,
      giftUrl: GiftBottomSheetWidget.giftUrl,
      giftsvgaImage: GiftBottomSheetWidget.giftsvgaImage,
      giftImage: GiftBottomSheetWidget.giftsvgaImage,
      receiverId: Database.isHost ? receiverId : hostId,
      senderId: Database.isHost ? Database.hostId : Database.loginUserId,
      senderRole: Database.isHost ? "host" : "user",
      receiverRole: Database.isHost ? "user" : "host",
      giftType: GiftBottomSheetWidget.giftType,
    );
  }

  void onGiftReceive(Map<String, dynamic> response) async {
    log("response Done => $response");
    log("giftCount=>${response["giftCount"]}");

    final String id =
        (response["id"]?.toString().trim().isNotEmpty ?? false) ? response["id"].toString() : DateTime.now().millisecondsSinceEpoch.toString();

    final int giftType = response["giftType"] ?? 0;
    final int giftCount = int.tryParse(response["giftCount"]?.toString() ?? "1") ?? 1;
    final String giftUrl = response["giftUrl"] ?? "";
    final String thumbUrl = response["giftsvgaImage"] ?? "";

    if (Database.isHost) {
      hostChats.insert(
        0,
        HostChat(
          id: id,
          image: giftUrl,
          giftsvgaImage: thumbUrl,
          giftCount: giftCount,
          date: formatTime(),
          messageType: 4,
          senderId: response["senderId"],
          giftType: giftType,
        ),
      );

      update([AppConstant.onChatList]);
    } else {
      userChats.insert(
        0,
        UserChat(
          id: id,
          image: giftUrl,
          giftsvgaImage: thumbUrl,
          giftCount: giftCount,
          date: formatTime(),
          messageType: 4,
          senderId: response["senderId"],
          giftType: giftType,
        ),
      );
    }

    onGiftMessageInserted(id);

    update([AppConstant.onChatList]);
  }

  //**************** Pagination
  Future<void> onPagination() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      Database.isHost ? await getHostChatHistory(isPagination: true) : await getUserChatHistory(isPagination: true);
      update([AppConstant.idOnPagination, AppConstant.onChatList]);
    }
  }

  //**************** Block
  void getBlock({required BuildContext context}) async {
    Get.dialog(
      barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
      Dialog(
        backgroundColor: AppColors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        child: BlockDialog(
            hostId: Database.isHost ? receiverId : hostId,
            isHost: Database.isHost ? false : true,
            userId: Database.isHost ? receiverId : hostId,
            isChatHostDetail: isChatHostDetail),
      ),
    );
  }

  //**************** Format Time
  String formatTimeFromApi(String time) {
    try {
      DateTime parsedTime = DateFormat('M/d/yyyy, h:mm:ss a').parse(time);

      return DateFormat('hh:mm a').format(parsedTime);
    } catch (e) {
      return time;
    }
  }

  String formatTimeVideoCall(String time) {
    final parts = time.split(', ');
    if (parts.length != 2) return time;

    final timePart = parts[1].split(' ');
    if (timePart.length < 2) return time;

    final timeComponents = timePart[0].split(':');
    if (timeComponents.length != 3) return time;

    int hour = int.parse(timeComponents[0]);
    final minute = timeComponents[1];
    final period = timePart[1].toUpperCase();

    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  String formatTime() {
    try {
      String formattedTime;
      formattedTime = DateFormat('hh:mm a').format(DateTime.now());
      return formattedTime;
    } catch (e) {
      Utils.showLog("Error in format time :: $e");
      return "";
    }
  }

  Future<void> onScrollDown() async {
    log("Scroll Down");
    try {
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );

      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      Utils.showLog("Scroll Down Failed => $e");
    }
  }

  //**************** Host Details
  Future<void> getHostProfileApi() async {
    if (InternetConnection.isConnect) {
      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      hostDetailModel = await HostDetailApi.callApi(
        hostId: hostId,
        token: token ?? "",
        uid: uid ?? "",
      );
    } else {
      Utils.showToast(EnumLocale.txtPleaseCheckYourInternetConnection.name.tr);
    }

    update();
  }
}
