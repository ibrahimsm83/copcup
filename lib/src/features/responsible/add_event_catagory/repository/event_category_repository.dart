import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/models/event_category_model.dart';

class EventCategoryRepository {
  ApiHelper _apiHelper = ApiHelper();

  Future<List<EventCategoryModel>> getAllEventCategory() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.allEventsCategory,
      );
      log('${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List data = responseBody['data'];

        return data
            .map(
              (e) => EventCategoryModel.fromJson(e),
            )
            .toList();
      } else {
        // final message = response.body ?? "Failed to send OTP";
        // log('Failed to send OTP: $message');
        // return OtpResponse(success: false, mesage: message);
        return [];
      }
    } catch (e) {
      log('Error fetching Events: $e');
      return [];
    }
  }

  Future<List<EventCategoryModel>> getUsersEventCategory() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.userEventCatagory,
      );
      log('${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List data = responseBody['data'];

        return data
            .map(
              (e) => EventCategoryModel.fromJson(e),
            )
            .toList();
      } else {
        // final message = response.body ?? "Failed to send OTP";
        // log('Failed to send OTP: $message');
        // return OtpResponse(success: false, mesage: message);
        return [];
      }
    } catch (e) {
      log('Error fetching Events: $e');
      return [];
    }
  }

  Future<bool> addEventCategory(
      {required String name, required File image}) async {
    try {
      final data = {'category_name': name};
      final response = await _apiHelper.postFileRequest(
        authToken: StaticData.accessToken,
        data: data,
        endpoint: ApiEndpoints.addEventCategory,
        file: image,
        key: 'image',
      );

      // Log response details
      final responseBody = await response.stream.bytesToString();
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: $responseBody');

      if (response.statusCode == 201) {
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

  Future<bool> updateEventCategory(
      {required String name, required File image, required int id}) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }
      final data = {'category_name': name, '_method': 'put'};
      final response = await _apiHelper.postFileRequest(
        authToken: StaticData.accessToken,
        data: data,
        endpoint: "${ApiEndpoints.updateEventCategory}/$id",
        file: image,
        key: 'image',
      );

      final responseBody = await response.stream.bytesToString();
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: $responseBody');

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Failed to update catagory. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error updating catagory: $e');
      return false;
    }
  }

  Future<bool> deleteEventCategory({required String id}) async {
    try {
      final response = await _apiHelper.deleteRequest(
        endpoint: "${ApiEndpoints.deleteEventCategory}/$id",
      );

      if (response.statusCode == 200) {
        // final responseBody = jsonDecode(response.body);
        // String message = responseBody['message'];

        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error fetching Events: $e');
      return true;
    }
  }
}
