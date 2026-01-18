// import 'dart:developer';
//
// import 'package:LoveBirds/firebase/firebase_access_token.dart';
// import 'package:LoveBirds/firebase/firebase_uid.dart';
// import 'package:LoveBirds/pages/withdraw_page/api/get_payment_method_api.dart';
// import 'package:LoveBirds/pages/withdraw_page/model/get_paymet_model.dart';
// import 'package:LoveBirds/utils/constant.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../widget/withdraw_widget.dart';
//
// class WithdrawController extends GetxController {
//   TextEditingController coinController = TextEditingController();
//
//   bool isLoading = false;
//   static GetPaymentModel? getPaymentModel;
//   List<WithdrawMethods> withdrawMethods = [];
//
//   List<TextEditingController> withdrawPaymentDetails = [];
//
//   int? selectedPaymentMethod;
//   bool isShowPaymentMethod = false;
//   List<String>? details;
//   List<Widget> inputFel = []; // Initialize as an empty list
//   List? data;
//
//   @override
//   void onInit() {
//     getPaymentMethod();
//
//     super.onInit();
//   }
//
//   Future<void> onSwitchWithdrawMethod() async {
//     isShowPaymentMethod = !isShowPaymentMethod;
//
//     update([AppConstant.onChangePaymentMethod, AppConstant.onSwitchWithdrawMethod, AppConstant.getPaymentMethod]);
//   }
//
//   Future<void> onChangePaymentMethod(int index) async {
//     selectedPaymentMethod = index;
//     if (isShowPaymentMethod) {
//       onSwitchWithdrawMethod();
//     }
//
//     details = withdrawMethods[index].details?.expand((detail) => detail.split(',')).map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
//
//     // Initialize withdrawPaymentDetails as per cleaned data
//     withdrawPaymentDetails = List<TextEditingController>.generate(
//       details?.length ?? 0,
//       (index) => TextEditingController(),
//     );
//     data = details?.map((e) => TextEditingController()).toList();
//     // Generate input fields directly
//     inputFel = details
//             ?.map((element) => EnterGooglePayNumberFielUi(
//                   title: element,
//                   index: index,
//                 ))
//             .toList() ??
//         [];
//
//     // Log for debugging
//     details?.forEach((e) => log("data: $e"));
//     log("data: $data");
//     log("data2: $inputFel");
//
//     update([AppConstant.onChangePaymentMethod, AppConstant.onSwitchWithdrawMethod, AppConstant.getPaymentMethod]);
//   }
//
//   void onSubmit() {
//     log(withdrawPaymentDetails.toString());
//     log("Submit Clicked");
//   }
//
//   Future<void> getPaymentMethod() async {
//     final uid = FirebaseUid.onGet();
//     final token = await FirebaseAccessToken.onGet();
//     isLoading = true;
//
//     getPaymentModel = await GetPaymentMethodApi.callApi(token: token ?? "", uid: uid ?? "");
//     withdrawMethods = getPaymentModel?.data ?? [];
//
//     isLoading = false;
//     update([AppConstant.onChangePaymentMethod, AppConstant.onSwitchWithdrawMethod, AppConstant.getPaymentMethod]);
//   }
// }
import 'dart:developer';

import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/my_wallet_page/model/fetch_coin_history_model.dart';
import 'package:LoveBirds/pages/my_wallet_page/model/fetch_host_coin_history_model.dart';
import 'package:LoveBirds/pages/splash_screen_page/model/get_setting_model.dart';
import 'package:LoveBirds/pages/withdraw_page/api/withdrawal_request_api.dart';
import 'package:LoveBirds/pages/withdraw_page/model/get_paymet_model.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../splash_screen_page/api/get_setting_api.dart';
import '../api/get_payment_method_api.dart';
import '../model/create_withdraw_request_model.dart';
import '../widget/withdraw_widget.dart';

class WithdrawController extends GetxController {
  TextEditingController coinController = TextEditingController();
  static FetchHostCoinHistoryModel? fetchHostCoinHistoryModel;
  static FetchCoinHistoryModel? fetchCoinHistoryModel;

  bool isLoading = false;
  List<WithdrawMethods> withdrawMethods = [];
  GetPaymentModel? fetchWithdrawMethodModel;
  List<TextEditingController> withdrawPaymentDetails = [];
  List<String>? details;
  List<Widget> inputFel = []; // Initialize as an empty list
  GetSettingModel? getSettingModel;

  int? selectedPaymentMethod;
  bool isShowPaymentMethod = false;

  CreateWithdrawRequestModel? createWithdrawRequestModel;
  String? currencySymbol;

  String autoCalculatedText = "0";

  @override
  Future<void> onInit() async {
    init();

    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    getSettingModel =
        await GetSettingApi.getSettingApi(uid: uid ?? "", token: token ?? "");

    currencySymbol = getSettingModel?.data?.currency?.symbol;
    log("currencySymbol => $currencySymbol");

    await CustomFetchUserCoin.init();
    update();
    update([AppConstant.onChangePaymentMethod]);
    super.onInit();
  }

  Future<void> init() async {
    await onGetWithdrawMethods();
    // CustomFetchUserCoin.init();
  }

  void calculateText(String input) {
    if (input.isEmpty) {
      autoCalculatedText = "0";
    } else {
      final minCoins = getSettingModel?.data?.minCoinsToConvert ?? 0;
      autoCalculatedText =
          minCoins > 0 ? "${int.parse(input) / minCoins}" : "0";
    }

    log("Calculated Text :: $autoCalculatedText");

    update([
      AppConstant.onChangePaymentMethod,
      AppConstant.onSwitchWithdrawMethod,
      AppConstant.getPaymentMethod
    ]);
  }

  Future<void> onGetWithdrawMethods() async {
    isLoading = true;
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();
    fetchWithdrawMethodModel =
        await GetPaymentMethodApi.callApi(token: token ?? "", uid: uid ?? "");
    if (fetchWithdrawMethodModel?.data != null) {
      withdrawMethods.addAll(fetchWithdrawMethodModel?.data ?? []);

      update([
        AppConstant.onChangePaymentMethod,
        AppConstant.onSwitchWithdrawMethod,
        AppConstant.getPaymentMethod
      ]);
    }
    isLoading = false;
  }

  Future<void> onSwitchWithdrawMethod() async {
    isShowPaymentMethod = !isShowPaymentMethod;
    update([
      AppConstant.onChangePaymentMethod,
      AppConstant.onSwitchWithdrawMethod,
      AppConstant.getPaymentMethod
    ]);
  }

  Future<void> onChangePaymentMethod(int index) async {
    selectedPaymentMethod = index;
    if (isShowPaymentMethod) {
      onSwitchWithdrawMethod();
    }

    details = withdrawMethods[index]
        .details
        ?.expand((detail) => detail.split(','))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // withdrawPaymentDetails = List<TextEditingController>.generate(
    //   details?.length ?? 0,
    //   (index) => TextEditingController(),
    // );
    withdrawPaymentDetails = details
            ?.map(
              (element) => TextEditingController(),
            )
            .toList() ??
        [];
    log("TextEditingController=>${withdrawPaymentDetails.length}");
    // data = details?.map((e) => TextEditingController()).toList();

    inputFel = details?.asMap().entries.map((entry) {
          int i = entry.key;
          String element = entry.value;

          return EnterGooglePayNumberFieldUi(
            title: element,
            controller1: withdrawPaymentDetails[i],
          );
        }).toList() ??
        [];

    update([
      AppConstant.onChangePaymentMethod,
      AppConstant.onSwitchWithdrawMethod,
      AppConstant.getPaymentMethod
    ]);
  }

  Future<void> onClickWithdraw() async {
    bool isWithdrawDetailsEmpty = false;
    for (int i = 0; i < withdrawPaymentDetails.length; i++) {
      if (withdrawPaymentDetails[i].text.isEmpty) {
        isWithdrawDetailsEmpty = true;
      } else {
        isWithdrawDetailsEmpty = false;
      }
    }

    if (autoCalculatedText == "0" ||
        autoCalculatedText == "0.0" ||
        autoCalculatedText.isEmpty) {
      Utils.showToast(EnumLocale.txtPleaseEnterWithdrawCoin.name.tr);
    } else if (num.parse(coinController.text) <
        (GetSettingApi.getSettingModel?.data?.minCoinsForHostPayout ?? 0)) {
      Utils.showToast(EnumLocale
          .txtWithdrawalRequestedCoinMustBeGreaterThanSpecifiedByTheAdmin
          .name
          .tr);
    } else if (int.parse(coinController.text) > Database.coin) {
      Utils.showToast(EnumLocale
          .txtTheUserDoesNotHaveSufficientFundsToMakeTheWithdrawal.name.tr);
    } else if (selectedPaymentMethod == null) {
      Utils.showToast(EnumLocale.txtPleaseSelectWithdrawMethod.name.tr);
    } else if (isWithdrawDetailsEmpty) {
      Utils.showToast(EnumLocale.txtPleaseEnterAllPaymentDetails.name.tr);
    } else {
      onWithdraw();
    }
  }

  Future<void> onWithdraw() async {
    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();
    Get.dialog(const LoadingWidget(),
        barrierDismissible: false); // Start Loading...

    // ✅ Build paymentDetails as Map<String, String>
    final Map<String, String> paymentDetailsMap = {};
    for (int i = 0; i < (details?.length ?? 0); i++) {
      paymentDetailsMap[details![i]] = withdrawPaymentDetails[i].text;
    }

    await 1.seconds.delay();

    log("paymentGateway => ${withdrawMethods[selectedPaymentMethod ?? 0].name ?? ""}");
    log("paymentDetails => $paymentDetailsMap");
    log("coin => ${coinController.text}");

    // ✅ API call
    createWithdrawRequestModel = await WithdrawalRequestApi.callApi(
      coin: coinController.text,
      paymentGateway: withdrawMethods[selectedPaymentMethod ?? 0].name ?? "",
      paymentDetails: paymentDetailsMap,
      token: token ?? '',
      uid: uid ?? '',
    );

    // ✅ Handle result
    log("status=>${createWithdrawRequestModel?.status}");
    if (createWithdrawRequestModel?.status ?? false) {
      Utils.showToast(createWithdrawRequestModel?.message ?? "");

      // ✅ Refresh coin balance after successful withdrawal
      await CustomFetchUserCoin.init();
      log("Coin refreshed after withdrawal: ${Database.coin}");
    } else {
      Utils.showToast(createWithdrawRequestModel?.message ?? "");
    }

    Get.back();
    Get.back();
  }
}
