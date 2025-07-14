import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/seller/contact_us/repository/contact_us_repository.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_home_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:provider/provider.dart';

class ContactUsController extends ChangeNotifier {
  final ContactUsRepositary _repository = ContactUsRepositary();
  Future<void> contactUs({
    required String name,
    required String email,
    required String message,
    required Function(String message) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final bool isSucess = await _repository.contactUs(
        email,
        email,
        message,
      );

      if (isSucess) {
        onSuccess('contact us successfully for $email');
      } else {
        onError('Contact us failed failed for $email');
      }
    } catch (e) {
      log('Error in contact us: $e');
      onError('An unexpected error occurred: $e');
    }
  }

  Future<String> verifyQrCode(String qrCode) async {
    try {
      final message = await _repository.verifyQrCode(qrCode);
      return message;

      // if (isVerified) {
      //   return 'Order successfully verified!';
      // } else {
      //   return 'Invalid QR code. Order verification failed.';
      // }
    } catch (e) {
      return 'Error occurred: $e';
    }
  }
}
