import 'package:figgy/pages/splash_screen_page/api/get_setting_api.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/utils.dart';
import 'package:get/get.dart';
import 'package:incodes_payment/incodes_payment_services.dart';

import 'loading_widget.dart';


/// razor pay payment
Future<void> razorPay({
  required num amount,
  required Function() onPaymentSuccess,
}) async {
  Utils.showLog("Razorpay Payment (Incodes) starting...");
  Utils.showLog("Razorpay Payment (Incodes) starting...$amount");

  try {
    final razorKey =
        GetSettingApi.getSettingModel?.data?.razorpaySecretKey ?? '';
    final email = Database.email ;
    // Utils.showLog("customerName>>>>>>>>>>>>>>>>>>>>>>$customerName");
    Utils.showLog("email>>>>>>>>>>>>>>>>>>>>>>$email");
    Utils.showLog("Database.userName>>>>>>>>>>>>>>>>>>>>>>${Database.userName}");
    Utils.showLog("Database.email>>>>>>>>>>>>>>>>>>>>>>${Database.email}");


    // final contact = (Database.getUserProfileResponseModel?.user?.phoneNumber ??
    //     Database.getUserProfileResponseModel?.user?.phoneNumber ??
    //     "+91-0000000000");

    String toHex6(int argb) {
      final hex8 = argb.toRadixString(16).padLeft(8, '0');
      return '#${hex8.substring(2)}';
    }


    Utils.showLog("amount.toDouble()${amount.toDouble()}");
    final appName = EnumLocale.txtAppName.name.tr;
    final hexColor = toHex6(AppColors.primaryColor.hashCode);

    await IncodesPaymentServices.razorPayPayment(
      razorpayKey: razorKey.isNotEmpty ? razorKey : "",
      contactNumber: "+91-0000000000",
      emailId: email.toString(),
      amount: amount.toDouble(),
      appName: appName,
      colorCode: hexColor,

      onPaymentSuccess: onPaymentSuccess,
      onPaymentFailure: () {
        Utils.showToast( EnumLocale.txtPaymentFailedPleaseTryAgain.name.tr);
      },
      onExternalWallet: () {
        Utils.showLog("RazorPay External Wallet selected");
      },
    );
  } catch (e) {
    if (Get.isDialogOpen == true) Get.back();
    Utils.showLog("RazorPay Payment Failed => $e");
  }
}

/// stripe payment
Future<void> stripe({
  required num amount,
  required Function()? onPaymentSuccess,
}) async {
  try {
    Utils.showLog("Stripe Payment (Incodes) starting...");

    final publishableKey =
        GetSettingApi.getSettingModel?.data?.stripePublishableKey ?? "";

    final secretKey =
        GetSettingApi.getSettingModel?.data?.stripeSecretKey ?? "";

    final currency =
        // GetSettingApi.getSettingModel?.data?.currency?.currencyCode ??

            "INR";

    final merchantDisplayName = EnumLocale.txtAppName.name.tr;

    final merchantCountryCode = "IN";
    final merchantCountryCode1 = GetSettingApi.getSettingModel?.data?.currency?.currencyCode ?? "IN";

    final int minorAmount = (amount * 100).toInt();

    await IncodesPaymentServices.stripePayment(
      amount: minorAmount,
      currency: currency,
      isTest: true,
      merchantCountryCode: merchantCountryCode,
      merchantDisplayName: merchantDisplayName,
      publishableKey: publishableKey,
      secretKey: secretKey,
      onPaymentSuccess: onPaymentSuccess,
      onPaymentFailure: () {
        Utils.showToast( EnumLocale.txtPaymentFailedPleaseTryAgain.name.tr);
      },
    );

    Utils.showLog("Stripe payment flow finished (returned).");
  } catch (e) {
    if (Get.isDialogOpen == true) Get.back();
    Utils.showLog("Stripe Payment Failed !! => $e");
  }
}

/// flutter wave payment
Future<void> flutterWave({
  required num amount,
  required Function()? onPaymentSuccess,
}) async {
  Utils.showLog("Flutterwave Payment (Incodes) starting...");
  try {
    Get.dialog(const LoadingWidget(), barrierDismissible: false);
    await 400.milliseconds.delay();
    if (Get.isDialogOpen == true) Get.back();

    final settingsKey =
        GetSettingApi.getSettingModel?.data?.flutterwaveId;
    final publicKey =
        (settingsKey != null && settingsKey.isNotEmpty) ? settingsKey : "";

    final currency =  "NGN";
    // final currency = GetSettingApi.getSettingModel?.data?.currency?.currencyCode ?? "NGN";
    final customerName = Database.userName ?? "User";
    final customerEmail = Database.email;

    Utils.showLog("customerName>>>>>>>>>>>>>>>>>>>>>>$customerName");
    Utils.showLog("customerEmail>>>>>>>>>>>>>>>>>>>>>>$customerEmail");
    Utils.showLog("currency>>>>>>>>>>>>>>>>>>>>>>$currency");
    Utils.showLog("publicKey>>>>>>>>>>>>>>>>>>>>>>$publicKey");

    await IncodesPaymentServices.flutterWavePayment(
      context: Get.context!,
      publicKey: publicKey,
      currency: currency,
      amount: amount.toString(),
      customerName: customerName,
      customerEmail: customerEmail.toString(),
      onPaymentSuccess: onPaymentSuccess,
      onPaymentFailure: () {
        Utils.showToast( EnumLocale.txtPaymentFailedPleaseTryAgain.name.tr);
      },
    );

    Utils.showLog("Flutterwave payment flow finished.");
  } catch (e) {
    if (Get.isDialogOpen == true) Get.back();
    Utils.showLog("Flutterwave Payment Failed => $e");
  }
}

///pay stack payment
Future<void> payStack({
  required num amount,
  required Function()? onPaymentSuccess,
}) async {
  Utils.showLog("Paystack Payment (Incodes) starting...");
  try {
    Get.dialog(const LoadingWidget(), barrierDismissible: false);
    await 400.milliseconds.delay();
    if (Get.isDialogOpen == true) Get.back();

    // final settingsSecret =
    //     GetSettingApi.getSettingModel?.data?.flutterwaveId;
    // final secretKey = (settingsSecret != null && settingsSecret.isNotEmpty)
    //     ? settingsSecret
    //     : "";
    final settingsSecret =
        GetSettingApi.getSettingModel?.data?.flutterwaveId;
    final secretKey = "sk_test_82ab2cf5ee273c492e97ffbc9230d32f697d8877";

    final customerEmail = Database.fetchLoginUserProfileModel?.user?.email ?? "test@gmail.com";

    // final currency =
    //     Database.settingApiResponseModel?.data?.currency?.currencyCode ?? "NGN";

    final currency =
         "NGN";

    final int majorAmount = amount.toInt();

    await IncodesPaymentServices.payStackPayment(
      context: Get.context!,
      secretKey: secretKey,
      customerEmail: customerEmail.toString(),
      amount: majorAmount,
      currency: currency,
      onPaymentSuccess: onPaymentSuccess,
      onPaymentFailure: () {
        Utils.showToast( EnumLocale.txtPaymentFailedPleaseTryAgain.name.tr);

      },
    );

    Utils.showLog("Paystack payment flow finished.");
  } catch (e) {
    if (Get.isDialogOpen == true) Get.back();
    Utils.showLog("Paystack Payment Failed => $e");
  }
}

///pay pal payment
Future<void> payPal({
  required num amount,

  required Function()? onPaymentSuccess,
}) async {
  Utils.showLog("PayPal Payment (Incodes) starting...");
  try {
    Get.dialog(const LoadingWidget(), barrierDismissible: false);
    await 400.milliseconds.delay();
    if (Get.isDialogOpen == true) Get.back();

    // final currency = GetSettingApi.getSettingModel?.data?.currency?.currencyCode ??"USD";
    final currency = "USD";


    final paypalClientId = "AdafNSOlaLaavLWrfJhW6AyJx5PfrwdYyechxcyNGpmDwfyQNvxVs8PMwduh27sPQ4whrWWdwidbpkM3";
    final secretKey = "EAAH2JkOBAnGOgRE8oWNYj7LcK7u2yVgplk9aXCZIeusx8BZdeP6P0DB3sppbJ-wNE7XzlFU226RknW6";


    await IncodesPaymentServices.paypalPayment(
      context: Get.context!,
      clientId: paypalClientId.toString(),
      secretKey: secretKey.toString(),
      transactions: [
        {
          "amount": {
            "total": amount.toString(),
            "currency": currency,
            "details": {
              "subtotal": amount.toString(),
              "shipping": '0',
              "shipping_discount": 0
            },
          },
          "description": "Subscription purchase via PayPal",
          "item_list": {
            "items": [
              {
                "name": "Subscription Plan",
                "quantity": 1,
                "price": amount.toString(),
                "currency": currency,
              },
            ],
          },
        },
      ],
      onPaymentSuccess: onPaymentSuccess,
      onPaymentFailure: () {
        Utils.showToast( EnumLocale.txtPaymentFailedPleaseTryAgain.name.tr);

      },
    );

    Utils.showLog("PayPal payment flow finished.");
  } catch (e) {
    if (Get.isDialogOpen == true) Get.back();
    Utils.showLog("PayPal Payment Failed => $e");
  }
}

///in app purchase payment
Future<void> inAppPurchase({
  required num amount,
  required Function()? onPaymentSuccess,
}) async {
  Utils.showLog("InAppPurchase Payment (Incodes) starting...");
  try {
    Get.dialog(const LoadingWidget(), barrierDismissible: false);
    await 400.milliseconds.delay();
    if (Get.isDialogOpen == true) Get.back();

    final productId = "com.android.coin100";
    final userId =
        Database.fetchLoginUserProfileModel?.user?.id.toString() ?? "123456";

    await IncodesPaymentServices.inAppPurchasePayment(
      userId: userId,
      productIds: [productId],
      amount: amount.toDouble(),
      onPaymentSuccess: onPaymentSuccess,
      onPaymentFailure: () {
        Utils.showToast( EnumLocale.txtPaymentFailedPleaseTryAgain.name.tr);

      },
    );

    Utils.showLog("InAppPurchase payment flow finished.");
  } catch (e) {
    if (Get.isDialogOpen == true) Get.back();
    Utils.showLog("InAppPurchase Payment Failed => $e");
  }
}

///cash free payment
Future<void> cashFree({
  required num amount,
  required Function()? onPaymentSuccess,
}) async {
  Utils.showLog("CashFree Payment (Incodes) starting...");
  try {
    Get.dialog(const LoadingWidget(), barrierDismissible: false);
    await 400.milliseconds.delay();
    if (Get.isDialogOpen == true) Get.back();

    final customerName =
        Database.userName ?? "John";
    final customerEmail =
    Database.email ;
    // final customerPhone =
    //     Database.fetchLoginUserProfileModel?.user?.phoneNumber ?? "9876543210";

    Utils.showLog("Database.getUserProfileResponseModel?.user?.phoneNumber${9876543210}");

    final cashfreeClientId = "TEST430329ae80e0f32e41a393d78b923034";
    final cashfreeSecretKey = "TESTaf195616268bd6202eeb3bf8dc458956e7192a85";

final currency ="INR";
// final currency =GetSettingApi.getSettingModel?.data?.currency?.currencyCode ??"INR";

    await IncodesPaymentServices.cashFreePayment(
      context: Get.context!,
      clientId: cashfreeClientId.toString(),
      clientSecret: cashfreeSecretKey.toString(),
      amount: amount.toDouble(),
      currency: currency,
      customerName: customerName,
      customerEmail: customerEmail.toString(),
      customerPhone: "9876543210",
      paymentGatewayName: "Cashfree",
      onPaymentSuccess: onPaymentSuccess,
      onPaymentFailure: () {
        Utils.showToast( EnumLocale.txtPaymentFailedPleaseTryAgain.name.tr);

      },
    );

    Utils.showLog("CashFree payment flow finished.");
  } catch (e) {
    if (Get.isDialogOpen == true) Get.back();
    Utils.showLog("CashFree Payment Failed => $e");
  }
}
