import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/seller/coupons/model/coupon_model.dart';
import 'package:fpdart/fpdart.dart';

class CouponsRepository {
  ApiHelper _apiHelper = ApiHelper();

  //! Gel All Coupons Of Current Seller
  Future<Either<String, List<CouponModel>>> getAllCouponsOfSeller({
    required int sellerID,
  }) async {
    print("token is ${StaticData.accessToken}");
    try {
      final response = await _apiHelper.getRequest(
        endpoint: "${ApiEndpoints.allCouponsOfSeller}/${sellerID}",
        authToken: StaticData.accessToken,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final data = responseBody['data'] as List;

        return Right(data.map((e) => CouponModel.fromJson(e)).toList());
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error fetching All Coupans: $e');
      return Left('Error fetching All Coupans: $e');
    }
  }

  //! Generate A Coupon
  Future<Either<String, String>> generateCoupon({
    required int sellerID,
    required int discountAmount,
    required int discountPercentage,
    required String validFrom,
    required String validUntil,
    required int usageLimit,
  }) async {
    print("token is ${StaticData.accessToken}");
    try {
      final data = {
        "professional_id": sellerID,
        "discount_amount": discountAmount,
        "discount_percentage": discountPercentage,
        "valid_from": validFrom,
        "valid_until": validUntil,
        "usage_limit": usageLimit,
      };
      final response = await _apiHelper.postRequest(
        endpoint: "${ApiEndpoints.generateCoupon}",
        data: data,
        authToken: StaticData.accessToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);

        final data = responseBody['message'];

        return Right(data);
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error Generating Coupan: $e');
      return Left('Error Generating Coupan: $e');
    }
  }

  //! Validate Coupon
  Future<Either<String, String>> validateCoupon({
    required int sellerID,
    required String couponCode,
  }) async {
    print("token is ${StaticData.accessToken}");
    try {
      final data = {
        "seller_id": sellerID,
      };
      final response = await _apiHelper.postRequest(
        endpoint: "${ApiEndpoints.validateCoupon}/${couponCode}",
        data: data,
        authToken: StaticData.accessToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);

        final data = responseBody['message'];

        return Right(data);
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error Generating Coupan: $e');
      return Left('Error Generating Coupan: $e');
    }
  }
}
