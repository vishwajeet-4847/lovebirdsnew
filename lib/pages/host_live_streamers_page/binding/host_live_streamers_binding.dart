import 'package:figgy/pages/chat_page/controller/chat_controller.dart';
import 'package:figgy/pages/host_live_streamers_page/controller/host_live_streamers_controller.dart';
import 'package:figgy/pages/host_message_page/controller/host_message_controller.dart';
import 'package:get/get.dart';

class HostLiveStreamerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostLiveStreamersController>(() => HostLiveStreamersController(), fenix: true);
    Get.lazyPut<HostMessageController>(() => HostMessageController());
    Get.put(ChatController());
  }
}
