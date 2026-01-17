import 'dart:convert';

import 'package:figgy/pages/splash_screen_page/model/get_country_model.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/utils.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;

class GetCountryApi {
  static GetCountryModel? getCountryModel;

  static getDialCode() {
    CountryCode getCountryDialCode(String countryCode) {
      return CountryCode.fromCountryCode(countryCode);
    }

    CountryCode country = getCountryDialCode(getCountryModel?.countryCode ?? "IN");
    Utils.showLog("country.Dial code :: ${country.dialCode}");

    Database.onSetDialCode(country.dialCode ?? "");
    Utils.showLog("Dial code :: ${Database.dialCode}");
  }

  static Future<void> callApi() async {
    Utils.showLog("Get Country Api Calling...");

    final uri = Uri.parse(Api.getCountry);

    Utils.showLog("Get Country Api Url => $uri");

    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Get Country Status Code :: ${response.statusCode}");
      Utils.showLog("Get Country Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Country Api Response => ${response.body}");

        getCountryModel = GetCountryModel.fromJson(jsonResponse);

        Utils.showLog("getCountryModel?.country ?? :: ${getCountryModel?.country ?? ""}");
        Utils.showLog("getCountryModel?.countryCode ?? :: ${getCountryModel?.countryCode ?? ""}");

        Database.onSetCountry(getCountryModel?.country ?? "India");
        Database.onSetCountryCode(getCountryModel?.countryCode ?? "IN");

        Utils.showLog("Database.country :: ${Database.country}");
        Utils.showLog("Database.countryCode :: ${Database.countryCode}");
      } else {
        Utils.showLog("Get Country Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Country Api Error => $error");
    }
  }
}
