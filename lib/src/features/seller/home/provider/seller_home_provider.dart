import 'package:flutter/material.dart';

class SellerHomeProvider with ChangeNotifier {
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

  bool _acceptOrder = false;
  bool get acceptOrder => _acceptOrder;
  void acceptOrdertrue(boolValue) {
    _acceptOrder = boolValue;
    notifyListeners();
  }

  bool _finishOrder = false;
  bool get finishOrder => _finishOrder;
  void finishOrderTrue(boolValue) {
    _finishOrder = boolValue;
    notifyListeners();
  }

  //_____________________Btm BAr_________________________
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  bool _sellerAllCategoryBool = false;
  bool get sellerAllCategoryBool => _sellerAllCategoryBool;
  bool _sellerNatificationBool = false;
  bool get sellerNatificationBool => _sellerNatificationBool;
  bool _sellerApplanguageBool = false;
  bool get sellerApplanguageBool => _sellerApplanguageBool;
  bool _sellerProfileBool = false;
  bool get sellerProfileBool => _sellerProfileBool;
  bool _sellerChangePasswordBool = false;
  bool get sellerChangePasswordBool => _sellerChangePasswordBool;
  bool _sellerContactUsBool = false;
  bool get sellerContactUsBool => _sellerContactUsBool;

  bool _sellerOrderLimitBool = false;
  bool get sellerOrderLimitBool => _sellerOrderLimitBool;
  bool _sellerGenerateCouponBool = false;
  bool get sellerGenerateCouponBool => _sellerGenerateCouponBool;

  bool _sellerAllCouponBool = false;
  bool get sellerAllCouponBool => _sellerAllCouponBool;

  bool _sellerDeliveryChargerBool = false;
  bool get sellerDeliveryChargerBooll => _sellerDeliveryChargerBool;
  void updateSellerBool(val) {
    _sellerAllCategoryBool = val;
    _sellerDeliveryChargerBool = val;
    _sellerGenerateCouponBool = val;
    _sellerAllCouponBool = val;
    _sellerOrderLimitBool = val;
    _sellerContactUsBool = val;
    _sellerNatificationBool = val;
    _sellerProfileBool = val;
    _sellerChangePasswordBool = val;
    _sellerApplanguageBool = val;
    notifyListeners();
  }
}
