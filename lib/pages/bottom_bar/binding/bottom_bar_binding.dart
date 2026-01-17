import 'package:figgy/pages/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:figgy/pages/discover_host_for_user_page/controller/discover_host_for_user_controller.dart';
import 'package:figgy/pages/message_page/controller/message_controller.dart';
import 'package:figgy/pages/profile_page/controller/profile_controller.dart';
import 'package:figgy/pages/random_match_page/controller/random_match_controller.dart';
import 'package:get/get.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(() => BottomBarController(), fenix: true);
    Get.lazyPut<RandomMatchController>(() => RandomMatchController(), fenix: true);
    Get.lazyPut<DiscoverHostForUserController>(() => DiscoverHostForUserController(), fenix: true);
    Get.lazyPut<MessageController>(() => MessageController(), fenix: true);
    Get.lazyPut<ProfileViewController>(() => ProfileViewController(), fenix: true);
  }
}
