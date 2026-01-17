import 'package:figgy/pages/matching_page/controller/matching_controller.dart';
import 'package:get/get.dart';

class MatchingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MatchingController>(() => MatchingController());
  }
}
