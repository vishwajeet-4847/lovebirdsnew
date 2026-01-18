import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  @override
  void onInit() {
    Utils.showLog("html url::::::::::::::::$url");
    super.onInit();
  }

  String url = Database.url;
}
