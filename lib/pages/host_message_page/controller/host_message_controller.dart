// import 'package:LoveBirds/firebase/firebase_access_token.dart';
// import 'package:LoveBirds/firebase/firebase_uid.dart';
// import 'package:LoveBirds/pages/host_message_page/api/get_chat_thumb_list_host.dart';
// import 'package:LoveBirds/pages/host_message_page/model/get_chat_thumb_list_host_model.dart';
// import 'package:LoveBirds/utils/database.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class HostMessageController extends GetxController {
//   GetChatThumbListHostModel? getChatThumbListHostModel;
//   List<HostChatList> hostThumbList = [];
//   ScrollController scrollController = ScrollController();
//   bool isLoading = false;
//   @override
//   void onInit() {
//     getHostMessage();
//     scrollController.addListener(onPagination);
//
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     scrollController.removeListener(onPagination);
//     scrollController.dispose();
//     super.onClose();
//   }
//
//   void onPagination() {
//     if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
//       GetChatThumbListHostApi.startPagination++;
//       getHostMessage(isPagination: true);
//     }
//   }
//
//   // Future<void> getHostMessage({bool isPagination = false}) async {
//   //   if (!isPagination) {
//   //     hostThumbList.clear();
//   //   }
//   //
//   //   isLoading = true;
//   //   final uid = FirebaseUid.onGet();
//   //   final token = await FirebaseAccessToken.onGet();
//   //
//   //   getChatThumbListHostModel = await GetChatThumbListHostApi.callApi(
//   //     token: token ?? "",
//   //     uid: uid ?? "",
//   //     hostId: Database.hostId,
//   //   );
//   //
//   //   hostThumbList.addAll(getChatThumbListHostModel?.chatList ?? []);
//   //   isLoading = false;
//   //
//   //   update();
//   // }
//
//   Future<void> getHostMessage({bool isPagination = false}) async {
//     if (!isPagination) {
//       hostThumbList.clear();
//     }
//
//     isLoading = true; // Set loading to true to show shimmer
//     update(); // Trigger rebuild to show shimmer effect
//
//     final uid = FirebaseUid.onGet();
//     final token = await FirebaseAccessToken.onGet();
//
//     getChatThumbListHostModel = await GetChatThumbListHostApi.callApi(
//       token: token ?? "",
//       uid: uid ?? "",
//       hostId: Database.hostId,
//     );
//
//     hostThumbList.addAll(getChatThumbListHostModel?.chatList ?? []);
//     isLoading = false; // Set loading to false after fetching data
//     update(); // Trigger rebuild to show the actual content
//   }
// }

import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/host_message_page/api/get_chat_thumb_list_host.dart';
import 'package:LoveBirds/pages/host_message_page/model/get_chat_thumb_list_host_model.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostMessageController extends GetxController {
  GetChatThumbListHostModel? getChatThumbListHostModel;
  List<HostChatList> hostThumbList = [];
  ScrollController scrollController = ScrollController();

  bool isLoading = false;
  bool isPaginationLoading = false;
  bool hasMoreData = true;

  @override
  void onInit() {
    if (Database.isAutoRefreshEnabled) {
      getHostMessage();
      scrollController.addListener(onPagination);
    } else {
      if (Database.isHostMessageApiCall) {
        Utils.showLog("Enter in if live stream api calling..............");

        getHostMessage();
        scrollController.addListener(onPagination);

        Utils.showLog(
            'Database.isApiCall+++++-++-+-+-+ ${Database.isHostMessageApiCall}');
        Database.onSetIsHostMessageApiCall(false);
        Utils.showLog(
            'Database.isApiCall0202202220 ${Database.isHostMessageApiCall}');
      } else {
        Utils.showLog("Enter in else live stream controller");
      }
    }

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(onPagination);
    scrollController.dispose();
    super.onClose();
  }

  void onPagination() {
    if (!isPaginationLoading &&
        hasMoreData &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) {
      GetChatThumbListHostApi.startPagination++;
      getHostMessage(isPagination: true);
    }
  }

  Future<void> getHostMessage(
      {bool isPagination = false, bool isLoadingThen = false}) async {
    if (!isPagination) {
      hostThumbList.clear();
      GetChatThumbListHostApi.startPagination = 1;
      hasMoreData = true;
      isLoading = true;
    } else {
      isPaginationLoading = true;
    }

    update();

    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    if (isLoadingThen) await 1.seconds.delay();

    getChatThumbListHostModel = await GetChatThumbListHostApi.callApi(
      token: token ?? "",
      uid: uid ?? "",
      hostId: Database.hostId,
    );

    final newChats = getChatThumbListHostModel?.chatList ?? [];

    if (newChats.isEmpty) {
      hasMoreData = false;
    } else {
      hostThumbList.addAll(newChats);
    }

    isLoading = false;
    isPaginationLoading = false;

    update();
  }
}
