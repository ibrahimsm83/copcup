// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/controller/responsible_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/profile/provider/user_data_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class ResponsibleCreateNewPinPage extends StatefulWidget {
  final String email;
  const ResponsibleCreateNewPinPage({
    super.key,
    required this.email,
  });

  @override
  State<ResponsibleCreateNewPinPage> createState() =>
      _ResponsibleCreateNewPinPageState();
}

class _ResponsibleCreateNewPinPageState
    extends State<ResponsibleCreateNewPinPage> {
  OtpFieldController otpFieldController = OtpFieldController();
  String otp = "";
  final ResponsibleAuthController responsibleAuthController =
      ResponsibleAuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsibleAppBar(
        title: 'Verify Pin',
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter the OTP sent to your email to verify your account!',
                style: textTheme(context).bodySmall?.copyWith(
                      color: AppColor.appGreyColor,
                      fontWeight: FontWeight.w500,
                    ),
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 13, horizontal: 0),
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                fieldStyle: FieldStyle.box,
                onChanged: (pin) {
                  otp = pin;
                  setState(() {});
                },
                onCompleted: (pin) {
                  otp = pin;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 130,
              ),
              Consumer<UserDataProvider>(
                  builder: (context, userdataProvider, child) {
                return CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    if (otp.length == 4) {
                      responsibleAuthController.verifyOtp(
                          email: widget.email,
                          // onSuccess: (message) {
                          //   log("Sucess$message");
                          //   context.pushReplacementNamed(
                          //       AppRoute.responsiblesignInPage,
                          //       extra: {
                          //         'role': 'professional',
                          //       });
                          // },
                          // onError: (error) {
                          //   log("Error$error");
                          // },
                          context: context,
                          otpCode: otp);
                    } else {
                      showSnackbar(
                        message: "Please enter a valid 4-digit OTP.",
                        isError: true,
                      );
                    }
                  },
                  backgroundColor: colorScheme(context).secondary,
                  iconColor: colorScheme(context).secondary,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
