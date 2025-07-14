import 'package:flutter/material.dart';

class SimSelectionProvider with ChangeNotifier {
  int? _selectedSimIndex;

  int? get selectedSimIndex => _selectedSimIndex;

  void selectSim(int index) {
    _selectedSimIndex = index;
    notifyListeners(); // Notify listeners to rebuild
  }
}
