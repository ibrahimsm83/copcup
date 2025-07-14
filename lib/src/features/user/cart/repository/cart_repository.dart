import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/user/cart/model/cart_model.dart';

class CartRepository {
  ApiHelper _apiHelper = ApiHelper();
  static double deliveryCharges = 0;

  Future<CartModel?> getAllCarts() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getAllCarts,
      );
      log("---------------------- ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        log('all carts list ${responseBody}');
        final data = responseBody['cart'];
        final deliveryCharges = responseBody['deliveryCharges'];
        print("deliveryCharges is $deliveryCharges");
        return CartModel.fromJson(data);
        // return data.map((e) => CartModel.fromJson(e)).toList();~~
      } else {
        log("repository response is ${response.body}");
        return null;
      }
    } catch (e) {
      log('Error fetching Carts: $e');
      return null;
    }
  }

  //! Add To Cart
  Future<bool> addToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      final data = {
        'quantity': quantity,
      };
      final response = await _apiHelper.postRequest(
        authToken: StaticData.accessToken,
        data: data,
        endpoint: "${ApiEndpoints.addToCart}/${productId}",
      );
      log('...........................response body ${response.body}');
      log('...........................response body ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        log('...........................response body ${responseBody}');
        final message = responseBody['message'];
        print(response);
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      log('Error adding Event: $e');
      return false;
    }
  }

  //! Remove From Cart
  Future<bool> removeFromCart({
    required int productId,
  }) async {
    try {
      final response = await _apiHelper.deleteRequest(
        authToken: StaticData.accessToken,
        endpoint: "${ApiEndpoints.removeFromCart}/${productId}",
      );
      log("---------------respoinse is ${response.body}");

      log('---------${response.statusCode}');
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final message = responseBody['message'];

        log('---------${message}');
        log('---------${responseBody}');
        print(response);
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      log('Error Removing From Cart: $e');
      return false;
    }
  }
}
