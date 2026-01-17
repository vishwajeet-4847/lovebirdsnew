import 'package:figgy/pages/payment_page/controller/payment_controller.dart';
import 'package:get/get.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentScreenController>(() => PaymentScreenController());
  }
}
