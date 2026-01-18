import 'package:LoveBirds/pages/host_withdraw_history_page/api/get_host_withdraw_history_api.dart';
import 'package:LoveBirds/pages/host_withdraw_history_page/model/get_host_withdraw_history_model.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HostWithdrawHistoryController extends GetxController {
  GetHostWithdrawHistoryModel? getHostWithdrawHistoryModel;
  ScrollController scrollController = ScrollController();

  bool isLoading = false;
  bool isPaginationLoading = false;
  List<Datum> withdrawHistory = [];

  String startDate = "All";
  String endDate = "All"; // This is Send on Api....

  String rangeDate = "All"; // This is Show on UI....

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    onGetWithdrawHistory();
    Utils.showLog("My Wallet Page Controller Initialize Success");
  }

  Future<void> onGetWithdrawHistory({bool isPagination = false}) async {
    isLoading = true;
    withdrawHistory.clear();
    update([AppConstant.onGetWithdrawHistory]);

    if (!isPagination) {
      isLoading = true;
      update([AppConstant.onGetWithdrawHistory]);
    }

    getHostWithdrawHistoryModel = await GeHostWithdrawHistoryApi.callApi(
      hostId: Database.hostId,
      startDate: startDate,
      endDate: endDate,
    );

    if (getHostWithdrawHistoryModel?.data != null) {
      withdrawHistory.clear();
      withdrawHistory.addAll(getHostWithdrawHistoryModel?.data ?? []);

      isLoading = false;
      isPaginationLoading = false;
      update([
        AppConstant.onGetWithdrawHistory,
        AppConstant.idWalletOnPagination,
        AppConstant.idOnChangeDate
      ]);
    }
  }

  Future<void> onPagination() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent - 100) {
      if (isPaginationLoading) return;

      isPaginationLoading = true;
      update([AppConstant.idWalletOnPagination]);

      GeHostWithdrawHistoryApi.startPagination++;

      await onGetWithdrawHistory(isPagination: true);
    }
  }

  Future<void> onChangeDate(
      {required String startDate,
      required String endDate,
      required String rangeDate}) async {
    this.startDate = startDate;
    this.endDate = endDate;
    this.rangeDate = rangeDate;
    update([AppConstant.idOnChangeDate]);
  }
}
