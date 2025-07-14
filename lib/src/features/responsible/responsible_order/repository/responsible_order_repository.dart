import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';
import 'package:fpdart/fpdart.dart';

class ResponsibleOrderRepository {
  static ApiHelper _apiHelper = ApiHelper();

  static Future<Either<String, List<OrderModel>>>
      getProfessionalAllOrders() async {
    print("token is ${StaticData.accessToken}");
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.professionalOrders,
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
}
