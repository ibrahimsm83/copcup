import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/static_data.dart';

const String accessTokenText = 'access_token';
const String userIdText = 'userId';

class SharedPrefHelper {
  static late SharedPreferences _prefs;

  static Future<void> getInitialValue() async {
    _prefs = await SharedPreferences.getInstance();

    StaticData.accessToken = getString(accessTokenText) ?? '';
    StaticData.email = getString(emailText) ?? '';
    StaticData.userId = getInt(id) ?? 0;

    StaticData.role = getString(roleText) ?? '';
    StaticData.isLoggedIn = getBool(isLoggedInText) ?? false;
    StaticData.sellerEventId = getInt(sellerEventId) ?? 0;
    StaticData.appLanguage = getString(StaticData.appLanguageKey) ?? '';

    log('-----${StaticData.accessToken}');
    log('-----${StaticData.userId}');
    log('-----${StaticData.email}');
    log('-----${StaticData.role}');
    log('-seller evenyt id----${StaticData.sellerEventId}');

    log('-----${StaticData.appLanguage}');
  }

  static Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  static Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static Future<void> saveAccessToken(String token) async {
    await saveString(accessTokenText, token);
    StaticData.accessToken = token;
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> saveUserId(int userId) async {
    await saveInt(userIdText, userId);
    StaticData.userId = userId;
  }

  static String? getAccessToken() {
    return getString(accessTokenText);
  }
}
