import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String? _selectedLanguage;

  String? get selectedLanguage => _selectedLanguage;

  void selectLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}
