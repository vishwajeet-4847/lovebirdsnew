// To parse this JSON data, do
//
//     final getSettingModel = getSettingModelFromJson(jsonString);

import 'dart:convert';

GetSettingModel getSettingModelFromJson(String str) =>
    GetSettingModel.fromJson(json.decode(str));

String getSettingModelToJson(GetSettingModel data) =>
    json.encode(data.toJson());

class GetSettingModel {
  bool? status;
  String? message;
  Data? data;

  GetSettingModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetSettingModel.fromJson(Map<String, dynamic> json) =>
      GetSettingModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Currency? currency;
  String? id;
  String? privacyPolicyLink;
  String? termsOfUsePolicyLink;
  bool? googlePlayEnabled;
  bool? stripeEnabled;
  String? stripePublishableKey;
  String? stripeSecretKey;
  bool? razorpayEnabled;
  String? razorpayId;
  String? razorpaySecretKey;
  bool? flutterwaveEnabled;
  String? flutterwaveId;
  int? loginBonus;
  bool? isDemoData;
  int? minCoinsToConvert;
  int? minCoinsForUserPayout;
  int? minCoinsForHostPayout;
  int? minCoinsForAgencyPayout;
  int? maxFreeChatMessages;
  PrivateKey? privateKey;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? adminCommissionRate;
  String? agoraAppCertificate;
  String? agoraAppId;
  int? audioPrivateCallRate;
  int? chatInteractionRate;
  int? femaleRandomCallRate;
  int? generalRandomCallRate;
  bool? isAppEnabled;
  int? maleRandomCallRate;
  int? videoPrivateCallRate;
  int? callInitiatedAt;
  int? messageInitiatedAt;
  bool? isAutoRefreshEnabled;
  bool? cashfreeAndroidEnabled;
  String? cashfreeClientId;
  String? cashfreeClientSecret;
  bool? cashfreeIosEnabled;
  bool? paypalAndroidEnabled;
  String? paypalClientId;
  bool? paypalIosEnabled;
  String? paypalSecretKey;
  bool? paystackAndroidEnabled;
  bool? paystackIosEnabled;
  String? paystackPublicKey;
  String? paystackSecretKey;
  bool? flutterwaveIosEnabled;
  bool? googlePayIosEnabled;
  bool? razorpayIosEnabled;
  bool? stripeIosEnabled;

  Data({
    this.currency,
    this.id,
    this.privacyPolicyLink,
    this.termsOfUsePolicyLink,
    this.googlePlayEnabled,
    this.stripeEnabled,
    this.stripePublishableKey,
    this.stripeSecretKey,
    this.razorpayEnabled,
    this.razorpayId,
    this.razorpaySecretKey,
    this.flutterwaveEnabled,
    this.flutterwaveId,
    this.loginBonus,
    this.isDemoData,
    this.minCoinsToConvert,
    this.minCoinsForUserPayout,
    this.minCoinsForHostPayout,
    this.minCoinsForAgencyPayout,
    this.maxFreeChatMessages,
    this.privateKey,
    this.createdAt,
    this.updatedAt,
    this.adminCommissionRate,
    this.agoraAppCertificate,
    this.agoraAppId,
    this.audioPrivateCallRate,
    this.chatInteractionRate,
    this.femaleRandomCallRate,
    this.generalRandomCallRate,
    this.isAppEnabled,
    this.maleRandomCallRate,
    this.videoPrivateCallRate,
    this.callInitiatedAt,
    this.messageInitiatedAt,
    this.isAutoRefreshEnabled,
    this.cashfreeAndroidEnabled,
    this.cashfreeClientId,
    this.cashfreeClientSecret,
    this.cashfreeIosEnabled,
    this.paypalAndroidEnabled,
    this.paypalClientId,
    this.paypalIosEnabled,
    this.paypalSecretKey,
    this.paystackAndroidEnabled,
    this.paystackIosEnabled,
    this.paystackPublicKey,
    this.paystackSecretKey,
    this.flutterwaveIosEnabled,
    this.googlePayIosEnabled,
    this.razorpayIosEnabled,
    this.stripeIosEnabled,
  });

  // factory Data.fromJson(Map<String, dynamic> json) => Data(
  //       currency: json["currency"] == null
  //           ? null
  //           : Currency.fromJson(json["currency"]),
  //       id: json["_id"],
  //       privacyPolicyLink: json["privacyPolicyLink"],
  //       termsOfUsePolicyLink: json["termsOfUsePolicyLink"],
  //       googlePlayEnabled: json["googlePlayEnabled"],
  //       stripeEnabled: json["stripeEnabled"],
  //       stripePublishableKey: json["stripePublishableKey"],
  //       stripeSecretKey: json["stripeSecretKey"],
  //       razorpayEnabled: json["razorpayEnabled"],
  //       razorpayId: json["razorpayId"],
  //       razorpaySecretKey: json["razorpaySecretKey"],
  //       flutterwaveEnabled: json["flutterwaveEnabled"],
  //       flutterwaveId: json["flutterwaveId"],
  //       loginBonus: json["loginBonus"],
  //       isDemoData: json["isDemoData"],
  //       minCoinsToConvert: json["minCoinsToConvert"],
  //       minCoinsForUserPayout: json["minCoinsForUserPayout"],
  //       minCoinsForHostPayout: json["minCoinsForHostPayout"],
  //       minCoinsForAgencyPayout: json["minCoinsForAgencyPayout"],
  //       maxFreeChatMessages: json["maxFreeChatMessages"],
  //       privateKey: json["privateKey"] == null
  //           ? null
  //           : PrivateKey.fromJson(json["privateKey"]),
  //       createdAt: json["createdAt"] == null
  //           ? null
  //           : DateTime.parse(json["createdAt"]),
  //       updatedAt: json["updatedAt"] == null
  //           ? null
  //           : DateTime.parse(json["updatedAt"]),
  //       adminCommissionRate: json["adminCommissionRate"],
  //       agoraAppCertificate: json["agoraAppCertificate"],
  //       agoraAppId: json["agoraAppId"],
  //       audioPrivateCallRate: json["audioPrivateCallRate"],
  //       chatInteractionRate: json["chatInteractionRate"],
  //       femaleRandomCallRate: json["femaleRandomCallRate"],
  //       generalRandomCallRate: json["generalRandomCallRate"],
  //       isAppEnabled: json["isAppEnabled"],
  //       maleRandomCallRate: json["maleRandomCallRate"],
  //       videoPrivateCallRate: json["videoPrivateCallRate"],
  //       callInitiatedAt: json["callInitiatedAt"],
  //       messageInitiatedAt: json["messageInitiatedAt"],
  //       isAutoRefreshEnabled: json["isAutoRefreshEnabled"],
  //       cashfreeAndroidEnabled: json["cashfreeAndroidEnabled"],
  //       cashfreeClientId: json["cashfreeClientId"],
  //       cashfreeClientSecret: json["cashfreeClientSecret"],
  //       cashfreeIosEnabled: json["cashfreeIosEnabled"],
  //       paypalAndroidEnabled: json["paypalAndroidEnabled"],
  //       paypalClientId: json["paypalClientId"],
  //       paypalIosEnabled: json["paypalIosEnabled"],
  //       paypalSecretKey: json["paypalSecretKey"],
  //       paystackAndroidEnabled: json["paystackAndroidEnabled"],
  //       paystackIosEnabled: json["paystackIosEnabled"],
  //       paystackPublicKey: json["paystackPublicKey"],
  //       paystackSecretKey: json["paystackSecretKey"],
  //       flutterwaveIosEnabled: json["flutterwaveIosEnabled"],
  //       googlePayIosEnabled: json["googlePayIosEnabled"],
  //       razorpayIosEnabled: json["razorpayIosEnabled"],
  //       stripeIosEnabled: json["stripeIosEnabled"],
  //     );

  factory Data.fromJson(Map<String, dynamic> json) {
    print("📦 [Data.fromJson] Parsing Data object...");

    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    return Data(
      currency:
          json["currency"] == null ? null : Currency.fromJson(json["currency"]),
      id: json["_id"],
      privacyPolicyLink: json["privacyPolicyLink"],
      termsOfUsePolicyLink: json["termsOfUsePolicyLink"],
      googlePlayEnabled: json["googlePlayEnabled"],
      stripeEnabled: json["stripeEnabled"],
      stripePublishableKey: json["stripePublishableKey"],
      stripeSecretKey: json["stripeSecretKey"],
      razorpayEnabled: json["razorpayEnabled"],
      razorpayId: json["razorpayId"],
      razorpaySecretKey: json["razorpaySecretKey"],
      flutterwaveEnabled: json["flutterwaveEnabled"],
      flutterwaveId: json["flutterwaveId"],
      loginBonus: parseInt(json["loginBonus"]),
      isDemoData: json["isDemoData"],
      minCoinsToConvert: parseInt(json["minCoinsToConvert"]),
      minCoinsForUserPayout: parseInt(json["minCoinsForUserPayout"]),
      minCoinsForHostPayout: parseInt(json["minCoinsForHostPayout"]),
      minCoinsForAgencyPayout: parseInt(json["minCoinsForAgencyPayout"]),
      maxFreeChatMessages: parseInt(json["maxFreeChatMessages"]),
      privateKey: json["privateKey"] == null
          ? null
          : PrivateKey.fromJson(json["privateKey"]),
      createdAt: json["createdAt"] == null
          ? null
          : DateTime.tryParse(json["createdAt"]),
      updatedAt: json["updatedAt"] == null
          ? null
          : DateTime.tryParse(json["updatedAt"]),
      adminCommissionRate: parseInt(json["adminCommissionRate"]),
      agoraAppCertificate: json["agoraAppCertificate"],
      agoraAppId: json["agoraAppId"],
      audioPrivateCallRate: parseInt(json["audioPrivateCallRate"]),
      chatInteractionRate: parseInt(json["chatInteractionRate"]),
      femaleRandomCallRate: parseInt(json["femaleRandomCallRate"]),
      generalRandomCallRate: parseInt(json["generalRandomCallRate"]),
      isAppEnabled: json["isAppEnabled"],
      maleRandomCallRate: parseInt(json["maleRandomCallRate"]),
      videoPrivateCallRate: parseInt(json["videoPrivateCallRate"]),
      callInitiatedAt: parseInt(json["callInitiatedAt"]),
      messageInitiatedAt: parseInt(json["messageInitiatedAt"]),
      isAutoRefreshEnabled: json["isAutoRefreshEnabled"],
      cashfreeAndroidEnabled: json["cashfreeAndroidEnabled"],
      cashfreeClientId: json["cashfreeClientId"],
      cashfreeClientSecret: json["cashfreeClientSecret"],
      cashfreeIosEnabled: json["cashfreeIosEnabled"],
      paypalAndroidEnabled: json["paypalAndroidEnabled"],
      paypalClientId: json["paypalClientId"],
      paypalIosEnabled: json["paypalIosEnabled"],
      paypalSecretKey: json["paypalSecretKey"],
      paystackAndroidEnabled: json["paystackAndroidEnabled"],
      paystackIosEnabled: json["paystackIosEnabled"],
      paystackPublicKey: json["paystackPublicKey"],
      paystackSecretKey: json["paystackSecretKey"],
      flutterwaveIosEnabled: json["flutterwaveIosEnabled"],
      googlePayIosEnabled: json["googlePayIosEnabled"],
      razorpayIosEnabled: json["razorpayIosEnabled"],
      stripeIosEnabled: json["stripeIosEnabled"],
    );
  }

  Map<String, dynamic> toJson() => {
        "currency": currency?.toJson(),
        "_id": id,
        "privacyPolicyLink": privacyPolicyLink,
        "termsOfUsePolicyLink": termsOfUsePolicyLink,
        "googlePlayEnabled": googlePlayEnabled,
        "stripeEnabled": stripeEnabled,
        "stripePublishableKey": stripePublishableKey,
        "stripeSecretKey": stripeSecretKey,
        "razorpayEnabled": razorpayEnabled,
        "razorpayId": razorpayId,
        "razorpaySecretKey": razorpaySecretKey,
        "flutterwaveEnabled": flutterwaveEnabled,
        "flutterwaveId": flutterwaveId,
        "loginBonus": loginBonus,
        "isDemoData": isDemoData,
        "minCoinsToConvert": minCoinsToConvert,
        "minCoinsForUserPayout": minCoinsForUserPayout,
        "minCoinsForHostPayout": minCoinsForHostPayout,
        "minCoinsForAgencyPayout": minCoinsForAgencyPayout,
        "maxFreeChatMessages": maxFreeChatMessages,
        "privateKey": privateKey?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "adminCommissionRate": adminCommissionRate,
        "agoraAppCertificate": agoraAppCertificate,
        "agoraAppId": agoraAppId,
        "audioPrivateCallRate": audioPrivateCallRate,
        "chatInteractionRate": chatInteractionRate,
        "femaleRandomCallRate": femaleRandomCallRate,
        "generalRandomCallRate": generalRandomCallRate,
        "isAppEnabled": isAppEnabled,
        "maleRandomCallRate": maleRandomCallRate,
        "videoPrivateCallRate": videoPrivateCallRate,
        "callInitiatedAt": callInitiatedAt,
        "messageInitiatedAt": messageInitiatedAt,
        "isAutoRefreshEnabled": isAutoRefreshEnabled,
        "cashfreeAndroidEnabled": cashfreeAndroidEnabled,
        "cashfreeClientId": cashfreeClientId,
        "cashfreeClientSecret": cashfreeClientSecret,
        "cashfreeIosEnabled": cashfreeIosEnabled,
        "paypalAndroidEnabled": paypalAndroidEnabled,
        "paypalClientId": paypalClientId,
        "paypalIosEnabled": paypalIosEnabled,
        "paypalSecretKey": paypalSecretKey,
        "paystackAndroidEnabled": paystackAndroidEnabled,
        "paystackIosEnabled": paystackIosEnabled,
        "paystackPublicKey": paystackPublicKey,
        "paystackSecretKey": paystackSecretKey,
        "flutterwaveIosEnabled": flutterwaveIosEnabled,
        "googlePayIosEnabled": googlePayIosEnabled,
        "razorpayIosEnabled": razorpayIosEnabled,
        "stripeIosEnabled": stripeIosEnabled,
      };
}

class Currency {
  String? name;
  String? symbol;
  String? countryCode;
  String? currencyCode;
  bool? isDefault;

  Currency({
    this.name,
    this.symbol,
    this.countryCode,
    this.currencyCode,
    this.isDefault,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        symbol: json["symbol"],
        countryCode: json["countryCode"],
        currencyCode: json["currencyCode"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
        "countryCode": countryCode,
        "currencyCode": currencyCode,
        "isDefault": isDefault,
      };
}

class PrivateKey {
  String? type;
  String? projectId;
  String? privateKeyId;
  String? privateKey;
  String? clientEmail;
  String? clientId;
  String? authUri;
  String? tokenUri;
  String? authProviderX509CertUrl;
  String? clientX509CertUrl;
  String? universeDomain;

  PrivateKey({
    this.type,
    this.projectId,
    this.privateKeyId,
    this.privateKey,
    this.clientEmail,
    this.clientId,
    this.authUri,
    this.tokenUri,
    this.authProviderX509CertUrl,
    this.clientX509CertUrl,
    this.universeDomain,
  });

  factory PrivateKey.fromJson(Map<String, dynamic> json) => PrivateKey(
        type: json["type"],
        projectId: json["project_id"],
        privateKeyId: json["private_key_id"],
        privateKey: json["private_key"],
        clientEmail: json["client_email"],
        clientId: json["client_id"],
        authUri: json["auth_uri"],
        tokenUri: json["token_uri"],
        authProviderX509CertUrl: json["auth_provider_x509_cert_url"],
        clientX509CertUrl: json["client_x509_cert_url"],
        universeDomain: json["universe_domain"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "project_id": projectId,
        "private_key_id": privateKeyId,
        "private_key": privateKey,
        "client_email": clientEmail,
        "client_id": clientId,
        "auth_uri": authUri,
        "token_uri": tokenUri,
        "auth_provider_x509_cert_url": authProviderX509CertUrl,
        "client_x509_cert_url": clientX509CertUrl,
        "universe_domain": universeDomain,
      };
}
