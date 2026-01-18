import 'dart:developer';

import 'package:LoveBirds/custom/country_picker.dart';
import 'package:LoveBirds/custom/dialog/block_dialog.dart';
import 'package:LoveBirds/firebase/firebase_access_token.dart';
import 'package:LoveBirds/firebase/firebase_uid.dart';
import 'package:LoveBirds/pages/chat_page/model/host_block_user_model.dart';
import 'package:LoveBirds/pages/host_live_streamers_page/api/host_get_country_wise_host_api.dart';
import 'package:LoveBirds/pages/host_live_streamers_page/model/get_host_country_wise_host_model.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostLiveStreamersController extends GetxController {
  final ScrollController scrollController = ScrollController();
  bool _isDisposed = false;
  int pageCurrentIndex = 0;
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  List userCountry = [
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
  List<dynamic> tabName = [
    EnumLocale.txtHost.name.tr,
    EnumLocale.txtFollowers.name.tr
  ];
  int selectedTabIndex = 0;

  final PageController pageController = PageController();

  void onTabChanged(int index) {
    selectedTabIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  void onPageChanged(int index) {
    selectedTabIndex = index;
    update();
  }

  @override
  void onClose() {
    _isDisposed = true;
    pageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  String selectedCountry = "global";
  String filterCountry = "";

  GetHostCountryWiseHostModel? getCountryWiseHostModel;
  List<HostList?> hostList = [];
  List<FollowerList?> followedHost = [];

  HostBlockUserApiModel? hostBlockUserApiModel;

  Future<void> loadMoreHosts() async {
    if (_isDisposed || isLoading || isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    update([AppConstant.idHostStreamPage3]);

    try {
      final token = await FirebaseAccessToken.onGet();
      final uid = FirebaseUid.onGet();

      if (token == null || uid == null) {
        Utils.showToast('Authentication failed');
        return;
      }

      // For the initial implementation, we'll use 'global' as the hostId
      // since we're fetching a list of hosts, not a specific host's data
      final result = await GetHostCountryWiseHostApi.callApi(
        country: selectedCountry.toLowerCase(),
        uid: uid,
        token: token,
        hostId: Database.hostId, // Using 'global' as a default value
        start: GetHostCountryWiseHostApi.currentPage,
        limit: 10,
      );

      Utils.showLog(
          'Load more hosts result: ${result?.toJson().toString() ?? "null"}');

      if (result != null && result.status == true && result.hosts != null) {
        // Only update the list if we got new data
        if (result.hosts!.isNotEmpty) {
          hostList.addAll(result.hosts!);
          hasMoreData =
              result.hosts!.length >= 10; // Check if we got a full page
          // Update the current page for the next load
          GetHostCountryWiseHostApi.currentPage++;
          update([AppConstant.idHostStreamPage3]);
        } else {
          // No more data
          hasMoreData = false;
          update([AppConstant.idHostStreamPage3]);
        }
      }
    } catch (e) {
      Utils.showLog("Error loading more hosts: $e");
      Utils.showToast('Failed to load more hosts');
    } finally {
      isLoadingMore = false;
      update();
    }
  }

  @override
  void onInit() {
    Utils.showLog("Initializing HostLiveStreamersController...");
    selectedCountry = userCountry[0];

    // Initialize scroll controller
    _setupScrollController();

    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountryWishHost(country: selectedCountry);
    });

    super.onInit();
  }

  void _setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoadingMore &&
          hasMoreData) {
        loadMoreHosts();
      }
    });
  }

  Future<void> onChangeCountry(BuildContext context) async {
    CustomCountryPicker.pickCountry(
      context,
      true,
      (country) async {
        if (country.name == "World Wide") {
          selectedCountry = "Global"; // Match list item
          filterCountry = "World Wide"; // Display this for the filter chip
        } else {
          selectedCountry = country.name;
          filterCountry = country.name;
        }

        await getCountryWishHost(
          country: selectedCountry == "Global" ? "global" : selectedCountry,
        );

        update([
          AppConstant.idStreamPage1,
          AppConstant.idStreamPage3,
          AppConstant.idChangeCountry,
        ]);
      },
    );
  }

  Future<void> filterData() async {
    filterCountry = "";
    selectedCountry = "Global";
    update([
      AppConstant.idHostStreamPage1,
      AppConstant.idHostStreamPage3,
      AppConstant.idChangeCountry,
    ]);
    await getCountryWishHost(country: "global");
  }

  Future<void> countryTab({required int index}) async {
    filterCountry = "";
    pageCurrentIndex = index;

    log("selectedCountry: $selectedCountry");
    update([AppConstant.idHostStreamPage1, AppConstant.idHostStreamPage3]);
    await getCountryWishHost(country: selectedCountry);
  }

  Future<void> getCountryWishHost(
      {required String country, bool loadMore = false}) async {
    // Prevent multiple simultaneous API calls
    if ((isLoading && !loadMore) || (isLoadingMore && loadMore)) {
      Utils.showLog('Skipping duplicate API call');
      return;
    }

    if (!loadMore) {
      // Reset pagination on new search
      GetHostCountryWiseHostApi.currentPage = 1;
      GetHostCountryWiseHostApi.hasMoreData = true;
      hostList.clear();
      isLoading = true;
      update([AppConstant.idHostStreamPage3]);
      Utils.showLog('Starting initial load for country: $country');
    } else {
      if (!GetHostCountryWiseHostApi.hasMoreData) {
        Utils.showLog('No more data to load');
        return;
      }
      isLoadingMore = true;
      update([AppConstant.idHostStreamPage3]);
      Utils.showLog(
          'Loading more data, page: ${GetHostCountryWiseHostApi.currentPage + 1}');
    }

    try {
      final token = await FirebaseAccessToken.onGet();
      final uid = FirebaseUid.onGet();

      if (token == null || uid == null) {
        Utils.showToast('Authentication failed');
        return;
      }

      final result = await GetHostCountryWiseHostApi.callApi(
        country: country.toLowerCase(),
        uid: uid,
        token: token,
        hostId: Database.hostId, // Using 'global' as a default value
        start: loadMore ? GetHostCountryWiseHostApi.currentPage : 1,
        limit: 10,
      );

      Utils.showLog(
          'Get country wise hosts result: ${result?.toJson().toString() ?? "null"}');

      if (result != null) {
        if (result.status == true) {
          getCountryWiseHostModel = result;

          if (loadMore) {
            if (result.hosts != null && result.hosts!.isNotEmpty) {
              hostList.addAll(result.hosts!);
              // Only increment the page if we got some data
              GetHostCountryWiseHostApi.currentPage++;
              Utils.showLog('Loaded ${result.hosts!.length} more hosts');
            }
          } else {
            hostList = result.hosts ?? [];
            // Reset to first page for new searches
            GetHostCountryWiseHostApi.currentPage = 1;
            Utils.showLog(
                'Initial load complete. Loaded ${hostList.length} hosts');
          }

          // Check if we got a full page of results
          hasMoreData = (result.hosts?.length ?? 0) >= 10;

          // Update the UI
          update([AppConstant.idHostStreamPage3]);
        } else {
          Utils.showLog('API Error: ${result.message}');
          if (!loadMore) {
            hostList = []; // Clear the list on error for new searches
          }
          update([AppConstant.idHostStreamPage3]);
        }
      } else {
        Utils.showLog('Failed to load hosts: API returned null');
        if (!loadMore) {
          hostList = [];
        }
        update([AppConstant.idHostStreamPage3]);
      }
    } catch (e) {
      Utils.showLog('Error in getCountryWishHost: $e');
      if (!loadMore) {
        Utils.showToast('Failed to load hosts');
        hostList = []; // Clear the list on error for new searches
      }
    } finally {
      isLoading = false;
      isLoadingMore = false;
      update([AppConstant.idHostStreamPage3]);
    }
  }

  //******************** Block
  void getBlock({required BuildContext context, required String userId}) async {
    Get.dialog(
      barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
      Dialog(
        backgroundColor: AppColors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        child: BlockDialog(
          hostId: userId,
          isHost: false,
          userId: userId,
        ),
      ),
    ).then(
      (value) {
        getCountryWishHost(
          country: selectedCountry == "World Wide" ? "global" : selectedCountry,
        );
      },
    );
  }
}
