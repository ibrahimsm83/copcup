import 'package:flutter/material.dart';


class PaymentMethodProvider extends ChangeNotifier {
  String _selectedPaymentMethod = '';
  bool _receiveBillByEmail = false;

  String get selectedPaymentMethod => _selectedPaymentMethod;
  bool get receiveBillByEmail => _receiveBillByEmail;

  void selectPaymentMethod(String? method) {
    _selectedPaymentMethod = method ?? '';
    notifyListeners();
  }

  void toggleReceiveBillByEmail(bool value) {
    _receiveBillByEmail = value;
    notifyListeners();
  }
}
