import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';

import 'package:go_router/go_router.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class OTPVerifyDeleteUserPage extends StatefulWidget {
  const OTPVerifyDeleteUserPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OTPVerifyDeleteUserPage> createState() =>
      OTPVerifyDeleteUserPageState();
}

class OTPVerifyDeleteUserPageState extends State<OTPVerifyDeleteUserPage> {
  final OtpFieldController otpFieldController = OtpFieldController();
  final authcontroller = AuthController();
  String otpCode = "";
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'OTP Verification',
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We sent a delete profile link to your email, enter 6 digit code that mentioned in the email',
              style: textTheme(context).bodyLarge?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 100),
            OTPTextField(
              controller: otpFieldController,
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 45,
              outlineBorderRadius: 12,
              spaceBetween: 6,
              contentPadding: const EdgeInsets.symmetric(vertical: 13),
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceEvenly,
              fieldStyle: FieldStyle.box,
              obscureText: false,
              onChanged: (pin) {
                otpCode = pin;
                log("Current PIN: $pin");
              },
              onCompleted: (pin) {
                otpCode = pin;
                log("OTP Entered: $pin");
              },
            ),
            const SizedBox(height: 120),
            CustomButton(
              iconColor: colorScheme(context).primary,
              arrowCircleColor: colorScheme(context).surface,
              text: AppLocalizations.of(context)!.verifyButtonText,
              backgroundColor: colorScheme(context).primary,
              onPressed: () {
                if (otpCode.length == 6) {
                  authcontroller.deleteUserProfile(
                    context,
                    (sucess) {
                      showSnackbar(
                        message: "Your Account Deleted Sucessfully",
                        isError: true,
                      );
                      context.pushNamed(AppRoute.userBottomNavBar);
                    },
                    (error) {
                      showSnackbar(
                        message: "Invalid OTP. Please try again.",
                        isError: true,
                      );
                    },
                  );
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
