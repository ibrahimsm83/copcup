import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/auth/sign_up/helper/otp_response_helper.dart';
import 'package:flutter_application_copcup/src/models/user_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../../common/constants/static_data.dart';

class AuthRepositary {
  final ApiHelper _apiHelper = ApiHelper();

  Future<OtpResponse> sendOtp({
    required String email,
  }) async {
    try {
      final data = {
        'email': email,
      };

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.sendOtp,
        data: data,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final message = responseBody["message"] ?? "OTP sent successfully";
        log('OTP sent successfully to $email');
        return OtpResponse(success: true, mesage: message);
      } else {
        final message = response.body ?? "Failed to send OTP";
        log('Failed to send OTP: $message');
        return OtpResponse(success: false, mesage: message);
      }
    } catch (e) {
      log('Error sending OTP: $e');
      return OtpResponse(
          success: false, mesage: "An error occurred while sending OTP");
    }
  }

  static UserProfile? userProfile;

  Future<bool> verifyUserOtp({
    required String email,
    required String otpCode,
  }) async {
    try {
      final data = {
        'otp': otpCode,
        'email': email,
      };

      log('REQUEST DATA: $data');
      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.verifyOtp,
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

  Future<bool> verifyOtp({
    required String fcmToken,
    required String name,
    required String role,
    required String otpCode,
    required String countryCode,
    required String email,
    required String password,
    required String surName,
    required String contactNumber,
  }) async {
    try {
      final data = {
        'otp': otpCode,
        'password': password,
        'email': email,
        'name': name,
        'role': role,
        'sur_name': surName,
        'contact_number': contactNumber,
        'country_code': countryCode,
      };

      if (fcmToken.isNotEmpty) {
        data['fcm_token'] = fcmToken;
      }

      log('REQUEST DATA: $data');
      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.verifyOtp,
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

  //! ####################### Login #########################
  // Future<Either<String, String>> loginUser({
  //   required String email,
  //   required String password,
  //   required String fcmToken,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     final data = {
  //       'email': email,
  //       'password': password,
  //       'fcm_token': fcmToken,
  //     };

  //     final response = await _apiHelper.postRequest(
  //       endpoint: ApiEndpoints.login,
  //       data: data,
  //     );

  //     final responseBody = jsonDecode(response.body);
  //     final statusCode = response.statusCode;

  //     if (statusCode == 200 || response.statusCode == 201) {
  //       String accessToken = responseBody['access_token'];

  //       int userId = responseBody['user']['id'];

  //       String userEmail = responseBody['user']['email'];

  //       StaticData.accessToken = accessToken;
  //       StaticData.userId = userId;

  //       await SharedPrefHelper.saveAccessToken(accessToken);
  //       SharedPrefHelper.saveInt(id, userId) ?? 0;

  //       SharedPrefHelper.saveString(email, userEmail) ?? 0;
  //       await SharedPrefHelper.saveAccessToken(accessToken);

  //       String dta = responseBody['role'];
  //       // dta.contains('user')
  //       //     ? context.goNamed(AppRoute.userBottomNavBar)
  //       //     : dta.contains('seller')
  //       //         ? context.goNamed(AppRoute.sellerBottomBar)
  //       //         : context.goNamed(AppRoute.responsibleBottomBar);

  //       log('------------------${dta}');
  //       await SharedPrefHelper.saveUserId(userId);

  //       return Right(dta);
  //     } else {
  //       final message = responseBody['message'];
  //       return Left("$statusCode: $message");
  //     }
  //   } catch (e) {
  //     log('Login error: $e');
  //     return Left('An error occurred while logging in: $e');
  //   }
  // }

  Future<Either<String, String>> loginUser({
    required String email,
    required String password,
    required String fcmToken,
    required BuildContext context,
  }) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'fcm_token': fcmToken,
      };

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.login,
        data: data,
      );

      final responseBody = jsonDecode(response.body);
      final statusCode = response.statusCode;

      if (statusCode == 200 || statusCode == 201) {
        String accessToken = responseBody['access_token'];
        int userId = responseBody['user']['id'];
        String userEmail = responseBody['user']['email'];
        String role = responseBody['role'];

        // Save to static and shared preferences
        StaticData.accessToken = accessToken;
        StaticData.userId = userId;
        await SharedPrefHelper.saveAccessToken(accessToken);
        await SharedPrefHelper.saveInt('id', userId);
        await SharedPrefHelper.saveString('email', userEmail);
        await SharedPrefHelper.saveUserId(userId);

        log('User role: $role');

        if (role == 'seller') {
          // Get assigned event category ID (if exists)
          final assignedEvents = responseBody['user']['assigned_events'];
          if (assignedEvents != null && assignedEvents.isNotEmpty) {
            int eventCategoryId = assignedEvents[0]['id'];
            StaticData.sellerEventId = eventCategoryId;
            await SharedPrefHelper.saveInt(sellerEventId, eventCategoryId);

            log('--------------------------------- $eventCategoryId');
            return Right(
                'seller'); // or return eventCategoryId.toString() if you want
          } else {
            log('Seller has no assigned events.');
            return Right('seller_no_events');
          }
        } else {
          // For other users (e.g. user, responsible, etc.)
          return Right(role); // This could be 'user', 'responsible', etc.
        }
      } else {
        final message = responseBody['error'];
        return Left("$statusCode: $message");
      }
    } catch (e) {
      log('Login error: $e');
      return Left('An error occurred while logging in: $e');
    }
  }

  //! ####################### FORGOT PASSWORD #########################
  Future<OtpResponse> sendOtptoforgetPassword({
    required String email,
  }) async {
    try {
      final data = {
        'email': email,
      };

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.forgotPassword,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final message = responseBody["message"] ?? "OTP sent successfully";
        log('OTP sent successfully to $email');
        return OtpResponse(success: true, mesage: message);
      } else {
        final message = response.body;
        log('Failed to send OTP: $message');
        return OtpResponse(success: false, mesage: message);
      }
    } catch (e) {
      log('Error sending OTP: $e');
      return OtpResponse(
          success: false, mesage: "An error occurred while sending OTP");
    }
  }

  //! ####################### VERIFY OTP FOR RESET PASSWORD #########################
  Future<bool> verifyOtpforResetPassword({
    required String token,
    required String email,
  }) async {
    try {
      final data = {
        'token': token,
        'email': email,
      };

      log('Verifying OTP for Reset Password with data: $data');

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.verifyOtpforResetPassword,
        data: data,
      );

      if (response.statusCode == 200) {
        log('OTP Verified Successfully');
        return true;
      } else {
        log('Server Error: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Exception: $e', error: e);
      log('API Endpoint: ${ApiEndpoints.verifyOtpforResetPassword}');
      return false;
    }
  }

  //! ####################### RESET PASSWORD #########################
  Future<bool> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    try {
      final data = {
        'email': email,
        'token': token,
        'password': newPassword,
      };

      log('Reset Password Payload: $data');

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.passwordReset,
        data: data,
      );

      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log('Password Reset Successful: ${jsonResponse['message']}');
        return true;
      } else {
        log('Password Reset Failed: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Exception during password reset: $e');
      return false;
    }
  }

  Future<Either<String, String>> registerUser(
      String email,
      String password,
      String contactNumber,
      String fcmToken,
      String name,
      String surname,
      String countryCode) async {
    try {
      final data = {
        'name': name,
        'sur_name': surname,
        'email': email,
        'password': password,
        'contact_number': contactNumber,
        'fcm_token': fcmToken,
        'country_code': countryCode,
      };
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('data', json.encode(data));
      log('User data saved locally');
      log('FCM Token: $fcmToken');

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.register,
        data: data,
      );
      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log('Otp Send Sucessfully');

        return Right('Login successful');
      } else {
        log('Request failed with status ');

        final message = responseBody['message'];
        return Left("$message");
      }
    } catch (e) {
      log('Error during registration: $e');
      return Left('error :$e');
    }
  }

  //! ####################### LOGOUT ###########################
  Future<Either<String, String>> logout() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.logOut,
        authToken: token,
      );

      final statusCode = response.statusCode;
      final resonseBody = jsonDecode(response.body);
      if (statusCode == 200 || statusCode == 201) {
        return Right("Logout Successfully");
      } else {
        final message = resonseBody['message'];
        return Left("$statusCode: $message");
      }
    } catch (e, stackTrace) {
      log("Error while logout: $e, StackTrace: $stackTrace");
      return Left("Error while Logout: $e");
    }
  }

  //! ################### CONTINUE WITH GOOGLE ########################
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw Exception('Account exists with a different credential');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Invalid credential');
      }
    } catch (e) {
      throw Exception('Google Sign-In failed: ${e.toString()}');
    }
    return null;
  }

  //! ################### CONTINUE WITH Apple ########################

  Future<User?> signInWithApple() async {
    try {
      // Check if Apple Sign-In is available
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create an OAuth credential for Firebase
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(oauthCredential);
      return userCredential.user;
    } catch (e) {
      print("Apple Sign-In Error: $e");
      return null;
    }
  }

  //! ################### LOGIN WITH FIREBASE API ########################

  Future loginWithFirebaseAPI({
    required String idToken,
    String role = 'user',
  }) async {
    final uri = Uri.parse('https://copcup.miftatech.com/api/firebase-login');

    final headers = {
      'Accept': 'application/json',
      'Accept-Language': 'fr',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'id_token': idToken,
      'role': role,
    });

    final resp = await http
        .post(uri, headers: headers, body: body)
        .timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      log("message: ${json['message']}");
      log("access_token: ${json['access_token']}");
    } else {
      throw Exception(
          'Failed to login (HTTP ${resp.statusCode}): ${resp.body}');
    }
  }
  // Future<Either<String, String>> loginWithFirebaseAPI(
  //     String firebaseToken, String role) async {
  //   try {
  //     final token = firebaseToken;
  //     if (token == null || token.isEmpty) {
  //       throw Exception('Authorization token is missing or expired');
  //     }

  //     log('--------Role user  ------${token}');
  //     final response = await _apiHelper.postRequest(
  //       endpoint: ApiEndpoints.firebaseLogin,
  //       data: {
  //         'id_token': token,
  //         'role': role,
  //       },
  //       h: {
  //         'Accept': 'application/json',
  //         'Accept-Language': "fr",
  //         'Content-Type': 'application/json',
  //       },
  //       // authToken: firebaseToken,
  //     );
  //     log('------------RESPONSE ------${response.statusCode}');
  //     log('------------TOKEN ------${token}');
  //     log('------------AUTHORIXATION TOJEN ------${firebaseToken}');

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       log('Response$response');
  //       final responseBody = jsonDecode(response.body);
  //       String accessToken = responseBody['access_token'];
  //       int userId = responseBody['user']['id'];
  //       log(userId.toString());
  //       StaticData.isLoggedIn = true;
  //       StaticData.accessToken = accessToken;
  //       StaticData.userId = userId;
  //       await SharedPrefHelper.saveAccessToken(accessToken);
  //       await SharedPrefHelper.saveUserId(userId);

  //       await SharedPrefHelper.saveBool(isLoggedInText, true);
  //       log('Firebase login successful: ${response.body}');
  //       return Right('Login successful');
  //     } else {
  //       log('Failed to log in with Firebase: ${response.statusCode}');
  //       throw Exception(
  //           'Failed to log in with Firebase: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('API call failed: ${e.toString()}');
  //   }
  // }

  // Future<Either<String, String>> loginWithFirebaseAPI(
  //     String firebaseToken, String role) async {
  //   try {
  //     if (firebaseToken.isEmpty) {
  //       throw Exception('Firebase token is missing');
  //     }

  //     log('--------Role user  ------$role');

  //     final response = await _apiHelper.postRequest(
  //       endpoint: ApiEndpoints.firebaseLogin,
  //       data: {
  //         'id_token': firebaseToken,
  //         'role': role,
  //       },
  //       // If your backend doesn't need Authorization header, remove it
  //       // authToken: firebaseToken,
  //     );

  //     log('------------RESPONSE ------${response.statusCode}');
  //     log('------------TOKEN ------$firebaseToken');

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final responseBody = jsonDecode(response.body);
  //       String accessToken = responseBody['access_token'];
  //       int userId = responseBody['user']['id'];

  //       StaticData.isLoggedIn = true;
  //       StaticData.accessToken = accessToken;
  //       StaticData.userId = userId;

  //       await SharedPrefHelper.saveAccessToken(accessToken);
  //       await SharedPrefHelper.saveUserId(userId);
  //       await SharedPrefHelper.saveBool(isLoggedInText, true);

  //       log('Firebase login successful: ${response.body}');
  //       return Right('Login successful');
  //     } else {
  //       log('Failed to log in with Firebase: ${response.statusCode}');
  //       return Left('Login failed: ${response.body}');
  //     }
  //   } catch (e) {
  //     log('API call failed: $e');
  //     return Left('API call failed: ${e.toString()}');
  //   }
  // }

  Future<bool> loginWithGoogle(
      {required String token, required String role}) async {
    try {
      final response = await _apiHelper.postRequest(
          endpoint: ApiEndpoints.firebaseLogin,
          authToken: token,
          data: {
            'id_token': token,
            'role': role,
          });
      log('==============${response.statusCode}');
      log('##############${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('-----google Signin error---------${e}');
      return false;
    }
  }

  Future<bool> RequestOtpForDeletion() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.requestOtpForDelete,
        authToken: token,
      );

      if (response.statusCode == 200) {
        log('Send Otp for Deletion');
        return true;
      } else {
        log('Request failed with status ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during otp send: $e');
      return false;
    }
  }

  Future<bool> deleteUserProfile() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.deleteProfile,
        authToken: token,
      );

      if (response.statusCode == 200) {
        log('Delete Profile Sucess');
        return true;
      } else {
        log('Request failed with status ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during delete profile: $e');
      return false;
    }
  }

  //?????????========================    responsible login

  Future<void> responsibleLogin({
    required String email,
    required String password,
    required String fcmToken,
    required BuildContext context,
  }) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'fcm_token': fcmToken,
      };

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.login,
        data: data,
      );

      final responseBody = jsonDecode(response.body);
      final statusCode = response.statusCode;

      if (statusCode == 200 || statusCode == 201) {
        String accessToken = responseBody['access_token'];
        int userId = responseBody['user']['id'];
        String userEmail = responseBody['user']['email'];
        String role = responseBody['role'];
        bool isPinRequired = responseBody['is_pin_required'];

        StaticData.accessToken = accessToken;
        StaticData.userId = userId;
        StaticData.email = userEmail;

        await SharedPrefHelper.saveAccessToken(accessToken);
        await SharedPrefHelper.saveInt('id', userId);
        await SharedPrefHelper.saveString('email', userEmail);
        await SharedPrefHelper.saveUserId(userId);

        log('User role: $role');

        if (role == 'professional' && isPinRequired == false) {
          context.pushNamed(AppRoute.responsibleCreatePin);
        } else if (role == 'professional' && isPinRequired == true) {
          context.pushNamed(AppRoute.responsibleLogInPin);
        } else {
          AuthController().logout(
              context: context,
              onSuccess: (onSuccess) {},
              onError: (onError) {});
        }
      } else {
        if (responseBody['error'] == 'messages.Unauthorized') {
          showSnackbar(
              message: 'SomeThing went Wrong. Please try again', isError: true);
        }
        showSnackbar(message: responseBody['error'], isError: true);
      }
    } catch (e) {
      log('Login error: $e');
    }
  }

  Future<bool> createPinCode(int code) async {
    try {
      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.createPinCode,
        authToken: StaticData.accessToken,
        data: {
          'pin': code,
        },
      );

      log('--create otp-----------${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('________$e');
      return false;
    }
  }

  Future<bool> loginWithPinCode(int pinCode, BuildContext context) async {
    try {
      final response = await _apiHelper.postRequest(
          authToken: StaticData.accessToken,
          endpoint: ApiEndpoints.loginPinCode,
          data: {
            'pin': pinCode,
          });
      log('--loginotp-----------${response.body}');
      var decodedData = jsonDecode(response.body);
      log('--loginotp-----------${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        String status = decodedData['message'];
        showSnackbar(message: status, isError: true);
        status.contains('stripe_account_not_created') ||
                status.contains('Stripe onboarding not completed.')
            ? context.pushNamed(AppRoute.createStripeAccount)
            : null;

        return false;
      }
    } catch (e) {
      log('----error----${e}');
      showSnackbar(message: '$e', isError: true);
      return false;
    }
  }

  Future<void> launchInBrowser(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode:
          LaunchMode.externalApplication, // opens in Chrome or default browser
    )) {
      throw Exception('Could not launch $url');
    }
  }

  // Future<void> createStripeAccount({
  //   required int id,
  //   required String email,
  //   required String country,
  // }) async {
  //   try {
  //     final response = await _apiHelper.postRequest(
  //       endpoint: ApiEndpoints.createStripAccount,
  //       authToken: StaticData.accessToken,
  //       data: {
  //         'user_id': id,
  //         'email': email,
  //         'country': country,
  //       },
  //     );

  //     log('Response status: ${response.statusCode}');
  //     log('Response body: ${response.body}');

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       var url = jsonDecode(response.body);
  //       launchInBrowser(url['onboarding_url']);

  //       log('Stripe account created successfully');
  //     } else {
  //       log('Stripe creation failed: ${response.statusCode}');
  //     }
  //   } catch (e, stack) {
  //     log('Stripe account creation error: $e');
  //     log('Stack trace: $stack');
  //   }
  // }
  Future<void> createStripeAccount({
    required int id,
    required String email,
    required String country,
  }) async {
    try {
      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.createStripAccount,
        authToken: StaticData.accessToken,
        data: {
          'user_id': id,
          'email': email,
          'country': country,
        },
      ).timeout(const Duration(seconds: 10));

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final decoded = jsonDecode(response.body);
          final onboardingUrl = decoded['onboarding_url'];

          if (onboardingUrl != null &&
              Uri.tryParse(onboardingUrl)?.hasAbsolutePath == true) {
            log('Launching onboarding URL: $onboardingUrl');
            launchInBrowser(onboardingUrl);
          } else {
            log('Missing or invalid onboarding_url');
          }

          log('Stripe account created successfully');
        } catch (e) {
          log('JSON decoding error: $e');
        }
      } else {
        log('Stripe creation failed: ${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      log('Stripe account creation timed out');
    } catch (e, stack) {
      log('Stripe account creation error: $e');
      log('Stack trace: $stack');
    }
  }
}
