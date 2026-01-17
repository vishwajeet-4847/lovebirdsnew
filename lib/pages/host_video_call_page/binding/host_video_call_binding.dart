import 'package:figgy/pages/host_video_call_page/controller/host_video_call_controller.dart';
import 'package:get/get.dart';

class HostVideoCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostVideoCallController>(() => HostVideoCallController());
  }
}
