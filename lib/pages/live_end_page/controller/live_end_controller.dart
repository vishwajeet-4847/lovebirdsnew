import 'package:LoveBirds/utils/utils.dart';
import 'package:get/get.dart';

class LiveEndController extends GetxController {
  Map<String, dynamic> argumentsList = Get.arguments;
  String hostName = '';
  String hostImage = '';

  @override
  void onInit() async {
    hostName = argumentsList["hostName"];
    hostImage = argumentsList["hostImage"];

    Utils.showLog("Live End Screen Host Name :: $hostName");
    Utils.showLog("Live End Screen Host Image :: $hostImage");

    super.onInit();
  }
}
