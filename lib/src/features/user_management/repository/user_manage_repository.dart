import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
// import 'dart:html' as html;

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/user_management/model/all_users_model.dart';
import 'package:flutter_application_copcup/src/features/user_management/model/incoming_request_model.dart';
import 'package:flutter_application_copcup/src/models/support_message_model.dart';

class UserManageRepository {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<AllUsersModel>> getAllUsers() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getAllUsers,
        authToken: StaticData.accessToken,
      );

      log('Response Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        log('Response Body: $responseBody');

        if (responseBody['success'] == true && responseBody['data'] != null) {
          final List data = responseBody['data'];

          // Returning the mapped data to AllUsersModel
          return data
              .map((userJson) => AllUsersModel.fromJson(userJson))
              .toList();
        } else {
          log('Error: Invalid data structure or empty data');
          return [];
        }
      } else {
        log('Failed to get users. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching users: $e');
      return [];
    }
  }

  Future<List<IncomingRequestModel>> getAllIncomingRequests() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.incomingRequestProfessional,
        authToken: StaticData.accessToken,
      );

      log('Response Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        log('Response Body: $responseBody');

        if (responseBody['success'] == true && responseBody['data'] != null) {
          final List data = responseBody['data'];

          return data
              .map((userJson) => IncomingRequestModel.fromJson(userJson))
              .toList();
        } else {
          log('Error: Invalid data structure or empty data');
          return [];
        }
      } else {
        log('Failed to get users. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching users: $e');
      return [];
    }
  }

  Future<bool> approveProfessionalrequests({required String id}) async {
    try {
      final response = await _apiHelper.getRequest(
          endpoint: "${ApiEndpoints.approveRequestProfessional}/$id",
          authToken: StaticData.accessToken);

      if (response.statusCode == 200) {
        log('Approved');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Approved not: $e');
      return true;
    }
  }

  Future<bool> rejectProfessionalrequests({required String id}) async {
    try {
      final response = await _apiHelper.getRequest(
          endpoint: "${ApiEndpoints.rejectRequestProfessional}/$id",
          authToken: StaticData.accessToken);

      if (response.statusCode == 200) {
        log('Rejected');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Rejected not: $e');
      return true;
    }
  }

  Future<bool> deleteUsers({required int id}) async {
    try {
      final response = await _apiHelper.deleteRequest(
          endpoint: "${ApiEndpoints.deleteUsers}/$id",
          authToken: StaticData.accessToken);

      if (response.statusCode == 200) {
        log('Deleted Succesfully');
        log('$response');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Deleted not: $e');
      return true;
    }
  }

  Future<bool> createUser({
    required String name,
    required String surName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final data = {
        'name': name,
        'email': email,
        'password': password,
        'sur_name': surName,
        'contact_number': phoneNumber,
      };
      final response = await _apiHelper.postRequest(
        authToken: StaticData.accessToken,
        data: data,
        endpoint: ApiEndpoints.createUser,
      );

      if (response.statusCode == 200) {
        print(response);
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      log('Error adding User: $e');
      return false;
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final data = {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      };
      final response = await _apiHelper.postRequest(
        authToken: StaticData.accessToken,
        data: data,
        endpoint: ApiEndpoints.changePassword,
      );

      if (response.statusCode == 200) {
        print(response);
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      log('Password Invalid: $e');
      return false;
    }
  }

  Future<bool> updateUser({
    required Uint8List profileImage,
    required int id,
    required String name,
    required String email,
    required String password,
    required String contact_number,
  }) async {
    try {
      final token = StaticData.accessToken;
      if (token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final data = {
        'name': name,
        'email': email,
        'password': password,
        'contact_number': contact_number,
      };

      final response = await _apiHelper.postFileRequest(
        authToken: token,
        data: data,
        endpoint: "${ApiEndpoints.updateUser}/$id",
        imagepath: profileImage,
        key: 'image',
      );

      final responseBody = await response.stream.bytesToString();
      log('Image file size: ${profileImage.lengthInBytes}');
      log('Response---------------$response');
      log('IMAGE---------------$profileImage');
      print(response.statusCode);
      log('Response Body: $responseBody');
      log('Image-----------------${profileImage.lengthInBytes}');
      log('name$name');
      log('email$email');
      log('phoneno$contact_number');
      log('passwoord$password');

      if (response.statusCode == 200) {
        log('Response:$responseBody');

        return true;
      } else {
        log('Failed to update profile. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e, stc) {
      log('Error updating profile: $e $stc');
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      final token = StaticData.accessToken;
      if (token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.logoutAdmin,
        authToken: token,
      );

      if (response.statusCode == 200) {
        log('Logout successfully');
        return true;
      } else {
        log('Request failed with status ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during logout: $e');
      return false;
    }
  }

  Future<List<SupportMessage>> getAllUserMessages() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getAllUserMessages,
        authToken: StaticData.accessToken,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List data = responseBody['messages'];

        return data.map((e) => SupportMessage.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log('Error fetching messages: $e');
      return [];
    }
  }
}
