import 'dart:developer';

import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/block_list_page/api/get_blocked_hosts_api.dart';
import 'package:figgy/pages/block_list_page/api/get_blocked_user_api.dart';
import 'package:figgy/pages/block_list_page/model/get_blocked_hosts_model.dart';
import 'package:figgy/pages/block_list_page/model/get_blocked_user_model.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockController extends GetxController {
  bool isUserLoading = false;
  bool isHostLoading = false;

  GetBlockedHostsModel? getHostBlockModel;
  List<BlockedHost> hostBlockList = []; // = Blocked Host
  ScrollController scrollController = ScrollController();

  // =================================================================================
  GetBlockedUserModel? getBlockedUserModel;
  List<BlockedUser> userBlockList = []; // = Blocked User

  @override
  void onInit() {
    scrollController.addListener(onPagination);
    Database.isHost ? getUserBlockList() : getHostBlockList();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(onPagination);
    super.onClose();
  }

  Future<void> getHostBlockList({bool isPagination = false}) async {
    if (!isPagination) {
      hostBlockList.clear();
    }

    isUserLoading = true;
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();
    getHostBlockModel = await GetBlockedHostsApi.callApi(token: token ?? "", uid: uid ?? "");
    hostBlockList.addAll(getHostBlockModel?.blockedHosts ?? []);
    // hostBlockList = getHostBlockModel?.blockedHosts ?? <BlockedHost>[];
    isUserLoading = false;
    update([AppConstant.userViewUpdate]);
  }

  // ==================== Host view ==============================
  Future<void> getUserBlockList({bool isPagination = false}) async {
    userBlockList.clear();
    isHostLoading = true;
    getBlockedUserModel = await GetBlockedUserApi.callApi(
      hostId: Database.hostId,
    );
    userBlockList.addAll(getBlockedUserModel?.blockedUsers ?? []);
    // userBlockList = getBlockedUserModel?.blockedUsers ?? <BlockedUser>[];
    isHostLoading = false;
    update([AppConstant.idUserBlockList]);
  }

  Future<void> onPagination() async {
    log("position=>${scrollController.position.pixels}");
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      log("Call");
      if (Database.isHost) {
        GetBlockedUserApi.startPagination++;
        getUserBlockList(isPagination: false);
      } else {
        GetBlockedHostsApi.startPagination++;
        getHostBlockList(isPagination: true);
      }
    }
  }
}
