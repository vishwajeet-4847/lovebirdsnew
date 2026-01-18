import 'package:LoveBirds/pages/video_call_page/controller/video_call_controller.dart';
import 'package:get/get.dart';

class VideoCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCallController>(() => VideoCallController());
  }
}
