import 'package:LoveBirds/pages/vip_page/controller/vip_controller.dart';
import 'package:get/get.dart';

class VipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VipController>(() => VipController());
  }
}
