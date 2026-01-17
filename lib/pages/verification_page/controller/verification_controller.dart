import 'dart:developer';

import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/verification_page/api/fetch_host_request_status_api.dart';
import 'package:figgy/pages/verification_page/model/fetch_host_request_status_model.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/internet_connection.dart';
import 'package:figgy/utils/utils.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  bool isLoading = false;

  @override
  void onInit() {
    onFetchHostRequest();
    super.onInit();
  }

  @override
  void onClose() {
    log("message*************");
    Database.onSetVerification(true);

    super.onClose();
  }

  FetchHostRequestStatusModel? fetchHostRequestStatusModel;

  Future<void> onFetchHostRequest() async {
    isLoading = true;
    update([AppConstant.idHostStatus]);
    update();

    if (InternetConnection.isConnect) {
      final String? uid = FirebaseUid.onGet();
      final String? token = await FirebaseAccessToken.onGet();

      isLoading = true;
      fetchHostRequestStatusModel = await FetchHostRequestStatusApi.callApi(
        token: token ?? "",
        uid: uid ?? "",
      );

      // if (fetchHostRequestStatusModel?.data == 3) Database.onSetVerification(false);

      isLoading = false;
      update([AppConstant.idHostStatus]);
      update();
    } else {
      Utils.showToast("Please check your internet connection.");
    }
  }
}
