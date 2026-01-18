import 'dart:ui';

import 'package:LoveBirds/localization/localizations_delegate.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:get/get.dart';

class AppLanguageController extends GetxController {
  String _selectedLanguage = Database.selectedLanguage;
  LanguageModel? languageModel;
  String? languageCode;
  String? countryCode;

  String get selectedLanguage => _selectedLanguage;

  final List<LanguageModel> languages = [
    LanguageModel(AppAsset.imPakistan, "Arabic", 'ar', 'DZ'),
    LanguageModel(AppAsset.imIndia, "Bengali", 'bn', 'IN'),
    LanguageModel(AppAsset.imChinese, "Chinese", 'zh', 'CN'),
    LanguageModel(AppAsset.imEnglish, "English", 'en', 'US'),
    LanguageModel(AppAsset.imFrench, "French", 'fr', 'FR'),
    LanguageModel(AppAsset.imGerman, "German", 'de', 'DE'),
    LanguageModel(AppAsset.imIndia, "Hindi", 'hi', 'IN'),
    LanguageModel(AppAsset.imItalian, "Italian", 'it', 'IT'),
    LanguageModel(AppAsset.imIndonesian, "Indonesian", 'id', 'ID'),
    LanguageModel(AppAsset.imKorean, "Korean", 'ko', 'KR'),
    LanguageModel(AppAsset.imPortuguese, "Portuguese", 'pt', 'PT'),
    LanguageModel(AppAsset.imRussian, "Russian", 'ru', 'RU'),
    LanguageModel(AppAsset.imSpanish, "Spanish", 'es', 'ES'),
    LanguageModel(AppAsset.imSwahili, "Swahili", 'sw', 'KE'),
    LanguageModel(AppAsset.imTurkish, "Turkish", 'tr', 'TR'),
    LanguageModel(AppAsset.imIndia, "Telugu", 'te', 'IN'),
    LanguageModel(AppAsset.imIndia, "Tamil", 'ta', 'IN'),
    LanguageModel(AppAsset.imPakistan, "Urdu", 'ur', 'PK'),
    LanguageModel(AppAsset.imJapan, "Japanese", 'ja', 'JP'),
    LanguageModel(AppAsset.imIndia, "Marathi", 'mr', 'IN'),
  ];

  @override
  void onInit() {
    super.onInit();
    languageCode = Database.selectedLanguageCode;
    countryCode = Database.selectedCountryCode;
    _selectedLanguage = Database.selectedLanguage;
  }

  void setSelectedLanguage(languageCode, countryCode, language) {
    Database.onSetSelectedLanguage(language);
    Database.onSetSelectedCountryCode(countryCode);
    Database.onSetSelectedLanguageCode(languageCode);
    _selectedLanguage = language;
    Get.back();
    Get.updateLocale(Locale(languageCode, countryCode));
    update([AppConstant.idSelectedLanguage]);
  }
}
