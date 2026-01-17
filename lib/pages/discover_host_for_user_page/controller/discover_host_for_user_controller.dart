import 'dart:math';

import 'package:figgy/custom/country_picker.dart';
import 'package:figgy/custom/other/custom_fetch_user_coin.dart';
import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/discover_host_for_user_page/api/discover_host_for_user_api.dart';
import 'package:figgy/pages/discover_host_for_user_page/model/discover_host_for_user_model.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/internet_connection.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverHostForUserController extends GetxController {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  int currentPage = 1;
  final int itemsPerPage = 10;

  List<String> userCountry = [
    "Global",
    "India",
    "Pakistan",
    "America",
    "German",
    "Russian",
  ];

  List<String> userCountryFlag = [
    AppAsset.india,
    AppAsset.india,
    AppAsset.pakistan,
    AppAsset.america,
    AppAsset.german,
    AppAsset.russian,
  ];

  String selectedCountry = "global";
  String filterCountry = "";
  int selectedTabIndex = 1;
  final PageController pageController = PageController();

  void onPageChanged(int index) {
    selectedTabIndex = index;
    update();
  }

  DiscoverHostForUserModel? discoverHostForUserModel;
  List<Host> hostList = [];
  List<Host> followUserList = [];
  List<Host> liveHostList = [];

  @override
  void onInit() {
    super.onInit();
    Utils.showLog("Initial selectedCountry: $selectedCountry");

    // Add scroll listener for pagination
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.8 &&
          !isLoading &&
          !isLoadingMore &&
          hasMoreData) {
        loadMoreHosts();
      }
    });

    if (Database.isAutoRefreshEnabled) {
      discoverHostForUser(country: selectedCountry);
    } else if (Database.isLiveStreamApiCall) {
      discoverHostForUser(country: selectedCountry);
      Database.onSetIsLiveStreamApiCall(false);
    } else {
      Utils.showLog("Enter in else live stream controller");
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(selectedTabIndex);
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void onTabChanged(int index) {
    selectedTabIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  Future<void> discoverHostForUser(
      {required String country, bool loadMore = false}) async {
    if (!loadMore) {
      // Reset pagination on new search
      currentPage = 1;
      hasMoreData = true;
      hostList.clear();
      followUserList.clear();
      liveHostList.clear();
      isLoading = true;
      update();
    } else {
      if (!hasMoreData || isLoadingMore) return;
      isLoadingMore = true;
      update();
    }

    try {
      final token = await FirebaseAccessToken.onGet();
      final uid = FirebaseUid.onGet();

      if (token == null || uid == null) {
        Utils.showLog('Error Authentication failed');
        return;
      }

      final result = await DiscoverHostForUserApi.callApi(
        country: country,
        uid: uid,
        token: token,
        start: currentPage,
        limit: itemsPerPage,
        userId: Database.loginUserId,
      );

      if (result != null && result.status == true) {
        discoverHostForUserModel = result;

        if (loadMore) {
          hostList.addAll(result.hosts ?? []);
          followUserList.addAll(result.followedHost ?? []);
          liveHostList.addAll(result.liveHost ?? []);
        } else {
          hostList = result.hosts ?? [];
          followUserList = result.followedHost ?? [];
          liveHostList = result.liveHost ?? [];
        }

        // Check if we have more data to load
        if ((result.hosts?.length ?? 0) < itemsPerPage) {
          hasMoreData = false;
        } else {
          currentPage++;
        }

        update();
      } else {
        if (!loadMore) {
          Utils.showLog('Error ${(result?.message ?? "Failed to load hosts")}');
          hostList = [];
          followUserList = [];
          liveHostList = [];
        }
      }
    } catch (e) {
      Utils.showLog('Error in discoverHostForUser: $e');
      if (!loadMore) {
        Utils.showLog('Error in discoverHostForUser: $e');
      }
    } finally {
      if (isLoading) {
        isLoading = false;
      }
      if (isLoadingMore) {
        isLoadingMore = false;
      }
      update([
        AppConstant.idStreamPage1,
        AppConstant.idStreamPage2,
        AppConstant.idStreamPage3
      ]);
    }
  }

  Future<void> loadMoreHosts() async {
    if (isLoading || isLoadingMore || !hasMoreData) return;
    await discoverHostForUser(country: selectedCountry, loadMore: true);
  }

  // Country related methods
  Future<void> filterData() async {
    filterCountry = "";
    selectedCountry = "Global";
    update([
      AppConstant.idStreamPage1,
      AppConstant.idStreamPage3,
      AppConstant.idChangeCountry
    ]);
    await discoverHostForUser(country: "global");
  }

  Future<void> onChangeCountry1(BuildContext context) async {
    CustomCountryPicker.pickCountry(
      context,
      true,
      (country) async {
        selectedCountry = country.name;
        await discoverHostForUser(
          country: selectedCountry == "World Wide" ? "global" : selectedCountry,
        );
      },
    );

    update([
      AppConstant.idStreamPage1,
      AppConstant.idStreamPage3,
      AppConstant.idChangeCountry
    ]);
  }

  Future<void> onChangeCountry(BuildContext context) async {
    CustomCountryPicker.pickCountry(
      context,
      true,
      (country) async {
        if (country.name == "World Wide") {
          selectedCountry = "Global";
          filterCountry = "World Wide";
        } else {
          selectedCountry = country.name;
          filterCountry = country.name;
        }

        await discoverHostForUser(
          country: selectedCountry == "Global" ? "global" : selectedCountry,
        );

        update([
          AppConstant.idStreamPage1,
          AppConstant.idStreamPage3,
          AppConstant.idChangeCountry
        ]);
      },
    );
  }

  Future<void> countryTab({required int index}) async {
    filterCountry = "";
    selectedCountry = userCountry[index];
    Utils.showLog("Tab switched to country: $selectedCountry");
    update([AppConstant.idStreamPage1, AppConstant.idStreamPage3]);
    await discoverHostForUser(country: selectedCountry.toLowerCase());
  }

  String getStatusText(String? status) {
    switch (status) {
      case "Online":
        return EnumLocale.txtOnline.name.tr;
      case "Offline":
        return EnumLocale.txtOffline.name.tr;
      case "Live":
        return EnumLocale.txtLive.name.tr;
      default:
        return EnumLocale.txtBusy.name.tr;
    }
  }

  String onGenerateRandomNumber() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    return List.generate(
      25,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }

  Future<void> getUpdatedCoin() async {
    if (InternetConnection.isConnect) {
      update([AppConstant.idRandomMatchView]);

      await CustomFetchUserCoin.init();
      Utils.showLog(
          "discover_host_controller.dart coin: ${CustomFetchUserCoin.coin.value}");

      update([AppConstant.idRandomMatchView, AppConstant.idUpdateCoin]);
    } else {
      Utils.showLog("Internet Connection Lost !!");
    }
  }
}
