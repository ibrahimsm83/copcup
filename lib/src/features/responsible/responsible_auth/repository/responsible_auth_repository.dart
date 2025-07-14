import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/models/user_professional_model.dart';
import 'package:fpdart/fpdart.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ResponsibleRepository {
  final ApiHelper _apiHelper = ApiHelper();

  //! ################ REGISTER #########################
  Future<Either<String, String>> registerResponsible({
    File? bannerImage,
    required String companyName,
    required String buinessType,
    required String address,
    required String phonenumber,
    required String kbisnumber,
    required String mangerName,
    required String companyEmail,
    required String? eventId,
    required String password,
    required String fcmtoken,
  }) async {
    try {
      // final token = StaticData.accessToken;
      // if (token == null || token.isEmpty) {
      //   throw Exception('Authorization token is missing or expired');
      // }

      final data = {
        'company_name': companyName,
        'business_type': buinessType,
        'phone_number': phonenumber,
        'address': address,
        'kbis_number': kbisnumber,
        'banner_image': '',
        'fcm_token': fcmtoken,
        'manager_name': mangerName,
        'company_email': companyEmail,
        'event_id': eventId ?? '',
        'password': password,
      };
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('data', json.encode(data));
      // log('responsible data saved ');

      final response = await _apiHelper.postFileRequest(
        file: bannerImage,
        key: 'banner_image',
        endpoint: ApiEndpoints.addProfessionalAccount,
        data: data,
        authToken: '',
      );

      final streamResponse = await response.stream.bytesToString();

      log("body is ${streamResponse}");

      final statusCode = response.statusCode;
      final responseBody = jsonDecode(streamResponse);

      if (statusCode == 200 || statusCode == 201) {
        final message = responseBody['message'];
        return Right(message);
      } else {
        final message = responseBody['messages'];
        if (message['company_email'] != null) {
          return Left(message['company_email'][0]);
        }
        if (message['banner_image'] != null) {
          return Left(message['banner_image'][0]);
        }
        return Left('${response.statusCode}: $message');
      }
    } catch (e, stackTrace) {
      log('Error during registration: $e, stackTrace: $stackTrace');
      return Left('Error during registration: $e');
    }
  }

  //! ################ VERIFY OTP #########################
  Future<Either<String, String>> verifyOtp({
    required String otpCode,
    required String email,
  }) async {
    try {
      final data = {
        'pin': otpCode,
        'email': email,
      };

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.professionalVerifyPin,
        data: data,
      );

      final statusCode = response.statusCode;
      final responseBody = jsonDecode(response.body);
      final message = responseBody['message'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(message);
      } else {
        return Left("$statusCode: $message");
      }
    } catch (e, stackTrace) {
      log('Error verifying OTP: $e, stackTrace: $stackTrace');
      return Left('Error verifying OTP: $e');
    }
  }

  Future<bool> editResponsibleProfile(
    // File bannerImage,
    String companyName,
    String buinessType,
    String address,
    String phonenumber,
    String kbisnumber,
    String email,
  ) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }
      final data = {
        'company_name': companyName,
        'business_type': buinessType,
        'phone_number': phonenumber,
        'address': address,
        'kbis_number': kbisnumber,
        '_method': 'put',
        'email': email,
      };
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('data', json.encode(data));
      log('responsible data saved ');

      final response = await _apiHelper.postRequest(
        // file: bannerImage,
        // key: 'banner_image',
        endpoint: ApiEndpoints.editProfessionalAccount,
        data: data,
        authToken: token,
      );

      if (response.statusCode == 200) {
        log('responsible account updated succesfully');

        return true;
      } else {
        log('Request failed with status ');
        return false;
      }
    } catch (e) {
      log('Error during update: $e');
      return false;
    }
  }

  Future<bool> changeEmail({
    required String newEmail,
  }) async {
    try {
      final data = {
        'new_email': newEmail,
      };

      log('REQUEST DATA: $data');
      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.changeEmail,
        authToken: StaticData.accessToken,
        data: data,
      );

      log('RESPONSE STATUS CODE: ${response.statusCode}');
      log('RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        log('Email Changed successfully');
        return true;
      } else {
        log('Failed to chnage email: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error changing email: $e');
      return false;
    }
  }

  Future<bool> changeEmailVerifyOtp({
    required String verificationCode,
  }) async {
    try {
      final data = {
        'verification_code': verificationCode,
      };

      log('REQUEST DATA: $data');
      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.verifyEmail,
        authToken: StaticData.accessToken,
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

  UserProfessionalModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserProfessionalModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool _isUserLoading = false;
  bool get isUserLoading => _isUserLoading;

  //! ################ GET PROFESSIONAL DETAILS #########################
  Future<Either<String, UserProfessionalModel>> getProfessionalDetail() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.professionalDetails,
        authToken: token,
      );

      final statusCode = response.statusCode;
      final responseBody = jsonDecode(response.body);
      if (statusCode == 200 || statusCode == 201) {
        final user = UserProfessionalModel.fromJson(responseBody['data']);

        return Right(user);
      } else {
        final message = responseBody['message'];
        return Left('$statusCode $message');
      }
    } catch (e) {
      log('Error fetching details of professional: $e');
      return Left('Error fetching details of professional: $e');
    }
  }
}
