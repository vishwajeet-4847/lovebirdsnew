import 'package:figgy/pages/host_live_stream/controller/host_live_stream_controller.dart';
import 'package:get/get.dart';

class HostLiveStreamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostLiveStreamController>(() => HostLiveStreamController());
  }
}
