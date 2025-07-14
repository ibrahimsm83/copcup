import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:http/http.dart';

class PaymentRepository {
  final ApiHelper _apiHelper = ApiHelper();

  // //! Make Payment
  // Future<String> makePayment({
  //   required int orderId,
  //   required String coupanCode,
  // }) async {
  //   try {
  //     final data = {
  //       'order_id': orderId,
  //       'coupon_code': coupanCode,
  //     };
  //     final response = await _apiHelper.postRequest(
  //       authToken: StaticData.accessToken,
  //       data: data,
  //       endpoint: "${ApiEndpoints.makePayment}",
  //     );

  //     log('------make payment ${response.statusCode}');
  //     log('------make payment ${response.body}');

  //     if (response.statusCode == 200) {
  //       final responseBody = jsonDecode(response.body);
  //       final url = responseBody['client_secret'];
  //       final paymentIntentId = responseBody['payment_intent_id'];

  //       return url;
  //     } else {
  //       return 'Status Code ${response.statusCode}';
  //     }
  //   } catch (e) {
  //     log('Error making payment: $e');
  //     return 'Error making payment: $e';
  //   }
  // }
  Future<Map<String, String>> makePayment({
    required int orderId,
    required String coupanCode,
  }) async {
    try {
      final data = {
        'order_id': orderId,
        'coupon_code': coupanCode,
      };
      final response = await _apiHelper.postRequest(
        authToken: StaticData.accessToken,
        data: data,
        endpoint: ApiEndpoints.makePayment,
      );

      log('------make payment ${response.statusCode}');
      log('------make payment ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final clientSecret = responseBody['client_secret'];
        final paymentIntentId = responseBody['payment_intent_id'];

        return {
          'client_secret': clientSecret,
          'payment_intent_id': paymentIntentId,
        };
      } else {
        throw Exception('Status Code ${response.statusCode}');
      }
    } catch (e) {
      log('Error making payment: $e');
      throw Exception('Error making payment: $e');
    }
  }

  //! Payment Success
  Future<bool> paymentSuccess({
    required String sessionId,
  }) async {
    try {
      final response = await _apiHelper.postRequest(
        authToken: StaticData.accessToken,
        // data: data,
        endpoint: "${ApiEndpoints.paymentSuccess}/${sessionId}",
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final data = responseBody['order'];
        print(data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error in payment: $e');
      return false;
    }
  }

  Future<void> finalizeOrder(String payment_intent_id) async {
    final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.finalizeOrder,
        authToken: StaticData.accessToken,
        data: {'payment_intent_id': payment_intent_id});
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('----------${response.body}');
      showSnackbar(message: 'Your order has send to the seller. Please wait ');
    } else {
      log('-error---------${response.body}');
    }
  }
}
