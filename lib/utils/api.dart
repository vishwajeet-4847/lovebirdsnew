class Api {
  static const String tokenKey = "authorization";
  static const String uidKey = "x-user-uid";
  static const String key = "key";

  static const baseUrl = "https://backend.lovebirds.support/";
  // static const baseUrl = "http://192.168.29.183:7003/";
  static const secretKey = "YZrWhFrf3v";

  // ===================== USER ===================== //
  static const signInOrSignUp = "${baseUrl}api/client/user/signInOrSignUpUser";
  static const checkUserNameExit =
      "${baseUrl}api/client/user/quickUserVerification";
  static const getUserProfile = "${baseUrl}api/client/user/retrieveUserProfile";
  static const editUserProfile = "${baseUrl}api/client/user/modifyUserProfile";
  static const getAvailableHostForRandomMatch =
      "${baseUrl}api/client/host/retrieveAvailableHost";

  // ===================== HOST ===================== //
  static const getHostProfile = "${baseUrl}api/client/dhost/fetchHostInfo";
  static const hostEditProfile = "${baseUrl}api/client/host/modifyHostDetails";
  static const createHostRequest =
      "${baseUrl}api/client/host/initiateHostRequest";
  static const validateAgencyCodeForHost =
      "${baseUrl}api/client/host/validateAgencyCode";
  static const getImpressionForHost =
      "${baseUrl}api/client/host/getPersonalityImpressions";
  static const getHostRequestStatus =
      "${baseUrl}api/client/host/verifyHostRequestStatus";
  static const getHostDetail = "${baseUrl}api/client/host/retrieveHostDetails";
  static const createHostLive =
      "${baseUrl}api/client/liveBroadcaster/HostStreaming";
  static const getIdentityProofTypesForHost =
      "${baseUrl}api/client/identityProof/fetchIdentityDocuments";

  // ==================== DISCOVER HOST ========================== //
  static const discoverHostForUser = "${baseUrl}api/client/host/retrieveHosts";
  static const getCountryWiseHostForHost =
      "${baseUrl}api/client/host/fetchHostsList";

  // ==================== FOLLOW/UNFOLLOW ===================== //
  static const followOrUnfollow =
      "${baseUrl}api/client/followerFollowing/handleFollowUnfollow";

  // ==================== BLOCK ===================== //
  static const userBlockHost = "${baseUrl}api/client/block/blockHost";
  static const hostBlockUser = "${baseUrl}api/client/block/blockUser";
  static const getBlockedUserForHost =
      "${baseUrl}api/client/block/getBlockedUsersForHost";
  static const getBlockedHostForUser =
      "${baseUrl}api/client/block/getBlockedHostsForUser";

  // ==================== CHAT THUMB LIST ========================== //
  static const getChatThumbListForUser =
      "${baseUrl}api/client/chatTopic/fetchChatList";
  static const getChatThumbListForHost =
      "${baseUrl}api/client/chatTopic/retrieveChatList";

  // ====================== OLD CHAT ========================== //
  static const getOldChatForUser = "${baseUrl}api/client/chat/fetchChatHistory";
  static const getOldChatForHost =
      "${baseUrl}api/client/chat/retrieveChatHistory";

  // ===================== SEND FILE ========================== //
  static const userSendFile = "${baseUrl}api/client/chat/pushChatMessage";
  static const hostSendFile = "${baseUrl}api/client/chat/submitChatMessage";

  // ===================== GIFT ========================== //
  static const getGiftCategories =
      "${baseUrl}api/client/giftCategory/listGiftCategories";
  static const getGifts = "${baseUrl}api/client/gift/fetchGiftList";

  // ==================== DAILY REWARD ===================== //
  static const getDailyRewardCoin =
      "${baseUrl}api/client/dailyRewardCoin/retrieveDailyCoins";
  static const earnCoinFromDailyCheckIn =
      "${baseUrl}api/client/dailyRewardCoin/processDailyCheckIn";

  // ==================== COIN PLAN ========================== //
  static const getCoinPlan = "${baseUrl}api/client/coinPlan/getCoinPackage";
  static const purchaseCoinPlan =
      "${baseUrl}api/client/coinPlan/recordCoinPlanPurchase";

  // ==================== VIP PLAN ===================== //
  static const getVipPlan = "${baseUrl}api/client/vipPlan/fetchVipPlans";
  static const getVipPrivilege =
      "${baseUrl}api/client/vipPlanPrivilege/retrieveVipPrivilege";
  static const purchaseVipPlan = "${baseUrl}api/client/vipPlan/purchaseVipPlan";

  // ==================== WALLET HISTORY ===================== //
  static const getWalletHistoryForUser =
      "${baseUrl}api/client/history/getCoinTransactionRecords";
  static const getWalletHistoryForHost =
      "${baseUrl}api/client/history/retrieveHostCoinHistory";

  // ==================== WITHDRAW ===================== //
  static const getPaymentMethodsApi =
      "${baseUrl}api/client/paymentMethod/getActivePaymentMethods";
  static const getHostWithdrawHistory =
      "${baseUrl}api/client/withdrawalRequest/listPayoutRequests";
  static const createWithdrawalRequest =
      "${baseUrl}api/client/withdrawalRequest/submitWithdrawalRequest";

  // ==================== SETTING ========================== //
  static const getSetting = "${baseUrl}api/client/setting/retrieveAppSettings";

  /// =========> Auto Call Code Code Start <========= ///
  static const getHostUserAutoCall =
      "${baseUrl}api/client/host/getRandomAvailableUser";
  static const getRandomAvailableFakeHost =
      "${baseUrl}api/client/host/getRandomAvailableFakeHost";
  static const getPolicyAndCondition =
      "${baseUrl}api/client/setting/getSystemConfiguration";

  /// =========> Auto Call Code Code End <========= ///

  /// ==========> delete account ============  ///
  static const userDeleteAccount =
      "${baseUrl}api/client/user/deactivateMyAccount";

  /// ==========> fake live gift api ============  ///
  static const fakeLiveChatGift =
      "${baseUrl}api/client/history/handleCoinTransaction";

  // ===================== IP COUNTRY ===================== //
  static const getCountry = "http://ip-api.com/json";
}
