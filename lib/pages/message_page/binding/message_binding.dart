import 'package:LoveBirds/pages/message_page/controller/message_controller.dart';
import 'package:get/get.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() => MessageController(), fenix: true);
  }
}
