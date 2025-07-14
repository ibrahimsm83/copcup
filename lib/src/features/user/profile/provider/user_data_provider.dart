import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/models/user_professional_model.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UserDataProvider extends ChangeNotifier {
  final ApiHelper _apiHelper = ApiHelper();

  bool _isLoading = false;
  String? _errorMessage;
  UserProfessionalModel? _user;

  UserProfessionalModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool _isUserLoading = false;
  bool get isUserLoading => _isUserLoading;

  //! Get All Users

  Future<void> getUsersData() async {
    _isUserLoading = true;
    notifyListeners();
    log('fetching user');
    _user = await getUser();
    notifyListeners();
    log('user data ${user!.id}');
    if (_user != null) {
      log('data fetched');
    }
    _isUserLoading = false;
    notifyListeners();
    print(user);
  }

  Future<UserProfessionalModel?> getUser() async {
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
        log('Token-===============${token}');
        final responseBody = jsonDecode(response.body);
        _user = UserProfessionalModel.fromJson(responseBody['user']);
        log('${response}');
        log('${token}');
        notifyListeners();

        return _user;
      } else {
        log('Failed to get user: ${response.statusCode}');
        notifyListeners();

        return null;
      }
    } catch (e) {
      log('Error fetching user list: $e');
      return null;
    }
  }

  Future<UserProfessionalModel?> getUserById({required int userId}) async {
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
        final responseBody = jsonDecode(response.body);
        _user = UserProfessionalModel.fromJson(responseBody['user']);

        return _user;
      } else {
        log('Failed to get user: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error fetching user list: $e');
      return null;
    }
  }

  // Future<void> updateProfileControllerData(
  //     {required BuildContext context,
  //     required dynamic profileimage,
  //     required String name,
  //     required String email,
  //     required String contact_number,
  //     required String countryCode,
  //     required int id}) async {
  //   context.loaderOverlay.show();

  //   final bool result = await updateProfileRepoData(
  //     countryCode: countryCode,
  //     name: name,
  //     profileImage: profileimage,
  //     id: id,
  //     email: email,
  //     contact_number: contact_number,
  //   ).whenComplete(getUsersData);
  //   if (result) {
  //     context.loaderOverlay.hide();
  //     showSnackbar(message: "user updated successfully");
  //     notifyListeners();
  //   } else {
  //     context.loaderOverlay.hide();
  //     showSnackbar(message: "somthing went wrong", isError: true);
  //   }
  // }
  Future<void> updateProfileControllerData(
      {required BuildContext context,
      required dynamic profileimage,
      required String name,
      required String email,
      required String contact_number,
      required String countryCode,
      required int id}) async {
    context.loaderOverlay.show();

    final bool result = await updateProfileRepoData(
      countryCode: countryCode,
      name: name,
      profileImage: profileimage,
      id: id,
      email: email,
      contact_number: contact_number,
    ).whenComplete(getUsersData);
    if (result) {
      context.loaderOverlay.hide();
      showSnackbar(message: "user updated successfully");
      notifyListeners();
    } else {
      context.loaderOverlay.hide();
      showSnackbar(message: "somthing went wrong", isError: true);
    }
  }

  Future<bool> updateProfileRepoData({
    required dynamic profileImage,
    required int id,
    required String name,
    required String email,
    required String contact_number,
    required String countryCode,
  }) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final data = {
        'name': name,
        'email': email,
        'contact_number': contact_number,
        'country_code': countryCode,
      };

      final response = await _apiHelper.postFileRequest(
        authToken: token,
        data: data,
        endpoint: "${ApiEndpoints.updateProfile}/$id",
        file: profileImage,
        key: 'image',
      );

      final responseBody = await response.stream.bytesToString();
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: $responseBody');

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Failed to update profile. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error updating profile: $e');
      return false;
    }
  }
}
