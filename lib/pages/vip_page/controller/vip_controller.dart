import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/login_page/api/fetch_login_user_profile_api.dart';
import 'package:LoveBirds/pages/splash_screen_page/api/get_setting_api.dart';
import 'package:LoveBirds/pages/vip_page/api/get_vip_plan.dart';
import 'package:LoveBirds/pages/vip_page/api/vip_plan_privilege_api.dart';
import 'package:LoveBirds/pages/vip_page/model/get_vip_plan.dart';
import 'package:LoveBirds/pages/vip_page/model/vip_plan_privilege_model.dart';
import 'package:LoveBirds/pages/vip_page/widget/carousel_widget.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:get/get.dart';

class VipController extends GetxController {
  int currentIndex = 0;
  int carouselIndex = 0;
  bool isLoading = false;
  CarouselSliderController carouselController =
      CarouselSliderController(); // public now

  VipPlanPrivilegeModel? vipPlanPrivilegeModel;
  List<VipCarouselWidget> vipPrivilegeList = [];
  double? price;
  String? vipPlanId;
  num? coin;
  String? productKey;
  String? frameBadge;
  bool frameLoading = false;

  PaymentMethod selectedMethod = PaymentMethod.razorpay; // Default selection

  static GetVipPlanModel? getVipPlanModel;
  List<VipPlan> vipPlanList = <VipPlan>[];

  @override
  void onInit() async {
    await getVipPlan();
    await getVipPrivilege();

    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    GetSettingApi.getSettingApi(uid: uid ?? "", token: token ?? "");

    super.onInit();
  }

  void onCarouselTap({required int id}) {
    carouselIndex = id;

    update([
      AppConstant.idOnCarouselTap1,
      AppConstant.idVipChangeTab,
      AppConstant.idChangePage
    ]);
  }

  void changeTab({required int index}) {
    currentIndex = index;
    price = vipPlanList[index].price?.toDouble();
    vipPlanId = vipPlanList[index].id;
    coin = vipPlanList[index].coin;
    productKey = vipPlanList[index].productId;
    carouselIndex = 0;

    log("price: $price");
    log("vipPlanId: $vipPlanId");

    buildVipPrivilegeList();
    update([
      AppConstant.idOnCarouselTap1,
      AppConstant.idVipChangeTab,
      AppConstant.idChangePage
    ]);
  }

  Future<void> getVipPrivilege() async {
    frameLoading = true;
    vipPlanPrivilegeModel = await VipPlanPrivilegeApi.callApi();

    log("frameBadge: ${vipPlanPrivilegeModel?.data?.vipFrameBadge}");
    frameBadge = vipPlanPrivilegeModel?.data?.vipFrameBadge ?? '';
    Database.onVipFrameBadge(frameBadge ?? "");
    Database.onVipPlanPurchase(true);

    log("Database.isVipFrameBadge******************** ${Database.isVipFrameBadge}");

    buildVipPrivilegeList();
    frameLoading = false;
    update([
      AppConstant.idOnCarouselTap1,
      AppConstant.idVipChangeTab,
      AppConstant.idChangePage
    ]);
  }

  Future<void> getVipPlan() async {
    isLoading = true;

    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    getVipPlanModel =
        await GetVipPlanApi.callApi(token: token ?? "", uid: uid ?? "");
    vipPlanList = getVipPlanModel?.data ?? [];

    if (vipPlanList.isNotEmpty) {
      price = vipPlanList[0].price?.toDouble();
      vipPlanId = vipPlanList[0].id;
      coin = vipPlanList[0].coin;
      productKey = vipPlanList[0].productId;
    }

    log("vipPlanList: $vipPlanList");
    isLoading = false;
    update();
  }

  void getVipPlanPurchase() async {
    try {
      Get.toNamed(
        AppRoutes.paymentPage,
        arguments: {
          "id": vipPlanId ?? "",
          "amount": price ?? 0,
          "isVip": true,
          "productKey": productKey ?? "",
        },
      )?.then(
        (value) async {
          try {
            final uid = FirebaseUid.onGet();
            final token = await FirebaseAccessToken.onGet();

            await FetchLoginUserProfileApi.callApi(
              token: token ?? "",
              uid: uid ?? "",
            );

            await getVipPrivilege();
            update();
          } catch (e) {
            log("Error refreshing profile after payment: $e");
          }
        },
      );
    } catch (e) {
      log("Error navigating to payment page: $e");
    }
  }

  void buildVipPrivilegeList() {
    final data = vipPlanPrivilegeModel?.data;

    if (data != null && price != null) {
      vipPrivilegeList = [
        VipCarouselWidget(
          title: EnumLocale.txtGemsGift.name.tr,
          textSpan1: EnumLocale.txtGet.name.tr,
          textSpan2:
              ' ${coin.toString().split('.')[0]} ${EnumLocale.txtGems.name.tr} ',
          textSpan3: EnumLocale.txtImmediately.name.tr,
          image: AppAsset.icGameGift,
        ),
        VipCarouselWidget(
          title: EnumLocale.txtAudioCallDiscount.name.tr,
          textSpan1: EnumLocale.txtEnjoy.name.tr,
          textSpan2:
              ' ${data.audioCallDiscount}${EnumLocale.txtDiscount.name.tr} ',
          textSpan3: EnumLocale.txtOnAudioCalls.name.tr,
          image: AppAsset.icAudioCallDiscount,
        ),
        VipCarouselWidget(
          title: EnumLocale.txtVideoCallDiscount.name.tr,
          textSpan1: EnumLocale.txtEnjoy.name.tr,
          textSpan2:
              ' ${data.videoCallDiscount}${EnumLocale.txtDiscount.name.tr} ',
          textSpan3: EnumLocale.txtOnVideoCalls.name.tr,
          image: AppAsset.icVideoCallDiscount,
        ),
        VipCarouselWidget(
          title: EnumLocale.txtRandomMatchCallDiscount.name.tr,
          textSpan1: EnumLocale.txtEnjoy.name.tr,
          textSpan2:
              ' ${data.randomMatchCallDiscount}${EnumLocale.txtDiscount.name.tr} ',
          textSpan3: EnumLocale.txtOnRandomMatchCalls.name.tr,
          image: AppAsset.icRandomMatchCall,
        ),
        VipCarouselWidget(
          title: EnumLocale.txtTopUpCoinBonus.name.tr,
          textSpan1: EnumLocale.txtGet.name.tr,
          textSpan2: ' ${data.topUpCoinBonus}${EnumLocale.txtBonus.name.tr} ',
          textSpan3: EnumLocale.txtOnTopUp.name.tr,
          image: AppAsset.icRoundFavourite,
        ),
        VipCarouselWidget(
          title: EnumLocale.txtFreeMessages.name.tr,
          textSpan1: EnumLocale.txtEnjoySending.name.tr,
          textSpan2: ' ${data.freeMessages} ${EnumLocale.txtMessage.name.tr} ',
          textSpan3: EnumLocale.txtForFree.name.tr,
          image: AppAsset.icFreeMessage,
        ),
      ];
    }
  }
}
