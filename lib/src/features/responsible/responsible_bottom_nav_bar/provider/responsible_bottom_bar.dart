import 'package:flutter/material.dart';

class ResponsibleHomeProvider with ChangeNotifier {
  bool _switchToggle = false;
  bool get switchToggle => _switchToggle;
  void updateSwitchStatus() {
    _switchToggle = !_switchToggle;
    notifyListeners();
  }

  int _categoryIndex = -1;
  int get categoryIndex => _categoryIndex;
  void selectedCategory(index) {
    _categoryIndex = index;
    notifyListeners();
  }

  //_____________________Btm BAr_________________________
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  bool _resAllCategoryBool = false;
  bool get resAllCategoryBool => _resAllCategoryBool;

  bool _resCreateItem = false;
  bool get resCreateItem => _resCreateItem;

  bool _resFoodDetailBool = false;

  bool get resFoodDetailBool => _resFoodDetailBool;

  bool _resAllSeller = false;

  bool get resAllSeller => _resAllSeller;

  bool _resAllEvents = false;

  bool get resAllEvents => _resAllEvents;

  bool _ressearchPage = false;

  bool get ressearchPage => _ressearchPage;

  bool _resChoseLanguage = false;

  bool get resChoseLanguage => _resChoseLanguage;

  bool _resContactus = false;

  bool get resContactus => _resContactus;

  bool _resChangePassword = false;

  bool get resChangePassword => _resChangePassword;

  bool _resBankAccount = false;

  bool get resBankAccount => _resBankAccount;

  bool _resOrderList = false;

  bool get resOrderList => _resOrderList;

  bool _resSalesReport = false;

  bool get resSalesReport => _resSalesReport;

  bool _resChangeEmail = false;

  bool get resChangeEmail => _resChangeEmail;

  bool _resCreateSeller = false;

  bool get resCreateSeller => _resCreateSeller;

  bool _resVerifyOtp = false;

  bool get resVerifyOtp => resVerifyOtp;

  bool _resAllDelivery = false;

  bool get resAllDelivery => _resAllDelivery;

  bool _resAllOrders = false;

  bool get resAllOrders => _resAllOrders;

  bool _resNotification = false;

  bool get resCoupon => _resCoupon;

  bool _resCoupon = false;

  bool get resNotification => _resNotification;

  bool _resAddCategory = false;

  bool get resCreateCoupon => _resCreateCoupon;

  bool _resCreateCoupon = false;

  bool get resAddCategory => _resAddCategory;

  bool _resDeliveryCharges = false;

  bool get resDeliveryCharges => _resDeliveryCharges;
  void updateResponsibleBool(val) {
    _resDeliveryCharges = val;
    _resCoupon = val;
    _resCreateCoupon = val;
    _resAllOrders = val;
    _resContactus = val;
    _resNotification = val;
    _resAddCategory = val;
    _resChoseLanguage = val;
    _resBankAccount = val;
    _resChangePassword = val;
    _resOrderList = val;
    _resAllDelivery = val;
    _resSalesReport = val;
    _resVerifyOtp = val;
    _resAllEvents = val;
    _resAllCategoryBool = val;
    _resCreateSeller = val;
    _resChangeEmail = val;
    _resAllSeller = val;
    _resFoodDetailBool = val;
    _resCreateItem = val;
    _ressearchPage = val;
    notifyListeners();
  }
}
