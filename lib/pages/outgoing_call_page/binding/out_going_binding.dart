import 'package:LoveBirds/pages/outgoing_call_page/controller/out_going_controller.dart';
import 'package:get/get.dart';

class OutgoingAudioCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutGoingCall>(() => OutGoingCall());
  }
}
