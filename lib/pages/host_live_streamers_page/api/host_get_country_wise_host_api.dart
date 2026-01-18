import 'dart:convert';
import 'dart:developer';

import 'package:LoveBirds/pages/host_live_streamers_page/model/get_host_country_wise_host_model.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:http/http.dart' as http;

class GetHostCountryWiseHostApi {
  static GetHostCountryWiseHostModel? getCountryWiseHostModel;
  static List<HostList> hostList = <HostList>[];
  static int currentPage = 1;
  static bool hasMoreData = true;

  static Future<GetHostCountryWiseHostModel?> callApi({
    required String country,
    required String uid,
    required String token,
    required String hostId,
    int start = 1,
    int limit = 10,
  }) async {
    Utils.showLog("Get Country Wise Host Api Calling...");
    final uri = Uri.parse(
        "${Api.getCountryWiseHostForHost}?country=$country&hostId=$hostId&start=$start&limit=$limit");
    log("Uri => $uri");
    Utils.showLog("Get Country Wise Host Uri => $uri");

    final headers = {
      Api.key: Api.secretKey,
      Api.tokenKey: "Bearer $token",
      Api.uidKey: uid,
    };

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        getCountryWiseHostModel =
            GetHostCountryWiseHostModel?.fromJson(jsonDecode(response.body));

        Utils.showLog("Get Country Wise Host Api Calling... ${response.body}");

        if (start == 1) {
          hostList = getCountryWiseHostModel?.hosts ?? <HostList>[];
        } else {
          hostList.addAll(getCountryWiseHostModel?.hosts ?? <HostList>[]);
        }

        // Check if we have more data to load
        if ((getCountryWiseHostModel?.hosts?.length ?? 0) < limit) {
          hasMoreData = false;
        } else {
          currentPage++;
        }

        return getCountryWiseHostModel;
      } else {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Country Wise Host Error => $jsonResponse");

        Utils.showToast("Something went wrong");

        return null;
      }
    } catch (e) {
      Utils.showLog("Get Country Wise Host Api Error => $e");
      return null;
    }
  }
}
