import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/message_page/api/get_chat_thumb_list_user.dart';
import 'package:LoveBirds/pages/message_page/model/get_chat_thumb_list_user_model.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/internet_connection.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  GetChatThumbListUserModel? getChatThumbListUserModel;
  List<ChatList> userThumbList = [];
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  bool isPaginationLoading = false;
  bool hasMoreData = true;
  @override
  void onInit() {
    if (Database.isAutoRefreshEnabled) {
      getUserMessage();
      scrollController.addListener(onPagination);
    } else {
      if (Database.isMessageApiCall) {
        getUserMessage();
        scrollController.addListener(onPagination);

        Database.onSetIsMessageApiCall(false);
      } else {
        Utils.showLog("Enter in else live stream controller");
      }
    }

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(onPagination);
    super.onClose();
  }

  void onPagination() {
    if (!isPaginationLoading &&
        hasMoreData &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) {
      GetChatThumbListUser.startPagination++;
      getUserMessage(isPagination: true);
    }
  }

  Future<void> getUserMessage(
      {bool isPagination = false, bool isLoadingThen = false}) async {
    if (!isPagination) {
      userThumbList.clear();
      GetChatThumbListUser.startPagination = 1;
      hasMoreData = true;
      isLoading = true;
    } else {
      isPaginationLoading = true;
    }

    update();

    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    if (isLoadingThen) await 1.seconds.delay();

    getChatThumbListUserModel = await GetChatThumbListUser.callApi(
      token: token ?? "",
      uid: uid ?? "",
    );

    final newChats = getChatThumbListUserModel?.chatList ?? [];

    if (newChats.isEmpty) {
      hasMoreData = false;
    } else {
      userThumbList.addAll(newChats);
    }

    isLoading = false;
    isPaginationLoading = false;

    update();
  }

  Future<void> getUpdatedCoin() async {
    if (InternetConnection.isConnect) {
      isLoading = true;
      update([AppConstant.idRandomMatchView]);

      await CustomFetchUserCoin.init();
      Utils.showLog(
          "discover_host_controller.dart coin: ${CustomFetchUserCoin.coin.value}");

      isLoading = false;
      update([AppConstant.idRandomMatchView, AppConstant.idUpdateCoin]);
    } else {
      Utils.showLog("Internet Connection Lost !!");
    }
  }
}
