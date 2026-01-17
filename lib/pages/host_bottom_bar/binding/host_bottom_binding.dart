import 'package:figgy/pages/host_bottom_bar/controller/host_bottom_controller.dart';
import 'package:figgy/pages/host_live_streamers_page/controller/host_live_streamers_controller.dart';
import 'package:figgy/pages/host_message_page/controller/host_message_controller.dart';
import 'package:figgy/pages/profile_page/controller/profile_controller.dart';
import 'package:get/get.dart';

class HostBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostBottomBarController>(() => HostBottomBarController(), fenix: true);
    Get.lazyPut<HostLiveStreamersController>(() => HostLiveStreamersController(), fenix: true);
    Get.lazyPut<HostMessageController>(() => HostMessageController(), fenix: true);
    Get.lazyPut<ProfileViewController>(() => ProfileViewController(), fenix: true);
  }
}
