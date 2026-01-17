import 'package:figgy/common/loading_widget.dart';
import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/setting_page/api/delete_account_api.dart';
import 'package:figgy/pages/setting_page/api/host_delete_account_api.dart';
import 'package:figgy/pages/setting_page/model/host_delete_account_model.dart';
import 'package:figgy/pages/setting_page/model/user_delete_account_model.dart';
import 'package:figgy/pages/splash_screen_page/api/get_setting_api.dart';
import 'package:figgy/pages/splash_screen_page/model/get_setting_model.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/socket/socket_services.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingController extends GetxController {
  GetSettingModel? getSettingModel;
  UserDeleteAccountModel? userDeleteAccountModel;
  HostDeleteAccountModel? hostDeleteAccountModel;

  @override
  void onInit() {
    Utils.showLog(">>>>>>>>>>>>>>>>>>${Database.url}");
    super.onInit();
  }

  /// user account delete
  Future<void> onDeleteAccount() async {
    final uid = FirebaseUid.onGet();
    Get.back(); // Close Dialog...

    Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

    userDeleteAccountModel = await DeleteAccountApi.callApi(uid: uid ?? '');

    Get.back(); // Stop Loading...

    if (userDeleteAccountModel?.status ?? false) {
      Get.back();
      final identityLogOut = Database.identity;
      final fcmTokenLogOut = Database.fcmToken;

      if (Database.loginType == 2) {
        Utils.showLog("Google Logout Success");
        await GoogleSignIn().signOut();
      }

      Database.localStorage.erase();

      SocketServices.disconnectSocket();

      Database.onSetFcmToken(fcmTokenLogOut);
      Database.onSetIdentity(identityLogOut);

      Get.offAllNamed(AppRoutes.loginView);

      Database.onSetIsAutoRefreshEnabled(false);

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      GetSettingApi.getSettingApi(uid: uid ?? "", token: token ?? "");

      Utils.showLog(userDeleteAccountModel?.message ?? "User account deleted successfully.");
    }
  }

  /// host account delete
  Future<void> onHostDeleteAccount() async {
    final uid = FirebaseUid.onGet();

    Get.back(); // Close Dialog...

    Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

    hostDeleteAccountModel = await HostDeleteAccountApi.callApi(hostId: Database.hostId, uid: uid ?? '');

    Get.back(); // Stop Loading...

    if (hostDeleteAccountModel?.status ?? false) {
      Get.back();
      final identityLogOut = Database.identity;
      final fcmTokenLogOut = Database.fcmToken;

      if (Database.loginType == 2) {
        Utils.showLog("Google Logout Success");
        await GoogleSignIn().signOut();
      }

      Database.localStorage.erase();

      SocketServices.disconnectSocket();

      Database.onSetFcmToken(fcmTokenLogOut);
      Database.onSetIdentity(identityLogOut);

      Get.offAllNamed(AppRoutes.loginView);

      Database.onSetIsAutoRefreshEnabled(false);

      final uid = FirebaseUid.onGet();
      final token = await FirebaseAccessToken.onGet();

      GetSettingApi.getSettingApi(uid: uid ?? "", token: token ?? "");

      Utils.showLog(hostDeleteAccountModel?.message ?? "User account deleted successfully.");
    }
  }
}
