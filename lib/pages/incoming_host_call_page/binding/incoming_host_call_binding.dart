import 'package:figgy/pages/incoming_host_call_page/controller/incoming_host_call_controller.dart';
import 'package:get/get.dart';

class IncomingHostCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncomingHostCallController>(() => IncomingHostCallController());
  }
}
