import 'package:flutter/material.dart';

class ResponsibleTransferProvider with ChangeNotifier {
  final RegExp _accountNumberRegex = RegExp(r'^\d{10}$');
  RegExp get accountNumberRegex => _accountNumberRegex;
  bool _validatetrue = false;
  bool get validatetrue => _validatetrue;

  void updateAccountValidation(String val) {
    _validatetrue = accountNumberRegex.hasMatch(val);
    notifyListeners();
  }

  bool _pricevalidate = false;
  bool get pricevalidate => _pricevalidate;

  void updatePriceValidation(val) {
    _pricevalidate = val;
    notifyListeners();
  }

  RegExp _phoneNumberValidation = RegExp(r'^\d{10,11}$');
  RegExp get phoneNumberValidation => _phoneNumberValidation;
  bool _phoneNumbervalidate = false;
  bool get phoneNumbervalidate => _phoneNumbervalidate;

  void updatePhoneNumberValidation(String val) {
    _phoneNumbervalidate = phoneNumberValidation.hasMatch(val);
    notifyListeners();
  }

  bool _amountPrice = false;
  bool get amountPrice => _amountPrice;

  void updateAmountValidation(val) {
    _amountPrice = val;
    notifyListeners();
  }

  bool _verifyNumber = false;
  bool get verifyNumber => _verifyNumber;

  void updateverifyNumberValidation(val) {
    _verifyNumber = val;
    notifyListeners();
  }
}
