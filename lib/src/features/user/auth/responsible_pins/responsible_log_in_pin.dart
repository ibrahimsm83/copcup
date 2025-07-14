// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/main.dart';

import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';

import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/auth/repository/auth_repository.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';

import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:otp_text_field/otp_field.dart';

import 'package:otp_text_field/style.dart';

class ResponsibleLogInPin extends StatefulWidget {
  const ResponsibleLogInPin({
    super.key,
  });

  @override
  State<ResponsibleLogInPin> createState() => _ResponsibleLogInPinState();
}

class _ResponsibleLogInPinState extends State<ResponsibleLogInPin> {
  OtpFieldController otpFieldController = OtpFieldController();
  String pinCode = "";
  final sellerauthcontroller = SellerAuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Verify Pin Code",
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
              'Add a Pin Number to login your Account .',
              style: textTheme(context).bodySmall?.copyWith(
                  color: AppColor.appGreyColor, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 100,
            ),
            OTPTextField(
              obscureText: false,
              controller: otpFieldController,
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 75,
              isDense: false,
              outlineBorderRadius: 12,
              spaceBetween: 6,
              contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 0),
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceEvenly,
              fieldStyle: FieldStyle.box,
              onChanged: (pin) {
                pinCode = pin;
                log("Current PIN: $pin");
              },
              onCompleted: (pin) {
                pinCode = pin;
                log("Completed: $pin");
              },
            ),
            SizedBox(
              height: 130,
            ),
            CustomButton(
              text: AppLocalizations.of(context)!.continueButton,
              onPressed: () async {
                if (pinCode.length == 4) {
                  context.loaderOverlay.show();
                  await AuthRepositary()
                      .loginWithPinCode(int.parse(pinCode), context)
                      .then((onValue) {
                    if (onValue) {
                      context.loaderOverlay.hide();
                      StaticData.isLoggedIn = true;
                      SharedPrefHelper.saveBool(isLoggedInText, true);

                      context.goNamed(AppRoute.responsibleBottomBar);
                    }
                    context.loaderOverlay.hide();
                  });
                  // sellerauthcontroller.verifyOtp(
                  //     email: widget.email,
                  //     onSuccess: (message) {
                  //       log("Sucess$message");

                  //       showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return Dialog(
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(20.0)),
                  //               child: Container(
                  //                 height: 380,
                  //                 width: 320,
                  //                 child: Column(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.center,
                  //                   children: [
                  //                     Center(
                  //                       child: Lottie.asset(
                  //                         AppLottieImage.lottieCongrats,
                  //                         height: 142,
                  //                         width: 139,
                  //                       ),
                  //                     ),
                  //                     Text(
                  //                       AppLocalizations.of(context)!
                  //                           .congratulations,
                  //                       style: textTheme(context)
                  //                           .titleLarge
                  //                           ?.copyWith(
                  //                               color: colorScheme(context)
                  //                                   .onSurface
                  //                                   .withOpacity(0.8),
                  //                               fontSize: 24,
                  //                               fontWeight: FontWeight.w600),
                  //                     ),
                  //                     SizedBox(
                  //                       height: 20,
                  //                     ),
                  //                     Text(
                  //                       AppLocalizations.of(context)!
                  //                           .na_sellerAccountCreated,
                  //                       style: textTheme(context)
                  //                           .bodyLarge
                  //                           ?.copyWith(
                  //                               color: colorScheme(context)
                  //                                   .onSurface
                  //                                   .withOpacity(0.5),
                  //                               fontWeight: FontWeight.w500),
                  //                     ),
                  //                     SpinKitFadingCircle(
                  //                       color: colorScheme(context)
                  //                           .onSurface
                  //                           .withOpacity(0.6),
                  //                       size: 50.0,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           });
                  //       Future.delayed(Duration(seconds: 4), () {
                  //         context.pop(context);
                  //         context.pushReplacementNamed(
                  //             AppRoute.responsibleBottomBar);
                  //       });
                  //     },
                  //     onError: (error) {
                  //       log("Error$error");
                  //     },
                  //     context: context,
                  //     otpCode: pinCode);
                } else {
                  log("Invalid OTP: Please enter a valid 6-digit OTP.");
                  showSnackbar(
                      message: "Please enter a valid 6-digit OTP.",
                      isError: true);
                }
              },
              backgroundColor: colorScheme(context).secondary,
              iconColor: colorScheme(context).secondary,
            ),
          ],
        ),
      ),
    );
  }
}
