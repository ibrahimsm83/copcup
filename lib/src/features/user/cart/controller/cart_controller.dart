import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/user/cart/model/cart_model.dart';
import 'package:flutter_application_copcup/src/features/user/cart/repository/cart_repository.dart';
import 'package:flutter_application_copcup/src/models/food_item_model.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CartController with ChangeNotifier {
  final CartRepository _cartRepository = CartRepository();

  //! Add To Cart

  // Add a new item
  Future<void> addToCart({
    required BuildContext context,
    required int productId,
    required int quantity,
  }) async {
    try {
      context.loaderOverlay.show();
      final bool isAdded = await _cartRepository.addToCart(
          productId: productId, quantity: quantity);
      if (isAdded) {
        showSnackbar(message: "Add to Cart Successfully");
        // context.pop();
      }
    } catch (e) {
      showSnackbar(message: e.toString(), isError: true);

      print('Error in addToCart: $e');
    } finally {
      context.loaderOverlay.hide();
    }
  }

  //! Add to Cart For Loop
  Future<void> addToCartMultiple({
    required BuildContext context,
    required int productId,
    required int quantity,
  }) async {
    try {
      context.loaderOverlay.show();
      final bool isAdded = await _cartRepository.addToCart(
          productId: productId, quantity: quantity);
      if (isAdded) {
        showSnackbar(message: "Add to Cart Successfully");
      }
    } catch (e) {
      showSnackbar(message: e.toString(), isError: true);

      print('Error in addToCart: $e');
    } finally {
      context.loaderOverlay.hide();
    }
  }

  //! Get All Cart
  CartModel? _cart = null;
  CartModel? get cart => _cart;

  List<CartItemModel> _cartItemList = [];
  List<CartItemModel> get cartItemList => _cartItemList;

  List<FoodItemModel> _cartFoodList = [];
  List<FoodItemModel> get cartFoodList => _cartFoodList;

  double? _deliveryCharges = CartRepository.deliveryCharges;
  double? get deliveryCharges => _deliveryCharges;

  Future<void> getAllCarts({
    required BuildContext context,
  }) async {
    try {
      context.loaderOverlay.show();
      _cart = await _cartRepository.getAllCarts();
      print("cart is $_cart");
      if (_cart != null) {
        _cartItemList.clear();
        _cartItemList.addAll(_cart!.cartItems);
        log('the cartItem is this ${_cartItemList.toList()}');
      }
      notifyListeners();
    } catch (e) {
      showSnackbar(message: e.toString(), isError: true);

      print('Error in Fetching Cart Data: $e');
    } finally {
      context.loaderOverlay.hide();
    }
  }

  //! Remove From Cart

  Future<void> removeFromCart(
      {required int productId,
      required BuildContext context,
      required int index}) async {
    try {
      context.loaderOverlay.show();
      final isDeleted =
          await _cartRepository.removeFromCart(productId: productId);

      _cartItemList.removeAt(index);
      await getAllCarts(context: context);
      notifyListeners();

      if (isDeleted) {
        showSnackbar(message: "Removed From Cart Successfully");
      } else {
        showSnackbar(message: "Failed to Removed From Cart", isError: true);
      }
    } catch (e) {
      showSnackbar(message: e.toString(), isError: true);
      print('Error in remove from cart: $e');
    } finally {
      context.loaderOverlay.hide();
    }
  }

  //! Get Subtotal
  double get subTotal {
    return cartItemList.fold(
      0,
      (sum, item) => sum + (item.foodItem.price! * item.quantity),
    );
  }

  double _price = 0;
  double get price => _price;

  updatePrice(double quantity) {
    _price = quantity * price;
    notifyListeners();
  }

  // //! Update Subtotal
  // void updateSubtotal() {
  //   double total = 0.0;

  //   for (var cartItem in _cartItemList) {
  //     total += cartItem.quantity * cartItem.foodItem.price!;
  //   }

  //   subTotal = total; // Update the cart model subtotal
  //   notifyListeners();
  // }
}
