import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/repository/order_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SellerOrderProvider with ChangeNotifier {
  final OrderRepository _orderRepository = OrderRepository();

  int _orderIndexs = 0;
  int get orderIndexs => _orderIndexs;
  void changeOrderIndexs(index) {
    _orderIndexs = index;
    notifyListeners();
  }

  //! Get  All Seller Orders
  List<OrderModel> _allOrders = [];
  List<OrderModel> get allOrders => _allOrders;
  bool _isAllOrdersLoading = false;
  bool get isAllOrdersLoading => _isAllOrdersLoading;

  Future<void> getAllOrders({
    required BuildContext context,
  }) async {
    _isAllOrdersLoading = true;
    notifyListeners();
    final result = await _orderRepository.getAllOrders();
    result.fold(
      (failure) => showSnackbar(message: 'No Orders', isError: false),
      (allOrdersList) => _allOrders = allOrdersList,
    );

    _isAllOrdersLoading = false;
    notifyListeners();
  }

//! Get All User Orders
  List<OrderModel> _allUserOrders = [];
  List<OrderModel> get allUserOrders => _allUserOrders;
  bool _isAllUserOrdersLoading = false;
  bool get isAllUserOrdersLoading => _isAllUserOrdersLoading;

  Future<void> getUserAllOrders({
    required BuildContext context,
  }) async {
    _isAllUserOrdersLoading = true;
    notifyListeners();
    final result = await _orderRepository.getUserAllOrders();
    result.fold(
      (failure) => showSnackbar(message: 'No Orders', isError: false),
      (allUserOrders) => _allUserOrders = allUserOrders,
    );
    log("all user order list: $_allUserOrders");
    _isAllUserOrdersLoading = false;
    notifyListeners();
  }

  //! Confirm Order
  Future<void> confirmOrder({
    required BuildContext context,
    required int orderId,
    required String token,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    final result =
        await _orderRepository.confirmOrder(orderId: orderId, token: token);

    result.fold(
      (failure) => showSnackbar(message: failure, isError: true),
      (success) {
        getAllOrders(context: context);
        showSnackbar(message: success);
        Navigator.pop(context);
      },
    );

    context.loaderOverlay.hide();
    notifyListeners();
  }

  //! Decline Order
  Future<void> declineOrder({
    required BuildContext context,
    required int orderId,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    final result = await _orderRepository.declineOrder(orderId: orderId);

    result.fold(
      (failure) => showSnackbar(message: failure, isError: true),
      (success) {
        getAllOrders(context: context);
        showSnackbar(message: success);
        Navigator.pop(context);
      },
    );

    context.loaderOverlay.hide();
    notifyListeners();
  }

  //! Order Ready
  Future<void> orderReady({
    required BuildContext context,
    required int orderId,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    final result = await _orderRepository.orderReady(orderId: orderId);
    result.fold(
      (failure) => showSnackbar(message: failure, isError: true),
      (success) {
        getAllOrders(context: context);
        showSnackbar(message: success);
        Navigator.pop(context);
      },
    );

    context.loaderOverlay.hide();
    notifyListeners();
  }

  //! Order Ready
  Future<void> orderLimit({
    required BuildContext context,
    required int orderLimit,
    required int eventId,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    final result = await _orderRepository.orderLimit(
        eventId: eventId, orderLimit: orderLimit);

    result.fold(
      (failure) => showSnackbar(message: 'No Limit', isError: false),
      (success) {
        showSnackbar(message: success);
        Navigator.pop(context);
      },
    );

    context.loaderOverlay.hide();
    notifyListeners();
  }

  //! Target Order
  Future<void> targetOrder({
    required BuildContext context,
    required int orderId,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    final result = await _orderRepository.targetOrder(orderId: orderId);

    result.fold(
      (failure) => showSnackbar(message: failure, isError: true),
      (success) {
        showSnackbar(message: success.toString());
        Navigator.pop(context);
      },
    );

    context.loaderOverlay.hide();
    notifyListeners();
  }

  //! Cancel Order
  Future<void> cancelOrder({
    required BuildContext context,
    required int orderId,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    final result = await _orderRepository.cancelOrder(orderId: orderId);
    print("result is $result");

    result.fold(
      (failure) => showSnackbar(message: failure, isError: true),
      (success) {
        showSnackbar(message: success);
        getAllOrders(context: context);
        //Navigator.pop(context);
      },
    );

    context.loaderOverlay.hide();
    notifyListeners();
  }

  // //!
  // bool _acceptOrder = false;
  // bool get acceptOrder => _acceptOrder;
  // void acceptOrdertrue(boolValue) {
  //   _acceptOrder = boolValue;
  //   notifyListeners();
  // }

  // bool _finishOrder = false;
  // bool get finishOrder => _finishOrder;
  // void finishOrderTrue(boolValue) {
  //   _finishOrder = boolValue;
  //   notifyListeners();
  // }
}
