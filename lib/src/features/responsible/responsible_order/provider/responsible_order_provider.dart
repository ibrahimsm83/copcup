import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_order/repository/responsible_order_repository.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/repository/order_repository.dart';

class ResponsibleOrderProvider with ChangeNotifier {
  int _orderIndex = 0;
  int get orderIndex => _orderIndex;
  void changeOrderIndexs(index) {
    _orderIndex = index;
    notifyListeners();
  }

  List<OrderModel> _allProfessionalOrders = [];
  List<OrderModel> get allProfessionalOrders => _allProfessionalOrders;
  bool _isAllUserOrdersLoading = false;
  bool get isAllUserOrdersLoading => _isAllUserOrdersLoading;
  Future<void> getProfessionalAllOrders({
    required BuildContext context,
  }) async {
    _isAllUserOrdersLoading = true;
    notifyListeners();
    final result = await ResponsibleOrderRepository.getProfessionalAllOrders();
    result.fold(
      (failure) => showSnackbar(message: 'No Orders', isError: false),
      (allUserOrders) => _allProfessionalOrders = allUserOrders,
    );
    log("all user order list: $_allProfessionalOrders");
    _isAllUserOrdersLoading = false;
    notifyListeners();
  }
}
