import 'package:LoveBirds/language/bengali_language.dart';
import 'package:LoveBirds/language/arabic_language.dart';
import 'package:LoveBirds/language/chinese_language.dart';
import 'package:LoveBirds/language/english_language.dart';
import 'package:LoveBirds/language/french_language.dart';
import 'package:LoveBirds/language/german_language.dart';
import 'package:LoveBirds/language/hindi_language.dart';
import 'package:LoveBirds/language/indonesian_language.dart';
import 'package:LoveBirds/language/italian_language.dart';
import 'package:LoveBirds/language/japanese_language.dart';
import 'package:LoveBirds/language/korean_language.dart';
import 'package:LoveBirds/language/marathi_language.dart';
import 'package:LoveBirds/language/portuguese_language.dart';
import 'package:LoveBirds/language/russian_language.dart';
import 'package:LoveBirds/language/spanish_language.dart';
import 'package:LoveBirds/language/swahili_language.dart';
import 'package:LoveBirds/language/tamil_language.dart';
import 'package:LoveBirds/language/telugu_language.dart';
import 'package:LoveBirds/language/turkish_language.dart';
import 'package:LoveBirds/language/urdu_language.dart';
import 'package:get/get.dart';

class AppLanguages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar_DZ": arDZ,
        "bn_In": bnIn,
        "zh_CN": zhCN,
        "en_US": enUS,
        "fr_Fr": frFr,
        "de_De": deDe,
        "hi_IN": hiIN,
        "it_In": itIn,
        "id_ID": idID,
        "ja_JP": jaJP,
        "ko_KR": koKR,
        "mr_IN": mrIN,
        "pt_PT": ptPT,
        "ru_RU": ruRU,
        "es_ES": esES,
        "sw_KE": swKE,
        "tr_TR": trTR,
        "te_IN": teIN,
        "ta_IN": taIN,
        "ur_PK": urPK,
      };
}

class LanguageModel {
  LanguageModel(
    this.symbol,
    this.language,
    this.languageCode,
    this.countryCode,
  );

  String language;
  String symbol;
  String countryCode;
  String languageCode;
}
