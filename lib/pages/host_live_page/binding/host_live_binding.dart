import 'package:figgy/pages/host_live_page/controller/host_live_controller.dart';
import 'package:get/get.dart';

class HostLiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostLiveController>(() => HostLiveController());
  }
}
