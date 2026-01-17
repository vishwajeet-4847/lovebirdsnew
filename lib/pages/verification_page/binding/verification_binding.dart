import 'package:figgy/pages/verification_page/controller/verification_controller.dart';
import 'package:get/get.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationController>(() => VerificationController());
  }
}
