import 'package:flutter/material.dart';

class PasswordVisibilityProvider extends ChangeNotifier {
  bool _isOldPasswordObscured = true;
  bool _isNewPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _isPasswordObscured = true;
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final reEnterPassword = TextEditingController();
  final password = TextEditingController();

  bool get isPasswordObscured => _isPasswordObscured;
  bool get isOldPasswordObscured => _isOldPasswordObscured;
  bool get isNewPasswordObscured => _isNewPasswordObscured;
  bool get isConfirmPasswordObscured => _isConfirmPasswordObscured;

  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  void toggleOldPasswordVisibility() {
    _isOldPasswordObscured = !_isOldPasswordObscured;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _isNewPasswordObscured = !_isNewPasswordObscured;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
    notifyListeners();
  }
}

class CheckboxProvider extends ChangeNotifier {
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  void toggleChecked() {
    _isChecked = !_isChecked;
    notifyListeners();
  }
}
