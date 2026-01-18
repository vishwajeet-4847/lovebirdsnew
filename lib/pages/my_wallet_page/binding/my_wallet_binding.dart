import 'package:LoveBirds/pages/my_wallet_page/controller/my_wallet_controller.dart';
import 'package:get/get.dart';

class MyWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyWalletController>(() => MyWalletController());
  }
}
