import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/user/auth/sign_up/helper/otp_response_helper.dart';
import 'package:flutter_application_copcup/src/features/user/auth/repository/auth_repository.dart';
import 'package:flutter_application_copcup/src/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends ChangeNotifier {
  final AuthRepositary _repository = AuthRepositary();

  String? _fcmToken;
  File? _image;
  File? get image => _image;
  UserProfile? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserProfile? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool _isUserLoading = false;
  bool get isUserLoading => _isUserLoading;

  Future<void> sendotp({
    required String email,
    required Function(String message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      OtpResponse isOtpSent = await _repository.sendOtp(
        email: email,
      );
      if (isOtpSent.success) {
        onSuccess('OTP sent successfully to ${email}');
      } else {
        onError('${isOtpSent.mesage}');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> verifyOtp({
    required String countryCode,
    required String email,
    required String name,
    required String password,
    required String role,
    required String surName,
    required String contactNumber,
    required Function(String message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
    required String otpCode,
  }) async {
    try {
      log('Starting OTP verification for $otpCode');

      bool isOtpVerified = await _repository.verifyOtp(
        countryCode: countryCode,
        name: name,
        role: role,
        email: email,
        fcmToken: _fcmToken ?? '',
        password: password,
        otpCode: otpCode,
        surName: surName,
        contactNumber: contactNumber,
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

  Future<void> getFCMToken() async {
    _fcmToken = await FirebaseMessaging.instance.getToken();
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // String? token;
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _fcmToken = await messaging.getToken();

      // if (kDebugMode) {
      //   print('Registration Token=$token');
      // }
    }

    log('-fcm get token------------------------${_fcmToken}');
  }

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required Function(String message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      log('---------Saim');
      _isLoading = true;
      notifyListeners();
      await getFCMToken();

      log('Logging in user: $email');
      log('FCM Token: $_fcmToken');

      final isLogin = await _repository.loginUser(
        context: context,
        email: email,
        password: password,
        fcmToken: _fcmToken!,
      );

      isLogin.fold((error) {
        onError(error);
      }, (message) {
        log('-----------check the role ${message}');
        log('-------------------Success fcm token ${_fcmToken}');
        log('-------------------chech the condition if it is user or not ${message == 'user'}');

        onSuccess(message);
      });
    } catch (e) {
      log('Error during login: $e');
      onError('An error occurred: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> responsibleLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      log('---------Saim');
      _isLoading = true;
      notifyListeners();
      await getFCMToken();

      log('Logging in user: $email');
      log('FCM Token: $_fcmToken');

      final isLogin = await _repository.responsibleLogin(
        context: context,
        email: email,
        password: password,
        fcmToken: _fcmToken!,
      );
    } catch (e) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendOtptoforgetPassword({
    required String email,
    required Function(String message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      OtpResponse isOtpSent = await _repository.sendOtptoforgetPassword(
        email: email,
      );
      if (isOtpSent.success) {
        onSuccess('OTP sent successfully to ${email}');
      } else {
        onError('${isOtpSent.mesage}');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> verifyOtpforgotPassword({
    required Function(String message) onSuccess,
    required String email,
    required Function(String error) onError,
    required BuildContext context,
    required String token,
  }) async {
    try {
      bool isOtpVerified = await _repository.verifyOtpforResetPassword(
        token: token,
        email: email,
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

  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
    required BuildContext context,
    required Function(String message) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final isSuccess = await _repository.resetPassword(
        email: email,
        token: token,
        newPassword: newPassword,
      );

      if (isSuccess) {
        onSuccess('Password reset successful!');
      } else {
        onError('Failed to reset password. Please try again.');
      }
    } catch (e) {
      log('Error during password reset: $e');
      onError('An unexpected error occurred. Please try again.');
    } finally {
      notifyListeners();
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String contactNumber,
    required String name,
    required String surname,
    required String countryCode,
    required Function(String message) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      log('Starting registration for: $email');
      await getFCMToken();

      final isRegistered = await _repository.registerUser(
        email,
        password,
        contactNumber,
        _fcmToken ?? '',
        name,
        surname,
        countryCode,
      );
      isRegistered.fold((error) {
        showSnackbar(message: '${error}', isError: true);
        onError('Registration failed for $error[]');
      }, (message) {
        log('--fcm success token ----${_fcmToken}');
        onSuccess('Registration successful for $message');
      });
      // if (isRegistered) {
      // } else {
      //   onError('Registration failed for $email');
      // }
    } catch (e) {
      log('Error in AuthController: $e');
      onError('An unexpected error occurred: $e');
    }
  }

  Future<void> logout({
    required BuildContext context,
    required Function(String sucess) onSuccess,
    required Function(String error) onError,
  }) async {
    print('Logging out...');

    final success = await _repository.logout();

    print('Logout success: $success');

    success.fold((error) {
      onError(error);
    }, (onRight) {
      onSuccess(onRight);
    });
  }

  User? _users;

  User? get users => _users;

  Future<bool> signInWithGoogle(BuildContext context, String role) async {
    try {
      _users = await _repository.signInWithGoogle();

      if (_users != null) {
        final String? token = await _users?.getIdToken(true);
        ;
        if (token != null) {
          await _repository.loginWithFirebaseAPI(idToken: token, role: role);
          log('Tokenid $token');
          return true;
        } else {
          throw Exception('Failed to retrieve Firebase token.');
        }
      } else {
        throw Exception('Google sign-in failed. User is null.');
      }
    } catch (e) {
      print('Error during Google sign-in: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Something went wrong during sign-in. Please try again.'),
        ),
      );

      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> signInWithApple(BuildContext context, String role) async {
    try {
      _users = await _repository.signInWithApple();
      log('here are the result of the apple login: $_users');
      if (_users != null) {
        final String? token = await _users?.getIdToken(true);
        if (token != null) {
          await _repository.loginWithFirebaseAPI(idToken: token, role: role);
          log('Token id $token');
          return true;
        } else {
          throw Exception('Failed to retrieve Firebase token.');
        }
      } else {
        // Google sign-in failed (user is null)
        throw Exception('Apple sign-in failed. User is null.');
      }
    } catch (e) {
      // Handle errors
      print('Error during Apple sign-in: $e');

      // Show a user-friendly message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Something went wrong during sign-in. Please try again.'),
        ),
      );

      return false; // Return false indicating sign-in failed
    } finally {
      // Notify listeners (if needed)
      notifyListeners();
    }
  }

  Future<void> requestOtpDelete(
    BuildContext context,
    Function(String success) onSuccess,
    Function(String error) onError,
  ) async {
    bool success = await _repository.RequestOtpForDeletion();

    if (success) {
      onSuccess('Otp success');
    } else {
      onError('Error send otp  failed. Please try again.');
    }
  }

  Future<void> deleteUserProfile(
    BuildContext context,
    Function(String sucess) onSuccess,
    Function(String error) onError,
  ) async {
    bool success = await _repository.deleteUserProfile();

    if (success) {
      onSuccess('Delete Profile successfully');
    } else {
      onError('Error delete profile  failed. Please try again.');
    }
  }

  //------------- signin with google ------------
  Future<bool> mewSignInWithGoogle() async {
    try {
      final googleUser =
          await GoogleSignIn(scopes: ["profile", "email"]).signIn();
      if (googleUser == null) {
        log('Google Sign-In was canceled by the user.');
        return false;
      }

      final googleAuth = await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        log('Missing Google auth tokens.');
        return false;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      log('google access token \n\n ----${googleAuth.accessToken}\n\n');
      log('google id token \n\n ----${googleAuth.idToken}\n\n');

      await FirebaseAuth.instance.signInWithCredential(credential);

      await AuthRepositary().loginWithGoogle(
        role: 'user',
        token: googleAuth.idToken!, // FIXED
      );

      log('Google Sign-In successful.');
      return true;
    } catch (e) {
      log('Sign-In failed: $e');
      return false;
    }
  }
}
