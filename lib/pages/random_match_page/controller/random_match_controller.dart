import 'dart:developer';

import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/random_match_page/api/get_available_host_api.dart';
import 'package:LoveBirds/pages/random_match_page/model/get_available_host_model.dart';
import 'package:LoveBirds/pages/random_match_page/model/get_vip_plan.dart';
import 'package:LoveBirds/pages/random_match_page/widget/carousel_widget.dart';
import 'package:LoveBirds/pages/top_up_page/api/get_coin_plan_api.dart';
import 'package:LoveBirds/pages/top_up_page/model/get_coin_plan_model.dart';
import 'package:LoveBirds/pages/vip_page/model/vip_plan_privilege_model.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/internet_connection.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:get/get.dart';

class RandomMatchController extends GetxController {
  int currentIndex = 0;
  bool isLoading = false;

  GetCoinPlanModel? getCoinPlanModel;
  GetAvailableHostModel? getAvailableHostModel;
  VipPlanPrivilegeModel? vipPlanPrivilegeModel;
  GetVipPlanModel? getVipPlanModel;

  List<CoinPlan> coinPlanList = [];
  List<VipPlan> vipPlanList = <VipPlan>[];
  List<CarouselWidget> vipPrivilegeList = [];

  String selectedGender = "both";
  String selectedPaymentMethod = "";

  int onChangeTab = 0;

  @override
  void onInit() {
    getCoinPlanApi();
    getUpdatedCoin();
    print('initstate call');
    super.onInit();
  }

  void onCarouselTap({required int id}) {
    currentIndex = id;
    log('id: $currentIndex');
    update([AppConstant.idOnCarouselTap]);
  }

  void changeTab({required int index}) {
    onChangeTab = index;
    update([AppConstant.idOnChangeTep]);
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod = method;
    update([AppConstant.idRadio]);
  }

  bool isSelected(String method) {
    return selectedPaymentMethod == method;
  }

  Future<void> onChangeGender(String gender) async {
    selectedGender = gender;
    log("Select Gender :: $selectedGender");
    update([AppConstant.onChangeGender]);
  }

  Future<void> getCoinPlanApi() async {
    log("Enter get coin plan API");

    if (InternetConnection.isConnect) {
      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      getCoinPlanModel =
          await GetCoinPlanApi.callApi(token: token ?? "", uid: uid ?? "");
      coinPlanList = getCoinPlanModel?.data ?? <CoinPlan>[];

      update([AppConstant.idGetCoin, AppConstant.idUpdateCoin]);
    } else {
      Utils.showLog("Internet Connection Lost !!");
      Utils.showToast("Internet Connection Lost !!");
    }
  }

  Future<void> getAvailableHostApi() async {
    if (InternetConnection.isConnect) {
      isLoading = true;
      update([AppConstant.idRandomMatchView]);

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      getAvailableHostModel = await GetAvailableHostApi.callApi(
        gender: selectedGender,
        token: token ?? "",
        uid: uid ?? "",
      );

      isLoading = false;
      update([AppConstant.idRandomMatchView]);

      if (getAvailableHostModel?.data != null) {
        isLoading = false;
        update([AppConstant.idRandomMatchView]);

        Get.toNamed(
          AppRoutes.matchingPage,
          arguments: {
            "getAvailableHost":
                getAvailableHostModel?.data ?? GetAvailableHost(),
            "gender": selectedGender.toString(),
          },
        )?.then((value) async {
          // In random_match_controller.dart
          await CustomFetchUserCoin.init();
          log("random_match_controller.dart coin: ${CustomFetchUserCoin.coin.value}");
          update([AppConstant.idUpdateCoin]);
        });

        // 1000.milliseconds.delay();
        // update();
        // update([AppConstant.idRandomMatchView]);
      } else {
        Utils.showToast(getAvailableHostModel?.message ?? "");
      }

      isLoading = false;
      update([AppConstant.idRandomMatchView, AppConstant.idGetCoin]);
    } else {
      Utils.showLog("Internet Connection Lost !!");
      Utils.showToast(EnumLocale.txtNoInternetConnection.name.tr);
    }
  }

  Future<void> getUpdatedCoin() async {
    if (InternetConnection.isConnect) {
      isLoading = true;
      update([AppConstant.idRandomMatchView]);

      await CustomFetchUserCoin.init();
      log("random_match_controller.dart coin: ${CustomFetchUserCoin.coin.value}");

      isLoading = false;
      update([AppConstant.idRandomMatchView, AppConstant.idUpdateCoin]);
    } else {
      Utils.showLog("Internet Connection Lost !!");
    }
  }
}
