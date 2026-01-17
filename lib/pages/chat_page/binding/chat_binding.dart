import 'package:figgy/pages/chat_page/controller/chat_controller.dart';
import 'package:figgy/pages/host_message_page/controller/host_message_controller.dart';
import 'package:figgy/pages/message_page/controller/message_controller.dart';
import 'package:get/get.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostMessageController>(() => HostMessageController());
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
