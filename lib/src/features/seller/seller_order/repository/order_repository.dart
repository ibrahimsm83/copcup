import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';
import 'package:fpdart/fpdart.dart';

class OrderRepository {
  ApiHelper _apiHelper = ApiHelper();

  Future<Either<String, List<OrderModel>>> getAllOrders() async {
    print("token is ${StaticData.accessToken}");
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.allOrders,
        authToken: StaticData.accessToken,
      );

      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("repository response is ${responseBody['data']}");

        final data = responseBody['data'] as List;

        return Right(data.map((e) => OrderModel.fromJson(e)).toList());
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error fetching Orders: $e');
      return Left('Error fetching Orders: $e');
    }
  }

  Future<Either<String, List<OrderModel>>> getUserAllOrders() async {
    print("token is ${StaticData.accessToken}");
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getUserAllOrders,
        authToken: StaticData.accessToken,
      );

      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log("repository response is ${responseBody['data']}");

        final data = responseBody['data'] as List;

        return Right(data.map((e) => OrderModel.fromJson(e)).toList());
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error fetching Orders: $e');
      return Left('Error fetching Orders: $e');
    }
  }

  // Future<Either<String, OrderModel>> getCurrentOrder() async {
  //   print("token is ${StaticData.accessToken}");
  //   try {
  //     final response = await ApiHelper().getRequest(
  //       endpoint: ApiEndpoints.cartOrderStatus,
  //       authToken: StaticData.accessToken,
  //     );

  //     final responseBody = jsonDecode(response.body);

  //     log('-------log =======  response body of current order ----${responseBody}');
  //     if (response.statusCode == 200) {
  //       log("repository response is ${responseBody['order']}");

  //       // Assuming 'order' now contains a single object, not a list
  //       final data = responseBody['order'];
  //       final order = OrderModel.fromJson(data);

  //       return Right(order);
  //     } else {
  //       log("repository response is ${response.body}");
  //       return Left("${response.statusCode}: Something went wrong");
  //     }
  //   } catch (e) {
  //     log('Error fetching Order: $e');
  //     return Left('Error fetching Order: $e');
  //   }
  // }

  Future<Either<String, OrderModel>> getCurrentOrder() async {
    print("token is ${StaticData.accessToken}");
    try {
      final response = await ApiHelper().getRequest(
        endpoint: ApiEndpoints.cartOrderStatus,
        authToken: StaticData.accessToken,
      );

      final responseBody = jsonDecode(response.body);

      log('-------log =======  response cide ----${response.statusCode}');
      log('-------log =======  response body of current order ----$responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = responseBody['order'];

        if (data != null && data is Map<String, dynamic>) {
          final order = OrderModel.fromJson(data);
          return Right(order);
        } else {
          log("Order data is null or in unexpected format: $data");
          return Left("No current order available");
        }
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error fetching Order: $e');
      return Left('Error fetching Order: $e');
    }
  }

  //! Confrim Order
  Future<Either<String, String>> confirmOrder({
    required int orderId,
    required String token,
  }) async {
    try {
      final data = {
        'order_id': orderId,
        'token': token,
      };
      final response = await _apiHelper.postRequest(
        authToken: StaticData.accessToken,
        data: data,
        endpoint: "${ApiEndpoints.confirmOrder}",
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final message = responseBody['message'];
        print(response);
        return Right(message);
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error Confirm Order: $e');
      return Left('Error Confirm Order: $e');
    }
  }

  //! Decline Order
  Future<Either<String, String>> declineOrder({
    required int orderId,
  }) async {
    try {
      final data = {
        'order_id': orderId,
      };
      final response = await _apiHelper.postRequest(
        authToken: StaticData.accessToken,
        data: data,
        endpoint: "${ApiEndpoints.declineOrder}",
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final message = responseBody['message'];
        print(response);
        return Right(message);
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error Decline Order: $e');
      return Left('Error Decline Order: $e');
    }
  }

  //! Order Ready
  Future<Either<String, String>> orderReady({
    required int orderId,
  }) async {
    try {
      final response = await _apiHelper.postRequest(
        authToken: StaticData.accessToken,
        // data: data,
        endpoint: "${ApiEndpoints.orderReady}/${orderId}",
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final message = responseBody['message'];

        return Right(message);
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error Ready Order: $e');
      return Left('Error Ready Order: $e');
    }
  }

  //! Order Limit
  Future<Either<String, String>> orderLimit({
    required int orderLimit,
    required int eventId,
  }) async {
    try {
      final data = {
        'order_limit': orderLimit,
      };
      final response = await _apiHelper.postRequest(
        authToken: StaticData.accessToken,
        data: data,
        endpoint: "${ApiEndpoints.orderLimit}/${eventId}",
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final message = responseBody['message'];
        print(response);
        return Right(message);
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error Order Limit: $e');
      return Left('Error Order Limit: $e');
    }
  }

  //! Target Order
  Future<Either<String, List<OrderModel>>> targetOrder({
    required int orderId,
  }) async {
    try {
      final response = await _apiHelper.postRequest(
        authToken: StaticData.accessToken,
        // data: data,
        endpoint: "${ApiEndpoints.targetOrder}/${orderId}",
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final data = responseBody['order'] as List;
        print(response);
        return Right(data.map((e) => OrderModel.fromJson(e)).toList());
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error Target Order: $e');
      return Left('Error Target Order: $e');
    }
  }

//! Cancel Order
  Future<Either<String, String>> cancelOrder({
    required int orderId,
  }) async {
    try {
      final response = await _apiHelper.postRequest(
        authToken: StaticData.accessToken,
        // data: data,
        endpoint: "${ApiEndpoints.targetOrder}/${orderId}/cancel",
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final message = responseBody['message'];
        print(response);
        return Right(message);
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error Target Order: $e');
      return Left('Error Target Order: $e');
    }
  }

  // //! Remove From Cart
  // Future<bool> removeFromCart({
  //   required int productId,
  // }) async {
  //   try {
  //     final response = await _apiHelper.deleteRequest(
  //       authToken: StaticData.accessToken,
  //       endpoint: "${ApiEndpoints.removeFromCart}/${productId}",
  //     );
  //     print("respoinse is ${response.body}");
  //     if (response.statusCode == 200) {
  //       final responseBody = jsonDecode(response.body);
  //       final message = responseBody['message'];
  //       print(response);
  //       return true;
  //     } else {
  //       print(response.statusCode);
  //       return false;
  //     }
  //   } catch (e) {
  //     log('Error Removing From Cart: $e');
  //     return false;
  //   }
  // }
}
