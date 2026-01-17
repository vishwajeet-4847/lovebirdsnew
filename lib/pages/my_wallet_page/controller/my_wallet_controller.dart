import 'dart:math';

import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/my_wallet_page/api/get_coin_history_api.dart';
import 'package:figgy/pages/my_wallet_page/api/get_host_coin_history.dart';
import 'package:figgy/pages/my_wallet_page/model/fetch_coin_history_model.dart';
import 'package:figgy/pages/my_wallet_page/model/fetch_host_coin_history_model.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyWalletController extends GetxController {
  bool isLoading = false;
  bool isPaginating = false;

  List<Data> userCoinHistory = [];
  List<HostCoinHistory> hostCoinHistory = [];

  FetchCoinHistoryModel? fetchCoinHistoryModel;
  FetchHostCoinHistoryModel? fetchHostCoinHistoryModel;

  ScrollController scrollController = ScrollController();

  String startDate = "All";
  String endDate = "All"; // Sent to API
  String rangeDate = "All"; // Displayed on UI

  final Map<int, String> generatedIds = {};

  @override
  void onInit() {
    scrollController.addListener(onPagination);

    Database.isHost ? onGetHostCoinHistory() : onGetUserCoinHistory();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(onPagination);
    if (Database.isHost) {
      GetHostCoinHistoryApi.startPagination = 1;
    } else {
      GetUserCoinHistoryApi.startPagination = 1;
    }
    scrollController.dispose();
    super.onClose();
  }

  Future<void> init() async {
    Database.isHost ? await onGetHostCoinHistory() : await onGetUserCoinHistory();
    Utils.showLog("My Wallet Page Controller Initialize Success");
  }

  Future<void> onGetUserCoinHistory({bool isPagination = false}) async {
    try {
      if (!isPagination) {
        isLoading = true;
        update([AppConstant.idGetCoinHistory]);
      } else {
        isPaginating = true;
        update([AppConstant.onPaginationLoader]);
      }

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      fetchCoinHistoryModel = await GetUserCoinHistoryApi.callApi(
        startDate: startDate,
        endDate: endDate,
        token: token ?? '',
        uid: uid ?? '',
      );

      if (fetchCoinHistoryModel?.data != null) {
        Database.onSetCoin(fetchCoinHistoryModel?.userCoin ?? 0);

        userCoinHistory.addAll(fetchCoinHistoryModel?.data ?? []);

        update();
      } else {
        GetUserCoinHistoryApi.startPagination--;
      }
    } catch (e) {
      Utils.showLog("Error get coin history :: $e");
    } finally {
      if (!isPagination) {
        isLoading = false;
        update([AppConstant.idGetCoinHistory]);
      } else {
        isPaginating = false;
        update([AppConstant.onPaginationLoader]);
      }
    }

    update([AppConstant.idGetCoinHistory, AppConstant.idWalletOnPagination, AppConstant.idChangeDate]);
  }

  Future<void> onGetHostCoinHistory({bool isPagination = false}) async {
    try {
      if (!isPagination) {
        isLoading = true;
        update([AppConstant.idGetCoinHistory]);
      } else {
        isPaginating = true;
        update([AppConstant.onPaginationLoader]);
      }

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      fetchHostCoinHistoryModel = await GetHostCoinHistoryApi.callApi(
        startDate: startDate,
        endDate: endDate,
        token: token ?? '',
        uid: uid ?? '',
      );

      if (fetchHostCoinHistoryModel?.data != null) {
        Database.onSetCoin(fetchHostCoinHistoryModel?.hostCoin ?? 0);

        hostCoinHistory.addAll(fetchHostCoinHistoryModel?.data ?? []);

        update();
      } else {
        GetHostCoinHistoryApi.startPagination--;
      }
    } catch (e) {
      Utils.showLog("Error get coin history :: $e");
    } finally {
      if (!isPagination) {
        isLoading = false;
        update([AppConstant.idGetCoinHistory]);
      } else {
        isPaginating = false;
        update([AppConstant.onPaginationLoader]);
      }
    }

    update([AppConstant.idGetCoinHistory, AppConstant.idWalletOnPagination, AppConstant.idChangeDate]);
  }

  Future<void> onChangeDate({
    required String startDate,
    required String endDate,
    required String rangeDate,
  }) async {
    this.startDate = startDate;
    this.endDate = endDate;
    this.rangeDate = rangeDate;

    // Reset pagination
    userCoinHistory.clear();
    hostCoinHistory.clear();

    GetUserCoinHistoryApi.startPagination = 1;
    GetHostCoinHistoryApi.startPagination = 1;

    update([AppConstant.idChangeDate]);
  }

  Future<void> onPagination() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Database.isHost) {
        GetHostCoinHistoryApi.startPagination++;
      } else {
        GetUserCoinHistoryApi.startPagination++;
      }

      Database.isHost ? await onGetHostCoinHistory(isPagination: true) : await onGetUserCoinHistory(isPagination: true);
      update([AppConstant.idOnPagination, AppConstant.onChatList]);
    }
  }

  String getTitleFromType(int type, String receiverName, String typeDescription) {
    switch (type) {
      case 9:
        return "💬Chat With $receiverName";
      case 10:
        return "💬Gift With $receiverName";
      case 11:
        return "📞Private Audio Call $receiverName";
      case 12:
        return "🎥Private Video Call $receiverName";
      case 13:
        return "🎥Random Video Call $receiverName";
        case 14:
        return "Admin Credit";
        case 15:
        return "Admin Debit";
      default:
        return typeDescription;
    }
  }

  String getHostTitleFromType(int type, String senderName, String typeDescription) {
    switch (type) {
      case 9:
        return "💬Chat to $senderName";
      case 10:
        return "💬Chat Gift to $senderName";
      case 11:
        return "📞Private Audio Call $senderName";
      case 12:
        return "🎥Private Video Call $senderName";
      case 13:
        return "🎥Random Video Call $senderName";
      case 14:
        return "Admin Add Coin";
      case 15:
        return "Admin Deduct Coin";
      default:
        return typeDescription;
    }
  }

  String dateFormat(dynamic date) {
    final DateTime utcDate = DateTime.parse(date.toString());
    final DateTime istDate = utcDate.toLocal(); // This auto converts to IST if device is in IST

    final DateFormat formatter = DateFormat('d/M/yyyy, h:mm:ss a');
    return formatter.format(istDate);
  }

  String getDisplayUniqueId(int index, String? originalId) {
    if (originalId != null && originalId.isNotEmpty) {
      return originalId;
    }

    if (!generatedIds.containsKey(index)) {
      generatedIds[index] = _generateRandomId();
    }

    return generatedIds[index]!;
  }

  String _generateRandomId() {
    final random = Random();
    return List.generate(8, (_) => random.nextInt(10)).join(); // Example: 85231947
  }
}
