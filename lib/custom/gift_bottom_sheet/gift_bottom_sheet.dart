import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/chat_page/api/all_gift_categories_api.dart';
import 'package:LoveBirds/pages/chat_page/api/get_gift_api.dart';
import 'package:LoveBirds/pages/chat_page/model/get_gift_model.dart';
import 'package:LoveBirds/pages/chat_page/model/gift_category_model.dart';
import 'package:LoveBirds/pages/chat_page/widget/chat_center_widget.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/internet_connection.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class GiftBottomSheetWidget {
  static RxList giftCategoryList = [].obs;
  static RxList giftList = [].obs;

  static GiftCategoryModel? giftCategoryModel;
  static GetGiftModel? getGiftModel;

  static int giftCount = 1;
  static num giftCoin = 0;
  static String selectedGiftId = "";

  static RxBool isLoadingGift = false.obs;
  static RxBool isLoadingCategory = true.obs;

  static RxInt selectedGiftTabIndex = 0.obs;
  static RxInt selectedSendGiftCount = 1.obs;
  static RxInt selectedSendGift = (-1).obs;

  static String giftId = "";
  static String giftUrl = "";
  static String giftsvgaImage = "";
  static String senderName = "";
  static int giftType = -1;

  static List<int> giftCounts = [1, 10, 20, 50];
  static RxBool isShowGift = false.obs;

  // New Map to track category-wise gift data
  static Map<String, List<Gifts>> categoryWiseGiftMap = {};
  List<Gifts> liveGiftList = [];

  static Widget onShowGift() {
    log('svg=========$giftsvgaImage');
    log('url=======$giftUrl');
    return Obx(
      () {
        return isShowGift.value
            ? giftType == 1 || giftType == 2
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                        width: 300,
                        child:
                            CachedNetworkImage(imageUrl: resolveUrl(giftUrl)),
                      ),
                      Text(
                        "Send by $senderName",
                        style: AppFontStyle.styleW700(
                          AppColors.whiteColor,
                          25,
                        ),
                      ),
                    ],
                  )
                : giftType == 3
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: GiftSvgaOnce(
                              svgaUrl: resolveUrl(giftUrl),
                              thumbUrl: Api.baseUrl + (giftsvgaImage ?? ""),
                              size: const Size(300, 300),
                              autoPlayFirstTime: true,
                            ),
                          ),
                          Text(
                            "Send by $senderName",
                            style: AppFontStyle.styleW700(
                              AppColors.whiteColor,
                              25,
                            ),
                          ),
                        ],
                      )
                    : const Offstage()
            : const Offstage();
      },
    );
  }

  static void onChangeTab(int index) async {
    selectedGiftTabIndex.value = index;
    giftId = giftCategoryList[index].id;
    await getGiftApi(giftId: giftId);
  }

  static void onChangeTabCon(int index) async {
    log("selectedSendGift--------------------- ${selectedSendGift.value}");
    log("selectedSendGift--------------------- $index");
    selectedSendGift.value = index;
  }

  static void onChangeGiftCount(int count) {
    selectedSendGiftCount.value = count;
    giftCount = count;
  }

  static Future<void> getGiftCategoryApi() async {
    if (InternetConnection.isConnect) {
      isLoadingCategory.value = true;
      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();
      giftCategoryModel = await AllGiftCategoriesApi.callApi(
          token: token ?? "", uid: uid ?? "");
      giftCategoryList.value = giftCategoryModel?.data ?? [];

      if (giftCategoryList.isNotEmpty) {
        giftId = giftCategoryList[0].id;
        await getGiftApi(giftId: giftId);
      }

      isLoadingCategory.value = false;

      _loadRemainingTabsInBackground();
    } else {
      Utils.showToast(EnumLocale.txtNoInternetConnection.name.tr);
    }
  }

  static void _loadRemainingTabsInBackground() async {
    if (giftCategoryList.length > 1) {
      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      for (int i = 1; i < giftCategoryList.length; i++) {
        final categoryId = giftCategoryList[i].id;
        if (!categoryWiseGiftMap.containsKey(categoryId)) {
          try {
            final getGiftModel = await GetGiftApi.callApi(
              token: token ?? "",
              uid: uid ?? "",
              giftCategoryId: categoryId,
            );
            final gifts = getGiftModel?.data ?? [];
            categoryWiseGiftMap[categoryId] = gifts;
          } catch (e) {
            log("Error loading gifts for category $categoryId: $e");
          }
        }
      }
    }
  }

  static Future<void> getGiftApi({required String giftId}) async {
    if (InternetConnection.isConnect) {
      isLoadingGift.value = true;
      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();
      getGiftModel = await GetGiftApi.callApi(
        token: token ?? "",
        uid: uid ?? "",
        giftCategoryId: giftId,
      );

      final gifts = getGiftModel?.data ?? [];
      categoryWiseGiftMap[giftId] = gifts;

      log('gifs id ${getGiftModel?.data}');

      isLoadingGift.value = false;
    } else {
      Utils.showToast(EnumLocale.txtNoInternetConnection.name.tr);
    }
  }

  static Future<void> show(
      {required BuildContext context,
      required Callback callback,
      required bool isChat}) async {
    // getGiftCategoryApi();
    CustomFetchUserCoin.init();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return Obx(() {
          return DefaultTabController(
            length: giftCategoryList.length,
            child: Container(
              height: 450,
              width: Get.width,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.settingColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      TabBar(
                        isScrollable: true,
                        indicatorColor: AppColors.giftTabColor,
                        labelColor: AppColors.giftTabColor,
                        labelStyle:
                            AppFontStyle.styleW600(AppColors.giftTabColor, 14),
                        unselectedLabelStyle:
                            AppFontStyle.styleW600(AppColors.whiteColor, 14),
                        unselectedLabelColor: AppColors.whiteColor,
                        dividerColor:
                            AppColors.whiteColor.withValues(alpha: 0.06),
                        dividerHeight: 2,
                        padding: EdgeInsets.zero,
                        tabAlignment: TabAlignment.start,
                        onTap: (index) async {
                          selectedGiftTabIndex.value = index;
                          final selectedCategoryId = giftCategoryList[index].id;

                          if (!categoryWiseGiftMap
                              .containsKey(selectedCategoryId)) {
                            await getGiftApi(giftId: selectedCategoryId);
                          }
                        },
                        tabs: giftCategoryList
                            .map((e) => Tab(text: e.name ?? ""))
                            .toList(),
                      ).paddingOnly(right: 40),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: Get.back,
                          child: Container(
                            color: AppColors.settingColor,
                            child: Container(
                              height: 25,
                              width: 25,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color:
                                    AppColors.whiteColor.withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                AppAsset.icCloseDialog,
                                width: 10,
                              ),
                            ).paddingOnly(left: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Obx(
                      () {
                        if (isLoadingCategory.value) {
                          return const Center(child: LoadingWidget(size: 35));
                        }

                        return isLoadingGift.value
                            ? const Center(child: LoadingWidget(size: 35))
                            : TabBarView(
                                children: giftCategoryList.map(
                                  (category) {
                                    return Obx(() {
                                      final giftsInCategory =
                                          categoryWiseGiftMap[category.id] ??
                                              [];
                                      final isCurrentTabLoading =
                                          selectedGiftTabIndex.value ==
                                                  giftCategoryList
                                                      .indexOf(category) &&
                                              isLoadingGift.value;
                                      final hasDataLoaded = categoryWiseGiftMap
                                          .containsKey(category.id);

                                      return isCurrentTabLoading
                                          ? const Center(
                                              child: LoadingWidget(size: 35))
                                          : !hasDataLoaded
                                              ? const Center(
                                                  child: LoadingWidget(
                                                      size:
                                                          35)) // Show loader if data not loaded yet
                                              : giftsInCategory.isEmpty
                                                  ? Center(
                                                      child: Image.asset(
                                                        AppAsset.icNoDataGift,
                                                        height: 100,
                                                        width: 100,
                                                      ),
                                                    )
                                                  : GridView.builder(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      itemCount: giftsInCategory
                                                          .length,
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                        crossAxisSpacing: 8,
                                                        mainAxisSpacing: 8,
                                                        childAspectRatio: 0.88,
                                                      ),
                                                      itemBuilder:
                                                          (context, index) {
                                                        final gift =
                                                            giftsInCategory[
                                                                index];
                                                        return Obx(
                                                          () => GiftItemWidget(
                                                            isSelected:
                                                                selectedSendGift
                                                                        .value ==
                                                                    index,
                                                            gifts: gift,
                                                            onChangeTabCon:
                                                                (int idx) {
                                                              log("gift.svgaImage --------------------- ${gift.svgaImage}");

                                                              onChangeTabCon(
                                                                  idx);
                                                              giftUrl =
                                                                  gift.image ??
                                                                      "";
                                                              giftsvgaImage =
                                                                  gift.svgaImage ??
                                                                      "";
                                                              giftCoin =
                                                                  gift.coin ??
                                                                      0;
                                                              selectedGiftId =
                                                                  gift.id ?? "";
                                                              giftType =
                                                                  gift.type ??
                                                                      0;
                                                            },
                                                            giftList:
                                                                giftsInCategory,
                                                          ),
                                                        );
                                                      },
                                                    );
                                    });
                                  },
                                ).toList(),
                              );
                        /*TabBarView(
                                children: giftCategoryList.map(
                                  (category) {
                                    final giftsInCategory = categoryWiseGiftMap[category.id] ?? [];

                                    return isLoadingGift.value
                                        ? const Center(child: LoadingWidget(size: 35))
                                        : giftsInCategory.isEmpty
                                            ? Center(
                                                child: Image.asset(
                                                  AppAsset.icNoDataGift,
                                                  height: 100,
                                                  width: 100,
                                                ),
                                              )
                                            : GridView.builder(
                                                padding: const EdgeInsets.all(12),
                                                itemCount: giftsInCategory.length,
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  crossAxisSpacing: 8,
                                                  mainAxisSpacing: 8,
                                                  childAspectRatio: 0.88,
                                                ),
                                                itemBuilder: (context, index) {
                                                  final gift = giftsInCategory[index];
                                                  return Obx(
                                                    () => GiftItemWidget(
                                                      isSelected: selectedSendGift.value == index,
                                                      gifts: gift,
                                                      onChangeTabCon: (int idx) {
                                                        onChangeTabCon(idx);
                                                        giftUrl = gift.image ?? "";
                                                        giftCoin = gift.coin ?? 0;
                                                        selectedGiftId = gift.id ?? "";
                                                        giftType = gift.type ?? 0;
                                                      },
                                                      giftList: giftsInCategory,
                                                    ),
                                                  );
                                                },
                                              );
                                  },
                                ).toList(),
                              );*/
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.topUpPage)?.then((_) {
                            CustomFetchUserCoin.init();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  AppColors.whiteColor.withValues(alpha: 0.16),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            color: AppColors.giftBgColor,
                          ),
                          child: Row(
                            children: [
                              const Image(
                                  image: AssetImage(AppAsset.icCoin),
                                  width: 24,
                                  height: 24),
                              6.width,
                              isLoadingCategory.value
                                  ? CupertinoActivityIndicator(
                                      color: AppColors.whiteColor
                                          .withValues(alpha: 0.16),
                                      radius: 8,
                                    )
                                  : Obx(
                                      () => Text(
                                        CustomFetchUserCoin.coin.value
                                            .toString(),
                                        style: AppFontStyle.styleW6003(
                                            AppColors.whiteColor, 16),
                                      ),
                                    ),
                              2.width,
                              Image.asset(AppAsset.whiteForwardIcon,
                                  width: 16, height: 16),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                            color: AppColors.colorGiftGridView1,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Obx(() {
                              return Row(
                                children: List.generate(
                                  giftCounts.length,
                                  (index) {
                                    return GestureDetector(
                                      onTap: () =>
                                          onChangeGiftCount(giftCounts[index]),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: selectedSendGiftCount.value ==
                                                  giftCounts[index]
                                              ? AppColors.selectColor
                                              : AppColors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: 35,
                                        width: 40,
                                        child: Center(
                                          child: Text(
                                            giftCounts[index].toString(),
                                            style: AppFontStyle.styleW6003(
                                                AppColors.whiteColor, 12),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                            GestureDetector(
                              onTap: () {
                                if (giftUrl.isEmpty || selectedGiftId.isEmpty) {
                                  Utils.showToast(EnumLocale
                                      .txtPleaseSelectGiftFirst.name.tr);
                                } else {
                                  callback();

                                  if (isChat) Get.back();
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 74,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  gradient: AppColors.gradientButtonColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  EnumLocale.txtSend.name.tr,
                                  style: AppFontStyle.styleW600(
                                      AppColors.whiteColor, 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 11, right: 12, left: 12),
                ],
              ),
            ),
          );
        });
      },
    ).whenComplete(() {
      selectedGiftTabIndex.value = 0;
      giftUrl = "";
      giftsvgaImage = GiftBottomSheetWidget.giftsvgaImage;
      giftCoin = 0;
      selectedGiftId = "";
      giftType = -1;
      selectedSendGift.value = (-1);
      selectedSendGiftCount.value = 1;
      giftCount = 1;
    });
  }
}

class GiftItemWidget extends StatelessWidget {
  const GiftItemWidget({
    super.key,
    required this.isSelected,
    required this.gifts,
    required this.onChangeTabCon,
    required this.giftList,
  });

  final bool isSelected;
  final Function(int index) onChangeTabCon;
  final List<Gifts> giftList;

  final Gifts gifts;
  @override
  Widget build(BuildContext context) {
    log("gifts.svgaImage>>>>>>>>>>>>>>${gifts.svgaImage}");
    return GestureDetector(
      onTap: () {
        onChangeTabCon(giftList.indexOf(gifts));
      },
      child: LayoutBuilder(
        builder: (context, box) {
          return Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [AppColors.pinkColor, AppColors.blueColor],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              height: box.maxHeight,
              width: box.maxWidth,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: AppColors.giftBgColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gifts.type == 3
                      ? Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: SizedBox(
                            height: 45,
                            width: 100,
                            child: CachedNetworkImage(
                              imageUrl: Api.baseUrl + (gifts.svgaImage ?? ""),
                            ),
                          ).paddingOnly(top: 18),
                        )
                      : CachedNetworkImage(
                          imageUrl: Api.baseUrl + (gifts.image ?? ""),
                          width: 45,
                        ).paddingOnly(top: 19),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 6, right: 7, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(58),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppAsset.icCoin, width: 12),
                            3.width,
                            Text(
                              gifts.coin!.toStringAsFixed(2),
                              style: AppFontStyle.styleW7002(
                                  AppColors.yellowColor, 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class GiftCountItemWidget extends StatelessWidget {
  const GiftCountItemWidget(
      {super.key,
      required this.count,
      required this.isSelected,
      required this.callback});

  final int count;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 45,
          width: 40,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            color:
                isSelected ? AppColors.googleButtonColor : AppColors.colorGry,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            count.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFontStyle.styleW600(AppColors.whiteColor, 12),
          ),
        ),
      ),
    );
  }
}

String resolveUrl(String? url) {
  if (url == null) return '';
  final u = url.trim();
  if (u.isEmpty) return '';
  // Already absolute
  if (u.startsWith('http://') || u.startsWith('https://')) return u;

  // Join with base
  final base = Api.baseUrl.trimRight().endsWith('/')
      ? Api.baseUrl.trimRight().substring(0, Api.baseUrl.trimRight().length - 1)
      : Api.baseUrl.trimRight();

  final path = u.startsWith('/') ? u.substring(1) : u;
  return '$base/$path';
}
