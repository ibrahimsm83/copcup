import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  bool _eventBool = false;
  bool get eventBool => _eventBool;

  bool _searchBool = false;
  bool get searchBool => _searchBool;
  bool _languageBool = false;
  bool get languageBool => _languageBool;

  bool _changePasswordBool = false;
  bool get changePasswordBool => _changePasswordBool;

  bool _notificationBool = false;
  bool get notificationBool => _notificationBool;
  bool _transactionBool = false;
  bool get transactionBool => _transactionBool;

  bool _editprofilebool = false;
  bool get editprofilebool => _editprofilebool;
  bool _trackBoolean = false;
  bool get trackBoolean => _trackBoolean;

  bool _paymentMethodBool = false;
  bool get paymentMethodBool => _paymentMethodBool;

  bool _checkoutBool = false;
  bool get checkoutBool => _checkoutBool;

  bool _myCartBool = false;
  bool get myCartBool => _myCartBool;
  bool _allEventBool = false;
  bool get allEventBool => _allEventBool;

  bool _eventCategoryBool = true;
  bool get eventCategoryBool => _eventCategoryBool;

  bool _userContactUsBool = true;
  bool get userContactUsBool => _userContactUsBool;
  void updateEventBool(val) {
    _userContactUsBool = val;
    _notificationBool = val;
    _trackBoolean = val;
    _checkoutBool = val;
    _eventBool = val;
    _eventCategoryBool = val;
    _allEventBool = val;
    _changePasswordBool = val;
    _myCartBool = val;
    _paymentMethodBool = val;
    _editprofilebool = val;
    _transactionBool = val;
    _languageBool = val;
    _searchBool = val;
    notifyListeners();
  }

  String? _qrImage;
  String? get qrImage => _qrImage;

  void getQrImage(String val) {
    _qrImage = val;
    notifyListeners();
  }
}
