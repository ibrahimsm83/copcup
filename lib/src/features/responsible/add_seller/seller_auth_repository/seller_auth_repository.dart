import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/features/user/chat/repository/chat_repository.dart';
import 'package:flutter_application_copcup/src/models/user_professional_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/api_helper.dart';

class SellerAuthRepository {
  final ApiHelper _apiHelper = ApiHelper();
  ChatRepository chatRepository = ChatRepository();
  Future<bool> registerSeller(
    String name,
    String surname,
    String email,
    String password,
    int eventid,
  ) async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }
    try {
      final data = {
        'name': name,
        'sur_name': surname,
        'email': email,
        'password': password,
        'event_id': eventid,
      };

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.addSellerAccount,
        authToken: token,
        data: data,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('data', json.encode(data));
      log('seller data saved ');
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('-----------Regsiter succesfully ${response.body}');
        final decodedResponse = jsonDecode(response.body);
        await chatRepository.createChatRoom(
            type: 'private',
            members: [StaticData.userId, decodedResponse['seller_id']]);

        return true;
      } else {
        log('Request failed with status ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error during registration: $e');
      return false;
    }
  }

  Future<bool> verifyOtp({
    required String otpCode,
    required String email,
  }) async {
    try {
      final data = {
        'pin': otpCode,
        'email': email,
      };

      log('REQUEST DATA: $data');
      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.verifySellerPin,
        data: data,
      );

      log('RESPONSE STATUS CODE: ${response.statusCode}');
      log('RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        log('OTP verified successfully');
        return true;
      } else {
        log('Failed to verify OTP: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error verifying OTP: $e');
      return false;
    }
  }

  Future<List<UserProfessionalModel>> getAllSeller() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.allSellers,
        authToken: token,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['status'] == 'success' &&
            responseBody['data'] != null) {
          final List data = responseBody['data'];

          return data.map((e) => UserProfessionalModel.fromJson(e)).toList();
        } else {
          log('Error: Invalid data structure or empty data');
          return [];
        }
      } else {
        log('Failed to get sellers. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching sellers: $e');
      return [];
    }
  }

  Future<List<UserProfessionalModel>> getAllProfessionals() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.allProfessionals,
        authToken: token,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List data = responseBody['data'];

        return data.map((e) => UserProfessionalModel.fromJson(e)).toList();
      } else {
        log('Failed to get responsible: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching responsible: $e');
      return [];
    }
  }

  Future<bool> updateSellerProfileRepoData({
    required dynamic profileImage,
    required int id,
    required String name,
    required String email,
    required String password,
    required int eventid,
  }) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final data = {
        'name': name,
        'email': email,
        'password': password,
        'event_id': eventid.toString(),
        '_method': 'put',
      };

      final response = await _apiHelper.postFileRequest(
        authToken: token,
        data: data,
        endpoint: "${ApiEndpoints.editSellerProfile}/$id",
        file: profileImage,
        key: 'image',
      );

      final responseBody = await response.stream.bytesToString();
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: $responseBody');

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Failed to update seller profile. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error updating profile: $e');
      return false;
    }
  }

  Future<UserProfessionalModel?> getSeller() async {
    try {
      final token = StaticData.accessToken;

      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getUser,
        authToken: token,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        log('Raw Response: $responseBody');

        if (responseBody.containsKey('user')) {
          final userData = responseBody['user'];

          List<Role> roles = (userData['roles'] as List<dynamic>?)
                  ?.map((json) => Role.fromJson(json))
                  .toList() ??
              [];

          final user = UserProfessionalModel.fromJson(userData);

          return user;
        } else {
          log('No user data found in the response');
          return null;
        }
      } else {
        log('Failed to get seller: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error fetching user data: $e');
      return null;
    }
  }

  Future<bool> deleteSeller({required String id}) async {
    try {
      final response = await _apiHelper.deleteRequest(
        endpoint: "${ApiEndpoints.deleteUser}/$id",
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error fetching seller: $e');
      return true;
    }
  }
}
