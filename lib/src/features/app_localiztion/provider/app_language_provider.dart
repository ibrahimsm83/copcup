// import 'package:flutter/material.dart';
// import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
// import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
// import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';

// class AppLanguageNotifier extends ChangeNotifier {
//   Locale _locale = Locale(StaticData.appLanguage);

//   Locale get locale => _locale;

//   Future<void> changeLanguage(Locale type) async {
//     if (_locale == type) {
//       return;
//     }

//     if (type == const Locale("fr")) {
//       _locale = const Locale("fr");
//       StaticData.appLanguage = 'fr';
//       await SharedPrefHelper.saveString(appLanguage, 'fr');
//     } else {
//       StaticData.appLanguage = 'en';

//       _locale = const Locale("en");
//       await SharedPrefHelper.saveString(appLanguage, 'en');

//       // await prefs.setString('language_code', 'en');
//     }
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';

class AppLanguageNotifier extends ChangeNotifier {
  Locale _locale = const Locale('fr'); // default to French

  Locale get locale => _locale;

  AppLanguageNotifier() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    String? savedLang =
        await SharedPrefHelper.getString(StaticData.appLanguageKey);
    if (savedLang != null) {
      _locale = Locale(savedLang);
      StaticData.appLanguage = savedLang;
      notifyListeners();
    }
  }

  Future<void> changeLanguage(Locale newLocale) async {
    if (_locale == newLocale) return;

    _locale = newLocale;
    StaticData.appLanguage = newLocale.languageCode;
    await SharedPrefHelper.saveString(
        StaticData.appLanguageKey, newLocale.languageCode);
    notifyListeners();
  }
}
