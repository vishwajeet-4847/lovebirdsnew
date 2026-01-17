import 'package:figgy/pages/chat_page/controller/chat_controller.dart';
import 'package:figgy/pages/host_message_page/controller/host_message_controller.dart';
import 'package:get/get.dart';

class HostMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostMessageController>(() => HostMessageController(), fenix: true);
    Get.put(ChatController());
  }
}
