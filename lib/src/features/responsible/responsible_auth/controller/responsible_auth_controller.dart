import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/repository/responsible_auth_repository.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/widgets/account_alert_dialog.dart';
import 'package:flutter_application_copcup/src/models/user_professional_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ResponsibleAuthController extends ChangeNotifier {
  final ResponsibleRepository _repository = ResponsibleRepository();
  bool _isProfessionalLoading = false;
  bool get isProfessionalLoading => _isProfessionalLoading;
  UserProfessionalModel? _professional;
  bool _isLoading = false;
  String? _errorMessage;

  UserProfessionalModel? get professional => _professional;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  //! ################ REGISTER #########################
  Future<void> registerResponsible({
    required File bannerImage,
    required BuildContext context,
    required String companyName,
    required String buinessType,
    required String phonenumber,
    required String address,
    required String kbisnumber,
    required String mangerName,
    required String companyEmail,
    required String? eventId,
    required String password,
    // required Function(String message) onSuccess,
    // required Function(String error) onError,
  }) async {
    context.loaderOverlay.show();
    await getFCMToken();
    notifyListeners();
    try {
      final result = await _repository.registerResponsible(
        companyName: companyName,
        buinessType: buinessType,
        password: password,
        address: address,
        phonenumber: phonenumber,
        kbisnumber: kbisnumber,
        mangerName: mangerName,
        companyEmail: companyEmail,
        fcmtoken: _fcmToken!,
        eventId: eventId,
        bannerImage: bannerImage,
      );

      result.fold(
        (error) {
          showSnackbar(message: error, isError: true);
        },
        (message) {
          showSnackbar(message: message);
          context.pushNamed(
            AppRoute.responsibleOtpCreateNewPin,
            extra: companyEmail,
          );
        },
      );

      //   if (isRegistered) {
      //     onSuccess('Registration successful ');
      //   } else {
      //     onError('Registration failed ');
      //   }
    } catch (e) {
      showSnackbar(message: e.toString(), isError: true);
    } finally {
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }

  String? _fcmToken;
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

  //! ################ VERIFY OTP #########################
  Future<void> verifyOtp({
    required String email,
    // required Function(String message) onSuccess,
    // required Function(String error) onError,
    required BuildContext context,
    required String otpCode,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    try {
      final response = await _repository.verifyOtp(
        email: email,
        otpCode: otpCode,
      );

      response.fold(
        (error) {
          showSnackbar(message: error, isError: true);
        },
        (message) {
          showSnackbar(message: message);
          customAlertDialog(
            onPressed: () {
              context.pop();
              MyAppRouter.clearAndNavigate(
                context,
                AppRoute.responsiblesignInPage,
              );
            },
            context: context,
            content:
                "Your account is in preview, You'll receive an email when you are eligible for this.",
          );
        },
      );
    } catch (e) {
      showSnackbar(message: e.toString(), isError: true);
    } finally {
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }

  //! ################ Edit Profile #########################
  Future<void> editResponsibleAccount({
    // required File bannerImage,
    required BuildContext context,
    required String companyName,
    required String buinessType,
    required String phonenumber,
    required String address,
    required String kbisnumber,
    required String email,
    required Function(String message) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final bool isRegistered = await _repository.editResponsibleProfile(
          // bannerImage,
          phonenumber,
          companyName,
          buinessType,
          kbisnumber,
          address,
          email);

      if (isRegistered) {
        onSuccess('responsible account updated successful ');
      } else {
        onError('Updated failed ');
      }
    } catch (e) {
      log('Error in updating responsible: $e');
      onError('An unexpected error occurred: $e');
    }
  }

  Future<void> changeEmail({
    required String newEmail,
    required Function(String message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      bool emailChange = await _repository.changeEmail(
        newEmail: newEmail,
      );

      if (emailChange) {
        onSuccess('chnage Email');
      } else {
        onError('Invalid email, Please try again.');
      }
    } catch (e) {
      onError('Error: ${e.toString()}');
    }
  }

  Future<void> changeEmailVerifyOtp({
    required String verificationCode,
    required Function(String message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      bool emailChange = await _repository.changeEmailVerifyOtp(
        verificationCode: verificationCode,
      );

      if (emailChange) {
        onSuccess('Verify Otp And Changed Email');
      } else {
        onError('Invalid email, Please try again.');
      }
    } catch (e) {
      onError('Error: ${e.toString()}');
    }
  }

  //! ################ GET PROFESSIONAL DETAIL #########################
  UserProfessionalModel? _userProfessionalModel;
  UserProfessionalModel? get userProfessionalModel => _userProfessionalModel;
  Future<void> getProfessionalDetail({
    required BuildContext context,
    required Function(String message) onError,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();

    try {
      final result = await _repository.getProfessionalDetail();

      result.fold((error) {
        onError(error);
        // customAlertDialog(context: context, content: error, onPressed: () {});
        // showSnackbar(message: error, isError: true);
      }, (professional) {
        _userProfessionalModel = professional;
      });
    } catch (e) {
      showSnackbar(message: e.toString(), isError: true);
      print('Error in getting professional details: $e');
    } finally {
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }
}
