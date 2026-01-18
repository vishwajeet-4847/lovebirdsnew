import 'package:LoveBirds/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection {
  static bool isConnect = false;

  static void init() {
    Connectivity().onConnectivityChanged.listen(
      (result) {
        switch (result.first) {
          case ConnectivityResult.none:
            isConnect = false;
            Utils.showLog("Network Not Connect...");
            break;
          case ConnectivityResult.bluetooth:
            isConnect = true;
            Utils.showLog("Network Connected to Bluetooth...");
            break;
          case ConnectivityResult.wifi:
            isConnect = true;
            Utils.showLog("Network Connected to Wifi...");
            break;
          case ConnectivityResult.ethernet:
            isConnect = true;
            Utils.showLog("Network Connected to Ethernet...");
            break;
          case ConnectivityResult.mobile:
            isConnect = true;
            Utils.showLog("Network Connected to Mobile...");
            break;
          case ConnectivityResult.vpn:
            isConnect = true;
            Utils.showLog("Network Connected to VPN...");
            break;
          case ConnectivityResult.other:
            isConnect = true;
            Utils.showLog("Network Connected to Other...");
            break;
        }
      },
    );
  }
}
