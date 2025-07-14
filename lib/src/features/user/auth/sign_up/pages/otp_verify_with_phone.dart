import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/models/user_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class OtpVerifyWithPhonePage extends StatefulWidget {
  final String password;
  final String email;
  final UserProfile? userProfile;
  const OtpVerifyWithPhonePage({
    super.key,
    required this.email,
    required this.password,
    required this.userProfile,
  });

  @override
  State<OtpVerifyWithPhonePage> createState() => OtpVerifyWithPhonePageState();
}

class OtpVerifyWithPhonePageState extends State<OtpVerifyWithPhonePage> {
  OtpFieldController otpFieldController = OtpFieldController();
  final authcontroller = AuthController();
  String otpField = "";
  String _verificationId = '';
  void verifyPhoneNumber(String phoneNumber) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "OTP Verification",
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "We sent a reset link to your phone number, enter 6  digit code that mentioned in the SMS.",
              style: textTheme(context).bodyLarge?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 100,
            ),
            OTPTextField(
              obscureText: false,
              controller: otpFieldController,
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 45,
              isDense: false,
              outlineBorderRadius: 12,
              spaceBetween: 6,
              contentPadding: EdgeInsets.symmetric(vertical: 13),
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceEvenly,
              fieldStyle: FieldStyle.box,
              onChanged: (pin) {
                otpField = pin;
                log("Current PIN: $pin");
              },
              onCompleted: (pin) {
                otpField = pin;
                log("Completed: $pin");
              },
            ),
            const SizedBox(height: 120),
            CustomButton(
              iconColor: colorScheme(context).primary,
              arrowCircleColor: colorScheme(context).surface,
              text: 'Verify',
              backgroundColor: colorScheme(context).primary,
              onPressed: () {
                if (otpField.length == 6) {
                  print('Verification ID: ${_verificationId}');
                  verifyPhoneNumber(widget.userProfile!.phonenumber);
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  var credential = PhoneAuthProvider.credential(
                      verificationId: _verificationId, smsCode: otpField);

                  _auth.signInWithCredential(credential).then((result) {
                    print('Verification ID: ${_verificationId}');
                    authcontroller.signInWithGoogle(
                      context,
                      'user',
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            height: 380,
                            width: 360,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Lottie.asset(
                                    AppLottieImage.lottieCongrats,
                                    height: 142,
                                    width: 139,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .congratulationsText,
                                  style:
                                      textTheme(context).titleLarge?.copyWith(
                                            color: colorScheme(context)
                                                .onSurface
                                                .withOpacity(0.8),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  AppLocalizations.of(context)!
                                      .accountReadyMessage,
                                  style:
                                      textTheme(context).bodyMedium?.copyWith(
                                            color: colorScheme(context)
                                                .onSurface
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w700,
                                          ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.redirectedText,
                                  style:
                                      textTheme(context).bodyMedium?.copyWith(
                                            color: colorScheme(context)
                                                .onSurface
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w700,
                                          ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.secondsText,
                                  style:
                                      textTheme(context).bodyMedium?.copyWith(
                                            color: colorScheme(context)
                                                .onSurface
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w700,
                                          ),
                                ),
                                SizedBox(height: 20),
                                SpinKitFadingCircle(
                                  color: colorScheme(context)
                                      .onSurface
                                      .withOpacity(0.6),
                                  size: 50.0,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    Future.delayed(
                      Duration(seconds: 6),
                      () {
                        context
                            .pushReplacementNamed(AppRoute.signInPage, extra: {
                          'role': 'user',
                        });
                      },
                    );
                    print("verify ");
                  }).catchError((e) {
                    // ignore: avoid_print
                    print(e);
                  });
                } else {
                  log("Invalid OTP: Please enter a valid 6-digit OTP.");
                  showSnackbar(
                      message: "Please enter a valid 6-digit OTP.",
                      isError: true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
