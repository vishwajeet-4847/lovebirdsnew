import 'package:figgy/pages/app_language_page/binding/app_language_bindig.dart';
import 'package:figgy/pages/app_language_page/view/app_language_view.dart';
import 'package:figgy/pages/audio_player_page/binding/audio_player_binding.dart';
import 'package:figgy/pages/audio_player_page/view/audio_player_view.dart';
import 'package:figgy/pages/block_list_page/binding/block_list_binding.dart';
import 'package:figgy/pages/block_list_page/view/block_list_view.dart';
import 'package:figgy/pages/bottom_bar/binding/bottom_bar_binding.dart';
import 'package:figgy/pages/bottom_bar/view/bottom_bar_view.dart';
import 'package:figgy/pages/chat_page/binding/chat_binding.dart';
import 'package:figgy/pages/chat_page/view/chat_view.dart';
import 'package:figgy/pages/discover_host_for_user_page/binding/discover_host_for_user_binding.dart';
import 'package:figgy/pages/discover_host_for_user_page/view/discover_host_for_user_view.dart';
import 'package:figgy/pages/edit_profile_page/binding/edit_profile_binding.dart';
import 'package:figgy/pages/edit_profile_page/view/edit_profile_view.dart';
import 'package:figgy/pages/fake_live_page/binding/fake_live_binding.dart';
import 'package:figgy/pages/fake_live_page/view/fake_live_view.dart';
import 'package:figgy/pages/fill_profile_page/binding/fill_profile_binding.dart';
import 'package:figgy/pages/fill_profile_page/view/fill_profile_view.dart';
import 'package:figgy/pages/host_bottom_bar/binding/host_bottom_binding.dart';
import 'package:figgy/pages/host_bottom_bar/view/host_bottom_view.dart';
import 'package:figgy/pages/host_detail_page/binding/host_detail_binding.dart';
import 'package:figgy/pages/host_detail_page/view/host_detail_view.dart';
import 'package:figgy/pages/host_edit_profile_page/binding/host_edit_profile_binding.dart';
import 'package:figgy/pages/host_edit_profile_page/view/host_edit_profile_view.dart';
import 'package:figgy/pages/host_live_page/binding/host_live_binding.dart';
import 'package:figgy/pages/host_live_page/view/host_live_view.dart';
import 'package:figgy/pages/host_live_stream/binding/host_live_stream_binding.dart';
import 'package:figgy/pages/host_live_stream/view/host_live_stream_view.dart';
import 'package:figgy/pages/host_live_streamers_page/binding/host_live_streamers_binding.dart';
import 'package:figgy/pages/host_live_streamers_page/view/host_live_streamers_view.dart';
import 'package:figgy/pages/host_request_page/binding/host_request_binding.dart';
import 'package:figgy/pages/host_request_page/view/host_request_view.dart';
import 'package:figgy/pages/host_video_call_page/binding/host_video_call_binding.dart';
import 'package:figgy/pages/host_video_call_page/view/host_video_call_view.dart';
import 'package:figgy/pages/host_withdraw_history_page/binding/host_withdraw_history_binding.dart';
import 'package:figgy/pages/host_withdraw_history_page/view/host_withdraw_history_view.dart';
import 'package:figgy/pages/incoming_audio_call_page/binding/audio_call_binding.dart';
import 'package:figgy/pages/incoming_audio_call_page/view/audio_call_view.dart';
import 'package:figgy/pages/incoming_host_call_page/binding/incoming_host_call_binding.dart';
import 'package:figgy/pages/incoming_host_call_page/view/incoming_host_call_view.dart';
import 'package:figgy/pages/live_end_page/binding/live_end_binding.dart';
import 'package:figgy/pages/live_end_page/view/live_end_view.dart';
import 'package:figgy/pages/login_page/binding/login_binding.dart';
import 'package:figgy/pages/login_page/view/login_view.dart';
import 'package:figgy/pages/matching_page/binding/matching_binding.dart';
import 'package:figgy/pages/matching_page/view/matching_view.dart';
import 'package:figgy/pages/message_page/binding/message_binding.dart';
import 'package:figgy/pages/message_page/view/message_view.dart';
import 'package:figgy/pages/my_wallet_page/binding/my_wallet_binding.dart';
import 'package:figgy/pages/my_wallet_page/view/history_view.dart';
import 'package:figgy/pages/outgoing_call_page/binding/out_going_binding.dart';
import 'package:figgy/pages/outgoing_call_page/view/outgoing_audio_call_view.dart';
import 'package:figgy/pages/outgoing_host_call_page/binding/outgoing_host_call_binding.dart';
import 'package:figgy/pages/outgoing_host_call_page/view/outgoing_host_call_view.dart';
import 'package:figgy/pages/payment_page/binding/payment_binding.dart';
import 'package:figgy/pages/payment_page/view/payment_view.dart';
import 'package:figgy/pages/privacy_policy_page/binding/privacy_policy_binding.dart';
import 'package:figgy/pages/privacy_policy_page/view/privacy_policy.dart';
import 'package:figgy/pages/profile_page/binding/profile_binding.dart';
import 'package:figgy/pages/profile_page/view/profile_view.dart';
import 'package:figgy/pages/random_match_page/binding/random_match_binding.dart';
import 'package:figgy/pages/random_match_page/view/random_match_view.dart';
import 'package:figgy/pages/setting_page/binding/setting_binding.dart';
import 'package:figgy/pages/setting_page/view/setting_view.dart';
import 'package:figgy/pages/splash_screen_page/binding/splash_screen_binding.dart';
import 'package:figgy/pages/splash_screen_page/view/splash_screen_view.dart';
import 'package:figgy/pages/terms_and_conditions_page/binding/terms_and_condition_binding.dart';
import 'package:figgy/pages/terms_and_conditions_page/view/terms_and_condition_view.dart';
import 'package:figgy/pages/top_up_page/binding/top_up_binding.dart';
import 'package:figgy/pages/top_up_page/view/top_up_view.dart';
import 'package:figgy/pages/verification_page/binding/verification_binding.dart';
import 'package:figgy/pages/verification_page/view/verification_view.dart';
import 'package:figgy/pages/video_call_page/binding/video_call_binding.dart';
import 'package:figgy/pages/video_call_page/view/video_call_view.dart';
import 'package:figgy/pages/vip_page/binding/vip_binding.dart';
import 'package:figgy/pages/vip_page/view/vip_view.dart';
import 'package:figgy/pages/withdraw_page/binding/withdraw_binding.dart';
import 'package:figgy/pages/withdraw_page/view/withdraw_view.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.splashScreenPage,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.loginView,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.bottomBar,
      page: () => const BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: AppRoutes.hostBottomBar,
      page: () => const HostBottomView(),
      binding: HostBottomBinding(),
    ),
    GetPage(
      name: AppRoutes.randomPage,
      page: () => const RandomMatchView(),
      binding: RandomMatchBinding(),
    ),
    GetPage(
      name: AppRoutes.profilePage,
      page: () => const ProfileView(),
      binding: ProfileViewBinding(),
    ),
    GetPage(
      name: AppRoutes.topUpPage,
      page: () => const TopUpView(),
      binding: TopUpBinding(),
    ),
    GetPage(
      name: AppRoutes.messagePage,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: AppRoutes.discoverHostForUserPage,
      page: () => const DiscoverHostForUserView(),
      binding: DiscoverHostForUserBinding(),
    ),
    GetPage(
      name: AppRoutes.appLanguagePage,
      page: () => const AppLanguageView(),
      binding: AppLanguageBinding(),
    ),
    GetPage(
      name: AppRoutes.appSettingPage,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRoutes.vipPage,
      page: () => const VipScreen(),
      binding: VipBinding(),
    ),
    GetPage(
      name: AppRoutes.chatPage,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.blockPage,
      page: () => const BlockListView(),
      binding: BlockBinding(),
    ),
    GetPage(
      name: AppRoutes.hostDetailPage,
      page: () => const HostDetailView(),
      binding: HostDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.matchingPage,
      page: () => const MatchingView(),
      binding: MatchingBinding(),
    ),
    GetPage(
      name: AppRoutes.hostRequestPage,
      page: () => const HostRequestView(),
      binding: HostRequestBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfilePage,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.goLiveStreamPage,
      page: () => const HostLiveStreamView(),
      binding: HostLiveStreamBinding(),
    ),
    GetPage(
      name: AppRoutes.hostLivePage,
      page: () => const HostLiveView(),
      binding: HostLiveBinding(),
    ),
    GetPage(
      name: AppRoutes.incomingAudioCallPage,
      page: () => const IncomingAudioCallView(),
      binding: IncomingAudioCallBinding(),
    ),
    GetPage(
      name: AppRoutes.videoCallPage,
      page: () => const VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: AppRoutes.withdrawPage,
      page: () => const WithdrawView(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: AppRoutes.verificationPage,
      page: () => const VerificationView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.hostLiveStreamPage,
      page: () => const HostLiveStreamersView(),
      binding: HostLiveStreamerBinding(),
    ),
    GetPage(
      name: AppRoutes.fillProfile,
      page: () => const FillProfileView(),
      binding: FillProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.outGoingAudioCallPage,
      page: () => const OutGoingAudioCallView(),
      binding: OutgoingAudioCallBinding(),
    ),
    GetPage(
      name: AppRoutes.fakeLivePage,
      page: () => const FakeLiveView(),
      binding: FakeLiveBinding(),
    ),
    GetPage(
      name: AppRoutes.hostEditProfilePage,
      page: () => const HostEditProfileView(),
      binding: HostEditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.paymentPage,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: AppRoutes.hostWithdrawHistory,
      page: () => const HostWithdrawHistoryView(),
      binding: HostWithdrawHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.historyView,
      page: () => const HistoryView(),
      binding: MyWalletBinding(),
    ),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicy(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: AppRoutes.termsAndConditionView,
      page: () => const TermsAndConditionView(),
      binding: TermsAndConditionBinding(),
    ),
    GetPage(
      name: AppRoutes.incomingHostCall,
      page: () => const IncomingHostCallView(),
      binding: IncomingHostCallBinding(),
    ),
    GetPage(
      name: AppRoutes.hostVideoCall,
      page: () => const HostVideoCallView(),
      binding: HostVideoCallBinding(),
    ),
    GetPage(
      name: AppRoutes.outgoingHostCall,
      page: () => const OutgoingHostCallView(),
      binding: OutgoingHostCallBinding(),
    ),
    GetPage(
      name: AppRoutes.liveEndPage,
      page: () => const LiveEndScreen(),
      binding: LiveEndBinding(),
    ),
    GetPage(
      name: AppRoutes.audioPlayerPage,
      page: () => const AudioPlayerView(),
      binding: AudioPlayerBinding(),
    ),
  ];
}
