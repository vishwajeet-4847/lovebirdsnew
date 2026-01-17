import 'package:figgy/pages/withdraw_page/controller/withdraw_controller.dart';
import 'package:get/get.dart';

class WithdrawBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawController>(() => WithdrawController());
  }
}
