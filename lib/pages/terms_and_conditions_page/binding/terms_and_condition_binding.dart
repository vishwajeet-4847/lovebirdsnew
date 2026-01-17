import 'package:figgy/pages/terms_and_conditions_page/controller/terms_and_condition_controller.dart';
import 'package:get/get.dart';

class TermsAndConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsAndConditionController>(() => TermsAndConditionController());
  }
}
