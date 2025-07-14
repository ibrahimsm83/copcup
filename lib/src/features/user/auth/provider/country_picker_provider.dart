import 'package:flutter/material.dart';

class CountryPickerProvider extends ChangeNotifier {
  String _selectedFlag = '🇫🇷';
  String _selectedPrefix = '+33';

  String get selectedFlag => _selectedFlag;
  String get selectedPrefix => _selectedPrefix;
  set selectedPrefixVaue(String value) {
    _selectedPrefix = value;

    // notifyListeners();
  }

  // Method to update the selected country and flag
  void updateCountry(String flag, String prefix) {
    _selectedFlag = flag;
    _selectedPrefix = prefix;
    notifyListeners();
  }
}
