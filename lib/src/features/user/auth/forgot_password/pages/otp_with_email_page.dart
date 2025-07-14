import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class OtpWithEmailPage extends StatefulWidget {
  final String email;
  final String role;
  const OtpWithEmailPage({
    super.key,
    required this.email,
    required this.role,
  });

  @override
  State<OtpWithEmailPage> createState() => _OtpWithEmailPageState();
}

class _OtpWithEmailPageState extends State<OtpWithEmailPage> {
  final authcontroller = AuthController();
  OtpFieldController otpFieldController = OtpFieldController();
  String otpPin = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.otpVerificationTitle,
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
              AppLocalizations.of(context)!.otpVerificationInstruction,
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
                otpPin = pin;
                log("Current PIN: $pin");
              },
              onCompleted: (pin) {
                otpPin = pin;
                log("Completed: $pin");
              },
            ),
            const SizedBox(height: 120),
            CustomButton(
              iconColor: colorScheme(context).primary,
              arrowCircleColor: colorScheme(context).surface,
              text: AppLocalizations.of(context)!.verifyButtonText,
              backgroundColor: colorScheme(context).primary,
              onPressed: () async {
                if (otpPin.length == 6) {
                  await authcontroller.verifyOtpforgotPassword(
                    email: widget.email,
                    token: otpPin,
                    context: context,
                    onSuccess: (message) {
                      log("OTP Verification Success: $message");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: colorScheme(context).primary,
                        ),
                      );
                      context.pushNamed(AppRoute.resetPasswordPage, extra: {
                        'email': widget.email,
                        'token': otpPin,
                        'role': widget.role
                      });
                    },
                    onError: (error) {
                      log("OTP Verification Failed: $error");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Invalid OTP: Please try again."),
                          backgroundColor: colorScheme(context).error,
                        ),
                      );
                    },
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
