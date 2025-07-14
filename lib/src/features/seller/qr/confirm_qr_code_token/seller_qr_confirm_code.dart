import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/seller/contact_us/controller/contact_us_controller.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';  
import 'package:provider/provider.dart';

class SellerQrConfirmCode extends StatefulWidget {
  const SellerQrConfirmCode({
    super.key,
  });

  @override
  State<SellerQrConfirmCode> createState() => _SellerQrConfirmCodeState();
}

class _SellerQrConfirmCodeState extends State<SellerQrConfirmCode> {
  final authcontroller = AuthController();
  OtpFieldController otpFieldController = OtpFieldController();
  String otpPin = "";
  Future<void> _handleQrCode(String qrCode) async {
    final provider = Provider.of<ContactUsController>(context, listen: false);
    final sellerHomeProvider =
        Provider.of<SellerHomeProvider>(context, listen: false);
    final message = await provider.verifyQrCode(qrCode);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    context.pop();

    sellerHomeProvider.setCurrentIndex(3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.na_confirmationTokenVerification,
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.na_enterConfirmationCode,
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
                context.loaderOverlay.show();
                if (otpPin.length == 6) {
                  await _handleQrCode(otpPin).then((onValue) {
                    context.loaderOverlay.hide();
                  });
                } else {
                  context.loaderOverlay.hide();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
