// ignore_for_file: unused_field

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';

import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_repository/seller_auth_repository.dart';
import 'package:flutter_application_copcup/src/features/user/chat/controller/chat_controller.dart';
import 'package:flutter_application_copcup/src/models/user_professional_model.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SellerAuthController extends ChangeNotifier {
  final ApiHelper _apiHelper = ApiHelper();
  final SellerAuthRepository sellerAuthRepository = SellerAuthRepository();
  bool _isSellerLoading = false;
  bool get isSelerLoading => _isSellerLoading;
  //! Get All Sellers
  List<UserProfessionalModel> _allSellerList = [];
  List<UserProfessionalModel> get allSellerList => _allSellerList;

  Future<void> getSellerList() async {
    _isSellerLoading = true;
    notifyListeners();
    try {
      _allSellerList = await sellerAuthRepository.getAllSeller();
    } catch (error) {
      print("Error fetching sellers: $error");
      _allSellerList = [];
    } finally {
      _isSellerLoading = false;
      notifyListeners();
    }

    print(_allSellerList);
  }

  Future<bool> registerSellerAccount({
    required String name,
    required String surname,
    required String email,
    required String password,
    required BuildContext context,
    required int eventid,
    required Function(String message) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      log('Starting registration for: $email');

      final bool isRegistered = await sellerAuthRepository.registerSeller(
        name,
        surname,
        email,
        password,
        eventid,
      );
      log('Response${isRegistered}');
      if (isRegistered) {
        ChatController controller = ChatController();

// controller.createChatRoom(members: members, type: type, context: context, name: name, onSuccess: onSuccess)
        onSuccess('Registration successful for $email');
        return true;
      } else {
        onError('Registration failed for $email');
        return false;
      }
    } catch (e) {
      log('Error in auth responsible: $e');
      onError('An unexpected error occurred: $e');
      return false;
    }
  }

  Future<void> verifyOtp({
    required String email,
    required Function(String message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
    required String otpCode,
  }) async {
    try {
      log('Starting OTP verification for $otpCode');

      bool isOtpVerified = await sellerAuthRepository.verifyOtp(
        email: email,
        otpCode: otpCode,
      );

      if (isOtpVerified) {
        onSuccess('OTP has been verified');
      } else {
        onError('Invalid OTP, Please try again.');
      }
    } catch (e) {
      onError('Error: ${e.toString()}');
    }
  }

  bool _isResponisbleLoading = false;
  bool get isResponisbleLoading => _isResponisbleLoading;
  //! Get All Responsible
  List<UserProfessionalModel> _allResponisbleList = [];
  List<UserProfessionalModel> get allResponisbleList => _allResponisbleList;

  Future<void> getResponsiblesList() async {
    _isResponisbleLoading = true;
    notifyListeners();
    _allResponisbleList = await sellerAuthRepository.getAllProfessionals();
    _isResponisbleLoading = false;
    notifyListeners();
    print(_allResponisbleList);
  }

  UserProfessionalModel? _seller;
  bool _isLoading = false;
  String? _errorMessage;

  UserProfessionalModel? get seller => _seller;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool _isUserLoading = false;
  bool get isUserLoading => _isUserLoading;

  //! Get All Users

  Future<void> getSellerData() async {
    _isUserLoading = true;
    notifyListeners();
    log('fetching seller');
    _seller = await sellerAuthRepository.getSeller();
    if (_seller != null) {
      log('data fetched');
    }
    _isUserLoading = false;
    notifyListeners();
    print(_seller);
  }

  Future<void> updateSellerProfileControllerData({
    required BuildContext context,
    required dynamic image,
    required String name,
    required String email,
    required String password,
    required int eventid,
    required int id,
    required Function(String message) onSuccess,
    required Function(String error) onError,
  }) async {
    context.loaderOverlay.show();

    final bool result = await sellerAuthRepository
        .updateSellerProfileRepoData(
          name: name,
          profileImage: image,
          id: id,
          email: email,
          password: password,
          eventid: eventid,
        )
        .whenComplete(getSellerData);
    context.loaderOverlay.hide();
    if (result) {
      onSuccess('updated seller profile successful for $email');
    } else {
      onError('updated seller profile failed for $email');
    }
  }

  //! Delete Food Item
  Future<void> deleteSeller({
    required BuildContext context,
    required String id,
  }) async {
    context.loaderOverlay.show();

    final bool result = await sellerAuthRepository.deleteSeller(id: id);

    context.loaderOverlay.hide();
    if (result) {
      showSnackbar(message: "Seller deleted successfully");
      notifyListeners();
    } else {
      showSnackbar(message: "Something went wrong", isError: true);
    }
  }
}
