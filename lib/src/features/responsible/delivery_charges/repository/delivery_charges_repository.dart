import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/responsible/delivery_charges/model/delivery_charges_model.dart';

class DeliveryChargesRepository {
  ApiHelper _apiHelper = ApiHelper();
  Future<List<DeliveryChargesModel>> getDeliveryCharges() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.deliveryCharges,
      );

      if (response.statusCode == 200) {
        log(response.body);
        final responseBody = jsonDecode(response.body);

        final List<dynamic> data = responseBody['data'];

        return data
            .map((e) =>
                DeliveryChargesModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else {
        print("repository response is $response");
        return [];
      }
    } catch (e) {
      log('Error fetching Delivery Charges: $e');
      return [];
    }
  }

  Future<bool> createDeliveryCharges(
    String sellerid,
    String basedeliveryfee,
    String deliveryperkm,
    String minimumorderfee,
    String freedeliverythreshold,
  ) async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }
    try {
      final data = {
        'professional_id': sellerid,
        'base_delivery_fee': basedeliveryfee,
        'delivery_per_km': deliveryperkm,
        'minimum_order_fee': minimumorderfee,
        'free_delivery_threshold': freedeliverythreshold,
      };

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.createDeliveryCharges,
        data: data,
        authToken: token,
      );

      log('delivery charges created ');
      if (response.statusCode == 200) {
        log('delivery charges succesfully');

        return true;
      } else {
        log('Request failed with status ');
        return false;
      }
    } catch (e) {
      log('Error during creation: $e');
      return false;
    }
  }

  Future<bool> deleteDeliveryCharges({required String id}) async {
    try {
      final response = await _apiHelper
          .deleteRequest(
            endpoint: "${ApiEndpoints.deleteDeliveryCharges}$id",
          )
          .whenComplete(getDeliveryCharges);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error fetching Delievery charges: $e');
      return true;
    }
  }
}
