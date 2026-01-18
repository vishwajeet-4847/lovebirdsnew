import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:LoveBirds/pages/splash_screen_page/api/get_setting_api.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class Utils {
  static void showLog(String text) => log(text);

  // >>>>> >>>>> Edit Profile Page <<<<< <<<<<
  static void showToast(String text, [Color? color]) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: color ?? AppColors.whiteColor,
      textColor: AppColors.blackColor,
      gravity: ToastGravity.BOTTOM,
    );
  }

  // >>>>> >>>>> RazorPay Payment Credential <<<<< <<<<<
  static String razorpaySecretKey =
      GetSettingApi.getSettingModel?.data?.razorpaySecretKey ?? "";
  static String currencyCode =
      GetSettingApi.getSettingModel?.data?.currency?.name ?? "";

  // >>>>> >>>>> Stripe Payment Credential <<<<< <<<<<
  static String stripeUrl = "https://api.stripe.com/v1/payment_intents";
  static String stripeSecretKey =
      GetSettingApi.getSettingModel?.data?.stripeSecretKey ?? "";
  static String stripeTestPublicKey =
      GetSettingApi.getSettingModel?.data?.stripePublishableKey ?? "";

  // >>>>> >>>>> Flutter Wave Credential <<<<< <<<<<
  static String flutterWaveId =
      GetSettingApi.getSettingModel?.data?.flutterwaveId ?? "";

  // >>>>> >>>>> Show Payment Method <<<<< <<<<<
  static final bool isShowStripePaymentMethod =
      GetSettingApi.getSettingModel?.data?.stripeEnabled ?? false;
  static final bool isShowRazorPayPaymentMethod =
      GetSettingApi.getSettingModel?.data?.razorpayEnabled ?? false;
  static final bool isShowFlutterWavePaymentMethod =
      GetSettingApi.getSettingModel?.data?.flutterwaveEnabled ?? false;
  static final bool isShowInAppPurchasePaymentMethod =
      GetSettingApi.getSettingModel?.data?.googlePlayEnabled ?? false;
  static final bool isShowPayStackAndroid =
      GetSettingApi.getSettingModel?.data?.paystackAndroidEnabled ?? false;
  static final bool isShowPayStackIos =
      GetSettingApi.getSettingModel?.data?.paystackIosEnabled ?? false;
  static final bool isShowPayPalAndroid =
      GetSettingApi.getSettingModel?.data?.paypalAndroidEnabled ?? false;
  static final bool isShowPayPalIos =
      GetSettingApi.getSettingModel?.data?.paypalIosEnabled ?? false;
  static final bool isShowCashFreeAndroid =
      GetSettingApi.getSettingModel?.data?.cashfreeAndroidEnabled ?? false;
  static final bool isShowCashFreeIos =
      GetSettingApi.getSettingModel?.data?.cashfreeIosEnabled ?? false;
  static final bool isShowRazorPayIos =
      GetSettingApi.getSettingModel?.data?.razorpayIosEnabled ?? false;
  static final bool isShowRazorPayAndroid =
      GetSettingApi.getSettingModel?.data?.razorpayEnabled ?? false;
  static final bool isShowStripeIos =
      GetSettingApi.getSettingModel?.data?.stripeIosEnabled ?? false;
  static final bool isShowStripeAndroid =
      GetSettingApi.getSettingModel?.data?.stripeEnabled ?? false;
  static final bool isShowFlutterWaveIos =
      GetSettingApi.getSettingModel?.data?.flutterwaveIosEnabled ?? false;
  static final bool isShowFlutterWaveAndroid =
      GetSettingApi.getSettingModel?.data?.flutterwaveEnabled ?? false;
  static final bool isShowGooglePayIos =
      GetSettingApi.getSettingModel?.data?.googlePayIosEnabled ?? false;
  static final bool isShowGooglePayAndroid =
      GetSettingApi.getSettingModel?.data?.googlePlayEnabled ?? false;

  static final String isShowCurrencySymbol =
      GetSettingApi.getSettingModel?.data?.currency?.symbol ?? "";

  /// =================== Clipboard (Copy Text) =================== ///
  static copyText(String text) {
    FlutterClipboard.copy(text);
  }

  /// =================== Status bar color =================== ///
  static void onChangeStatusBar({
    required Brightness brightness,
    int? delay,
  }) {
    showLog("Change Status Bar => Brightness => $brightness => $delay");
    Future.delayed(
      Duration(milliseconds: delay ?? 0),
      () => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: brightness,
        ),
      ),
    );
  }
}

extension HeightExtension on num {
  SizedBox get height => SizedBox(height: toDouble());
}

extension WidthExtension on num {
  SizedBox get width => SizedBox(width: toDouble());
}
