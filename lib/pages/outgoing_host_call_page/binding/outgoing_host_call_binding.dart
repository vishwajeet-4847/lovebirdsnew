import 'package:LoveBirds/pages/outgoing_host_call_page/controller/outgoing_host_call_controller.dart';
import 'package:get/get.dart';

class OutgoingHostCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutgoingHostCallController>(() => OutgoingHostCallController());
  }
}
