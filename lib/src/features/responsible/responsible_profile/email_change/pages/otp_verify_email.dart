import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/controller/responsible_auth_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';

import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class EmailChangeVerifyOtpPage extends StatefulWidget {
  const EmailChangeVerifyOtpPage({
    super.key,
  });

  @override
  State<EmailChangeVerifyOtpPage> createState() =>
      EmailChangeVerifyOtpPageState();
}

class EmailChangeVerifyOtpPageState extends State<EmailChangeVerifyOtpPage> {
  OtpFieldController otpFieldController = OtpFieldController();
  final ResponsibleAuthController responsibleAuthController =
      ResponsibleAuthController();
  String otpEnter = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "OTP Verification",
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "We sent a reset link to your email, enter 6 digit code that mentioned in the email",
              style: textTheme(context).bodyLarge?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 100,
            ),
            OTPTextField(
              obscureText: true,
              controller: otpFieldController,
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 45,
              isDense: false,
              outlineBorderRadius: 12,
              spaceBetween: 6,
              contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 0),
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceEvenly,
              fieldStyle: FieldStyle.box,
              onChanged: (pin) {
                otpEnter = pin;
                log("Current PIN: $pin");
              },
              onCompleted: (pin) {
                otpEnter = pin;
                log("Completed: $pin");
              },
            ),
            const SizedBox(height: 120),
            CustomButton(
              iconColor: colorScheme(context).secondary,
              arrowCircleColor: colorScheme(context).surface,
              text: 'Verify',
              backgroundColor: colorScheme(context).secondary,
              onPressed: () async {
                if (otpEnter.length == 6) {
                  await responsibleAuthController.changeEmailVerifyOtp(
                      verificationCode: otpEnter,
                      onSuccess: (message) {
                        showSnackbar(message: 'Email Changed and verify otp');
                        context.pushNamed(AppRoute.responsibleBottomBar);
                      },
                      onError: (error) {
                        showSnackbar(message: ' Invalid otp');
                      },
                      context: context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
