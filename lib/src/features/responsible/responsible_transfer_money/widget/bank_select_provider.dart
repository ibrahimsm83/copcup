import 'package:flutter/material.dart';

class BankSelectionProvider with ChangeNotifier {
  int? _selectedBankIndex;

  int? get selectedBankIndex => _selectedBankIndex;

  void selectBank(int index) {
    _selectedBankIndex = index;
    notifyListeners(); // Notify listeners when selection changes
  }
}
