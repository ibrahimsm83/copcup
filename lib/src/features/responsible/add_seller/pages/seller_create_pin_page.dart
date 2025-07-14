// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';

import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';

import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_field.dart';

import 'package:otp_text_field/style.dart';

class SellerCreatePinPage extends StatefulWidget {
  final String email;
  const SellerCreatePinPage({super.key, required this.email});

  @override
  State<SellerCreatePinPage> createState() => _SellerCreatePinPageState();
}

class _SellerCreatePinPageState extends State<SellerCreatePinPage> {
  OtpFieldController otpFieldController = OtpFieldController();
  String pinCode = "";
  final sellerauthcontroller = SellerAuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.createNewPin,
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
              AppLocalizations.of(context)!.addPinNumber,
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
              onPressed: () {
                if (pinCode.length == 4) {
                  sellerauthcontroller.verifyOtp(
                      email: widget.email,
                      onSuccess: (message) {
                        log("Sucess$message");

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Container(
                                  height: 380,
                                  width: 320,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            .congratulations,
                                        style: textTheme(context)
                                            .titleLarge
                                            ?.copyWith(
                                                color: colorScheme(context)
                                                    .onSurface
                                                    .withOpacity(0.8),
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .na_sellerAccountCreated,
                                        style: textTheme(context)
                                            .bodyLarge
                                            ?.copyWith(
                                                color: colorScheme(context)
                                                    .onSurface
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w500),
                                      ),
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
                            });
                        Future.delayed(Duration(seconds: 4), () {
                          context.pop(context);
                          context.pushReplacementNamed(
                              AppRoute.responsibleBottomBar);
                        });
                      },
                      onError: (error) {
                        log("Error$error");
                      },
                      context: context,
                      otpCode: pinCode);
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
