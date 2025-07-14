// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/main.dart';

import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';

import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/auth/repository/auth_repository.dart';

import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_field.dart';

import 'package:otp_text_field/style.dart';

class ResponsibleCreatePin extends StatefulWidget {
  const ResponsibleCreatePin({
    super.key,
  });

  @override
  State<ResponsibleCreatePin> createState() => _ResponsibleCreatePinState();
}

class _ResponsibleCreatePinState extends State<ResponsibleCreatePin> {
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
              onPressed: () async {
                if (pinCode.length == 4) {
                  context.loaderOverlay.show();
                  await AuthRepositary()
                      .createPinCode(int.parse(pinCode))
                      .then((onValue) {
                    if (onValue) {
                      StaticData.isLoggedIn = true;
                      SharedPrefHelper.saveBool(isLoggedInText, true);

                      context.goNamed(AppRoute.createStripeAccount);
                    } else {
                      showSnackbar(message: 'Something went wront try again');
                    }
                    context.loaderOverlay.hide();
                  });
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
