import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class ResponsibleOtpPhone extends StatefulWidget {
  const ResponsibleOtpPhone({super.key});

  @override
  State<ResponsibleOtpPhone> createState() => _ResponsibleOtpPhoneState();
}

class _ResponsibleOtpPhoneState extends State<ResponsibleOtpPhone> {
  OtpFieldController otpFieldController = OtpFieldController();
  String otpField = "";
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
              "We sent a reset link to your phone number, enter 4 digit code that mentioned in the SMS.",
              style: textTheme(context).bodyLarge?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 100,
            ),
            OTPTextField(
              obscureText: true,
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
              backgroundColor: colorScheme(context).secondary,
              onPressed: () {
                if (otpField.length == 4) {
                  context.pushNamed(AppRoute.responsibleChangePasswordPage);
                } else {
                  log("Invalid OTP: Please enter a 4-digit code.");

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter a 4-digit OTP."),
                      backgroundColor: colorScheme(context).error,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
