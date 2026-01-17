import 'package:figgy/pages/incoming_audio_call_page/controller/audio_call_controller.dart';
import 'package:get/get.dart';

class IncomingAudioCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncomingAudioCallController>(() => IncomingAudioCallController());
  }
}
