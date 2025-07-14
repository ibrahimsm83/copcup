import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';

class ContactUsRepositary {
  final ApiHelper _apiHelper = ApiHelper();

  Future<bool> contactUs(
    String email,
    String name,
    String message,
  ) async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }
    try {
      final data = {
        'name': name,
        'email': email,
        'message': message,
      };

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.contactUs,
        data: data,
        authToken: token,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('---------${response.body}---------');
        log('Contact us submitted');

        return true;
      } else {
        log('Request failed with status ');
        return false;
      }
    } catch (e) {
      log('Error during registration: $e');
      return false;
    }
  }

  Future<String> verifyQrCode(String qrCode) async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }
    try {
      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.verifyQrCode,
        data: {'qr_code_data': qrCode},
        authToken: StaticData.accessToken,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log('Resonse${response}');
        return responseData['message'] ?? 'Something went wrong!'; // Adjust based on API response
      } else {
        throw Exception('Failed to verify QR code: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error verifying QR code: $e');
    }
  }
}
