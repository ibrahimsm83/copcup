import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  bool _paymentSwitch = false;
  bool get paymentSwitch => _paymentSwitch;

  void paymentSwitchToggle() {
    _paymentSwitch = !_paymentSwitch;
    notifyListeners();
  }

  bool _addDataSwitch = false;
  bool get addDataSwitch => _addDataSwitch;

  void addDataSwitchSwitchToggle() {
    _addDataSwitch = !_addDataSwitch;
    notifyListeners();
  }

  bool _cardDataSwitch = false;
  bool get cardDataSwitch => _cardDataSwitch;

  void cardDataSwitchToggle() {
    _cardDataSwitch = !_cardDataSwitch;
    notifyListeners();
  }

  String _monthsText = 'Months';
  String get monthsText => _monthsText;
  void monthTextGet(String text) {
    _monthsText = text;
    notifyListeners();
  }

  String _yearText = 'Year';
  String get yearText => _yearText;
  void yearTextGet(String text) {
    _yearText = text;
    notifyListeners();
  }

  String _cardMonthsText = 'Months';
  String get cardMonthsText => _cardMonthsText;
  void cardMonthsTextTextGet(String text) {
    _cardMonthsText = text;
    notifyListeners();
  }

  String _cardYearText = 'Year';
  String get cardYearText => _cardYearText;
  void cardYearTextTextGet(String text) {
    _cardYearText = text;
    notifyListeners();
  }
}
