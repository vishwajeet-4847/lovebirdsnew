import 'package:LoveBirds/pages/discover_host_for_user_page/controller/discover_host_for_user_controller.dart';
import 'package:get/get.dart';

class DiscoverHostForUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiscoverHostForUserController>(
        () => DiscoverHostForUserController(),
        fenix: true);
  }
}
