import 'package:figgy/custom/other/custom_fetch_user_coin.dart';
import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/splash_screen_page/api/get_setting_api.dart';
import 'package:figgy/pages/top_up_page/api/get_coin_plan_api.dart';
import 'package:figgy/pages/top_up_page/model/get_coin_plan_model.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/internet_connection.dart';
import 'package:figgy/utils/utils.dart';
import 'package:get/get.dart';

class TopUpController extends GetxController {
  bool isLoading = false;
  GetCoinPlanModel? getCoinPlanModel;
  List<CoinPlan> coinPlanList = [];
  int currentIndex = 0;

  @override
  void onInit() async {
    getCoinPlanApi();

    CustomFetchUserCoin.init();

    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    GetSettingApi.getSettingApi(uid: uid ?? "", token: token ?? "");

    super.onInit();
  }

  void changeTab({required int index}) {
    currentIndex = index;
    update([AppConstant.idChangePage]);
  }

  Future<void> getCoinPlanApi() async {
    if (InternetConnection.isConnect) {
      isLoading = true;

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      getCoinPlanModel = await GetCoinPlanApi.callApi(token: token ?? "", uid: uid ?? "");
      coinPlanList = getCoinPlanModel?.data ?? <CoinPlan>[];

      isLoading = false;
      update([AppConstant.idGetCoin]);
    } else {
      Utils.showLog("Internet Connection Lost !!");
      Utils.showToast("Internet Connection Lost !!");
    }
  }
}
