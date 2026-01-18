import 'package:LoveBirds/pages/profile_page/controller/profile_controller.dart';
import 'package:LoveBirds/pages/vip_page/controller/vip_controller.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:get/get.dart';

class ProfileViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileViewController>(() => ProfileViewController());
    Database.isHost ? null : Get.put(VipController());
  }
}
