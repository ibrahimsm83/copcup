import 'package:flutter/material.dart';

class SellerAuthProvider with ChangeNotifier {
  int _selectedRole = 1;
  int get selectedRole => _selectedRole;
  void selectedRolesUpdate(int index) {
    _selectedRole = index;

    notifyListeners();
  }

  bool _visibility = false;
  bool get visibility => _visibility;
  void visibilityChange() {
    _visibility = !visibility;
    notifyListeners();
  }

  bool _remember = false;
  bool get remember => _remember;
  void rememberChangeStatus() {
    _remember = !_remember;
    notifyListeners();
  }

  bool _createdPassword = false;
  bool get createdPassword => _createdPassword;
  void createdPasswordvisibilityChange() {
    _createdPassword = !_createdPassword;
    notifyListeners();
  }

  bool _confirmPassword = false;
  bool get confirmPassword => _confirmPassword;
  void confirmPasswordvisibilityChange() {
    _confirmPassword = !_confirmPassword;
    notifyListeners();
  }
}
