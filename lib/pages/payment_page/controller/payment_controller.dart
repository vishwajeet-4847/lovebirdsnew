import 'dart:developer';
import 'dart:io';

import 'package:figgy/common/common_payment.dart';
import 'package:figgy/common/loading_widget.dart';
import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/payment_page/api/purchase_coin_plan_api.dart';
import 'package:figgy/pages/payment_page/api/purchase_vip_plan_api.dart';
import 'package:figgy/pages/payment_page/payment/flutter_wave/flutter_wave_services.dart';
import 'package:figgy/pages/payment_page/payment/in_app_purchase/iap_callback.dart';
import 'package:figgy/pages/payment_page/payment/in_app_purchase/in_app_purchase_helper.dart';
import 'package:figgy/pages/payment_page/payment/razor_pay/razor_pay_view.dart';
import 'package:figgy/pages/payment_page/payment/stripe/stripe_service.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/utils.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentScreenController extends GetxController implements IAPCallback {
  String coinPlanId = "";
  num coinAmount = 0;
  String productKey = "";
  bool isVip = false;

  Map<String, PurchaseDetails>? purchases;
  int selectedPaymentMethod = 0;

  @override
  void onInit() {
    Utils.showLog("Selected Plan => ${Get.arguments}");
    if (Get.arguments != null) {
      coinPlanId = Get.arguments["id"];
      coinAmount = Get.arguments["amount"];
      isVip = Get.arguments["isVip"];
      productKey = Get.arguments["productKey"];
    }



    log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${Utils.isShowCashFreeIos}");
    log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${Utils.isShowCashFreeAndroid}");
    super.onInit();
  }

  final paymentMethodList = [
    {"icon": AppAsset.icRazorPayLogo, "title": "Razor Pay", "size": "35.0"},
    {"icon": AppAsset.icStripeLogo, "title": "Stripe", "size": "35.0"},
    {"icon": AppAsset.icFlutterWaveLogo, "title": "Flutter Wave", "size": "30"},
    {"icon": Platform.isIOS ? AppAsset.icAppleIcon : AppAsset.icGoogle, "title": "In App Purchase", "size": "30"},
    {"icon": AppAsset.paypal, "title": "PayPal", "size": "35"},
    {"icon": AppAsset.payStack, "title": "Pay Stack", "size": "35"},
    {"icon": AppAsset.cashFree, "title": "CashFree", "size": "35"},
  ];

  void onChangePaymentMethod(int index) async {
    selectedPaymentMethod = index;
    update([AppConstant.onChangePaymentMethod]);
  }

  Future<void> onClickPayNow() async {
    // >>>>> >>>>> >>>>> RazorPay Payment <<<<< <<<<< <<<<<

    if (selectedPaymentMethod == 0) {
      Utils.showLog("Razorpay Payment Working....");

      try {
        Get.dialog(const LoadingWidget(), barrierDismissible: false);

        // Start Loading...
        // RazorPayService().init(
        //   razorKey: Utils.razorpaySecretKey,
        //   callback: () async {
        //     Utils.showLog("RazorPay Payment Successfully");
        //
        //     Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
        //
        //     final uid = FirebaseUid.onGet();
        //     final token = await FirebaseAccessToken.onGet();
        //
        //     final isSuccess = isVip
        //         ? await PurchaseVipPlanApi.callApi(
        //             token: token ?? '',
        //             uid: uid ?? '',
        //             vipPlanId: coinPlanId,
        //             paymentGateway: "Razorpay",
        //           )
        //         : await PurchaseCoinPlanApi.callApi(
        //             coinPlanId: coinPlanId,
        //             token: token ?? '',
        //             uid: uid ?? '',
        //             paymentGateway: "Razorpay",
        //           );
        //
        //     Get.back(); // Stop Loading...
        //     if (isSuccess != null) {
        //       Get.close(2);
        //     }
        //   },
        // );

       razorPay(amount: coinAmount,onPaymentSuccess: () async {
         Utils.showLog("RazorPay Payment Successfully");

         Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

         final uid = FirebaseUid.onGet();
         final token = await FirebaseAccessToken.onGet();

         final isSuccess = isVip
             ? await PurchaseVipPlanApi.callApi(
           token: token ?? '',
           uid: uid ?? '',
           vipPlanId: coinPlanId,
           paymentGateway: "Razorpay",
         )
             : await PurchaseCoinPlanApi.callApi(
           coinPlanId: coinPlanId,
           token: token ?? '',
           uid: uid ?? '',
           paymentGateway: "Razorpay",
         );

         Get.back(); // Stop Loading...
         if (isSuccess != null) {
           Get.close(2);
         }
       },);
        await 1.seconds.delay();
        RazorPayService().razorPayCheckout((coinAmount * 100).toInt());
        Get.back(); // Stop Loading...
      } catch (e) {
        Get.back(); // Stop Loading...
        Utils.showLog("RazorPay Payment Failed => $e");
      }
    }

    // >>>>> >>>>> >>>>> Stripe Payment <<<<< <<<<< <<<<<

    if (selectedPaymentMethod == 1) {
      try {
        Utils.showLog("Stripe Payment Working...");
        Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
        // await StripeService().init(isTest: true);
        await 1.seconds.delay();
        // StripeService()
        //     .stripePay(
        //   amount: (coinAmount * 100).toInt(),
        //   callback: () async {
        //     Utils.showLog("Stripe Payment Success Method Called....");
        //     Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
        //
        //     final uid = FirebaseUid.onGet();
        //     final token = await FirebaseAccessToken.onGet();
        //
        //     final isSuccess = isVip
        //         ? await PurchaseVipPlanApi.callApi(
        //             token: token ?? '',
        //             uid: uid ?? '',
        //             vipPlanId: coinPlanId,
        //             paymentGateway: "Stripe",
        //           )
        //         : await PurchaseCoinPlanApi.callApi(
        //             coinPlanId: coinPlanId,
        //             token: token ?? '',
        //             uid: uid ?? '',
        //             paymentGateway: "Stripe",
        //           );
        //
        //     Get.back(); // Stop Loading...
        //     if (isSuccess != null) {
        //       Get.close(2);
        //     }
        //   },
        // )

        stripe(amount: coinAmount, onPaymentSuccess:  () async {
          Utils.showLog("Stripe Payment Success Method Called....");
          Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

          final uid = FirebaseUid.onGet();
          final token = await FirebaseAccessToken.onGet();

          final isSuccess = isVip
              ? await PurchaseVipPlanApi.callApi(
            token: token ?? '',
            uid: uid ?? '',
            vipPlanId: coinPlanId,
            paymentGateway: "Stripe",
          )
              : await PurchaseCoinPlanApi.callApi(
            coinPlanId: coinPlanId,
            token: token ?? '',
            uid: uid ?? '',
            paymentGateway: "Stripe",
          );

          Get.back(); // Stop Loading...
          if (isSuccess != null) {
            Get.close(2);
          }
        },)
            .then((value) async {
          Utils.showLog("Stripe Payment Successfully");
        }).catchError((e) {
          Utils.showLog("Stripe Payment Error !!!");
        });
        Get.back(); // Stop Loading...
      } catch (e) {
        Get.back(); // Stop Loading...
        Utils.showLog("Stripe Payment Failed !! => $e");
      }
    }

    // >>>>> >>>>> >>>>> Flutter Wave Payment <<<<< <<<<< <<<<<

    if (selectedPaymentMethod == 2) {
      Utils.showLog("Flutter Wave Payment Working....");

      try {
        Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

        // FlutterWaveService.init(
        //   amount: coinAmount.toString(),
        //   onPaymentComplete: () async {
        //     Utils.showLog("Flutter Wave Payment Successfully");
        //
        //     Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
        //
        //     final uid = FirebaseUid.onGet();
        //     final token = await FirebaseAccessToken.onGet();
        //
        //     final isSuccess = isVip
        //         ? await PurchaseVipPlanApi.callApi(
        //             token: token ?? '',
        //             uid: uid ?? '',
        //             vipPlanId: coinPlanId,
        //             paymentGateway: "Flutter wave",
        //           )
        //         : await PurchaseCoinPlanApi.callApi(
        //             coinPlanId: coinPlanId,
        //             token: token ?? '',
        //             uid: uid ?? '',
        //             paymentGateway: "Flutter wave",
        //           );
        //
        //     Get.back(); // Stop Loading...
        //     if (isSuccess != null) {
        //       Get.close(2);
        //     }
        //   },
        // );

        flutterWave(amount: coinAmount, onPaymentSuccess: () async {
              Utils.showLog("Flutter Wave Payment Successfully");

              Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

              final uid = FirebaseUid.onGet();
              final token = await FirebaseAccessToken.onGet();

              final isSuccess = isVip
                  ? await PurchaseVipPlanApi.callApi(
                      token: token ?? '',
                      uid: uid ?? '',
                      vipPlanId: coinPlanId,
                      paymentGateway: "Flutter wave",
                    )
                  : await PurchaseCoinPlanApi.callApi(
                      coinPlanId: coinPlanId,
                      token: token ?? '',
                      uid: uid ?? '',
                      paymentGateway: "Flutter wave",
                    );

              Get.back(); // Stop Loading...
              if (isSuccess != null) {
                Get.close(2);
              }
            },);

        Get.back(); // Stop Loading...
      } catch (e) {
        Get.back(); // Stop Loading...
        Utils.showLog("Flutter Wave Payment Failed => $e");
      }
    }

    // >>>>> >>>>> >>>>> In App Payment Payment <<<<< <<<<< <<<<<

    if (selectedPaymentMethod == 3) {
      Utils.showLog("In App Purchase Payment Working....");

      List<String> kProductIds = <String>[productKey];

      Utils.showLog("Starting IAP with product: $productKey");

      try {
        Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

        // await InAppPurchaseHelper().init(
        //   paymentType: "In App Purchase",
        //   userId: Database.loginUserId,
        //   productKey: kProductIds,
        //   rupee: coinAmount.toDouble(),
        //   callBack: () async {
        //     Utils.showLog("In App Purchase Payment Successfully");
        //   },
        // );

        inAppPurchase(amount: coinAmount, onPaymentSuccess: () async {
              Utils.showLog("In App Purchase Payment Successfully");
            },);

        // Add debug logging
        // await InAppPurchaseHelper().debugProductLoading();
        //
        // InAppPurchaseHelper().initStoreInfo();
        // await Future.delayed(const Duration(seconds: 3)); // Increased delay
        //
        // ProductDetails? product = InAppPurchaseHelper().getProductDetail(productKey);
        //
        // if (product != null) {
        //   Utils.showLog("Product found: ${product.title} - ${product.price}");
        //   InAppPurchaseHelper().buySubscription(product, purchases!);
        // } else {
        //   Utils.showToast("Product not found: $productKey");
        //   Utils.showLog("Available products: ${InAppPurchaseHelper().getAvailableProducts()}");
        // }

        Get.back(); // Stop Loading...
      } catch (e) {
        Get.back(); // Stop Loading...
        Utils.showLog("Flutter Wave Payment Failed => $e");
      }
    }


    // >>>>> >>>>> >>>>> pay pal Payment <<<<< <<<<< <<<<<

    if (selectedPaymentMethod == 4) {
      Utils.showLog("pay pal Payment Working....");

      try {
        Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

        payPal(amount: coinAmount, onPaymentSuccess: () async {
              Utils.showLog("pay pal Payment Successfully");

              Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

              final uid = FirebaseUid.onGet();
              final token = await FirebaseAccessToken.onGet();

              final isSuccess = isVip
                  ? await PurchaseVipPlanApi.callApi(
                      token: token ?? '',
                      uid: uid ?? '',
                      vipPlanId: coinPlanId,
                      paymentGateway: "Pay Pal",
                    )
                  : await PurchaseCoinPlanApi.callApi(
                      coinPlanId: coinPlanId,
                      token: token ?? '',
                      uid: uid ?? '',
                      paymentGateway: "Pay Pal",
                    );

              Get.back(); // Stop Loading...
              if (isSuccess != null) {
                Get.close(2);
              }
            },);

        Get.back(); // Stop Loading...
      } catch (e) {
        Get.back(); // Stop Loading...
        Utils.showLog("pay pal Payment Failed => $e");
      }
    }


    // >>>>> >>>>> >>>>> pay stack Payment <<<<< <<<<< <<<<<

    if (selectedPaymentMethod == 5) {
      Utils.showLog("pay stack Payment Working....");

      try {
        Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

        payStack(amount: coinAmount, onPaymentSuccess: () async {
          Utils.showLog("pay stack Payment Successfully");

          Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

          final uid = FirebaseUid.onGet();
          final token = await FirebaseAccessToken.onGet();

          final isSuccess = isVip
              ? await PurchaseVipPlanApi.callApi(
            token: token ?? '',
            uid: uid ?? '',
            vipPlanId: coinPlanId,
            paymentGateway: "Pay Stack",
          )
              : await PurchaseCoinPlanApi.callApi(
            coinPlanId: coinPlanId,
            token: token ?? '',
            uid: uid ?? '',
            paymentGateway: "Pay Stack",
          );

          Get.back(); // Stop Loading...
          if (isSuccess != null) {
            Get.close(2);
          }
        },);

        Get.back(); // Stop Loading...
      } catch (e) {
        Get.back(); // Stop Loading...
        Utils.showLog("pay stack Payment Failed => $e");
      }
    }

    // >>>>> >>>>> >>>>> cash free Payment <<<<< <<<<< <<<<<

    if (selectedPaymentMethod == 6) {
      Utils.showLog("cash free Payment Working....");

      try {
        Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

        cashFree(amount: coinAmount, onPaymentSuccess: () async {
          Utils.showLog("cash free Payment Successfully");

          Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

          final uid = FirebaseUid.onGet();
          final token = await FirebaseAccessToken.onGet();

          final isSuccess = isVip
              ? await PurchaseVipPlanApi.callApi(
            token: token ?? '',
            uid: uid ?? '',
            vipPlanId: coinPlanId,
            paymentGateway: "Cash Free",
          )
              : await PurchaseCoinPlanApi.callApi(
            coinPlanId: coinPlanId,
            token: token ?? '',
            uid: uid ?? '',
            paymentGateway: "Cash Free",
          );

          Get.back(); // Stop Loading...
          if (isSuccess != null) {
            Get.close(2);
          }
        },);

        Get.back(); // Stop Loading...
      } catch (e) {
        Get.back(); // Stop Loading...
        Utils.showLog("pay pal Payment Failed => $e");
      }
    }



  }

  @override
  void onBillingError(error) {
    Utils.showLog("IAP Billing Error: $error");
    Utils.showToast("Payment failed: $error");
  }

  @override
  void onLoaded(bool initialized) {
    Utils.showLog("IAP Loaded: $initialized");
  }

  @override
  void onPending(PurchaseDetails product) {
    Utils.showLog("IAP Pending: ${product.productID}");
    Utils.showToast("Payment is pending...");
  }

  @override
  void onSuccessPurchase(PurchaseDetails product) async {
    Utils.showLog("IAP Success: ${product.productID}");

    try {
      Get.dialog(const LoadingWidget(), barrierDismissible: false);

      final token = await FirebaseAccessToken.onGet();
      final uid = FirebaseUid.onGet();

      final isSuccess = isVip
          ? await PurchaseVipPlanApi.callApi(
              token: token ?? '',
              uid: uid ?? '',
              vipPlanId: coinPlanId,
              paymentGateway: "In App Purchase",
            )
          : await PurchaseCoinPlanApi.callApi(
              coinPlanId: coinPlanId,
              token: token ?? '',
              uid: uid ?? '',
              paymentGateway: "In App Purchase",
            );

      // Hide loading dialog
      Get.back();

      if (isSuccess?.status == true) {
        Utils.showToast(EnumLocale.txtCoinRechargeSuccess.name.tr);
        Get.close(2); // Close payment screens
      } else {
        Utils.showToast(EnumLocale.txtSomeThingWentWrong.name.tr);
      }
    } catch (e) {
      // Hide loading dialog if there's an error
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      Utils.showLog("API call failed: $e");
      Utils.showToast(EnumLocale.txtSomeThingWentWrong.name.tr);
    }
  }
}
