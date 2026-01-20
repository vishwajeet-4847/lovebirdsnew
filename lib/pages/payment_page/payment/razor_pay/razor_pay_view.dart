import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayService {
  static late Razorpay razorPay;
  static late String razorKeys;
  Callback onComplete = () {};

  void init({
    required String razorKey,
    required Callback callback,
  }) {
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    razorKeys = razorKey;
    onComplete = () => callback.call();
  }

  void razorPayCheckout(int amount) async {
    debugPrint("Payment Amount => $amount");
    var options = {
      'key': Utils.razorpaySecretKey,
      'amount': amount,
      'name': "Lovebirds",
      'theme.color': AppColors.primaryColor.value.toRadixString(16),
      'description': "Love Birds",
      'currency': Utils.currencyCode,
      'prefill': {
        'contact': "",
        'email': Database.fetchLoginUserProfileModel?.user?.email ?? ""
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorPay.open(options);
    } catch (e) {
      debugPrint("Razor Payment Error => ${e.toString()}");
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async =>
      onComplete.call();

  void handlePaymentError(PaymentFailureResponse response) {
    Utils.showLog("RazorPay Payment Failed !! => ${response.message}");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Utils.showLog(
        "RazorPay Payment External Wallet !! => ${response.walletName}");
  }
}
