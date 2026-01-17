import 'package:figgy/pages/host_withdraw_history_page/controller/host_withdraw_history_controller.dart';
import 'package:get/get.dart';

class HostWithdrawHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostWithdrawHistoryController>(() => HostWithdrawHistoryController());
  }
}
