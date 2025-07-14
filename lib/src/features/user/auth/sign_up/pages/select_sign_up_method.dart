import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/forgot_password_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/models/user_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common/widgets/custom_app_bar.dart';
import '../../../../../common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class SelectSignUpMethod extends StatefulWidget {
  final UserProfile user;
  final String password;
  const SelectSignUpMethod({
    super.key,
    required this.user,
    required this.password,
  });

  @override
  State<SelectSignUpMethod> createState() => _SelectSignUpMethodState();
}

class _SelectSignUpMethodState extends State<SelectSignUpMethod> {
  Future registerUser(String number) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: widget.user.phonenumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        print(error);
      },
      codeSent: (verificationId, forceResendingToken) {
        context.goNamed(AppRoute.otpVerificationPhonePage, extra: {
          'email': widget.user.email,
          'userProfile': widget.user,
          'password': widget.password,
        });

        print("code sent");
        print(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    log("User Data: ${widget.user.toJson()}");
    final provider = Provider.of<ForgotPasswordProvider>(context);
    final authcontroller = AuthController();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'OTP for Account Creation',
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'select which contact details should we use to verify your information',
                style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.8),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              _contactOption(
                context: context,
                title: 'Via Email',
                controller: provider.emailController..text = widget.user.email,
                hintText: widget.user.email,
                validationType: ValidationType.email,
                isSelected: provider.selectedOption == 'email',
                onTap: () => provider.setSelectedOption('email'),
              ),
              const SizedBox(height: 20),
              _contactOption(
                context: context,
                title: 'Via SMS',
                controller: provider.phoneController
                  ..text = widget.user.phonenumber,
                hintText: widget.user.phonenumber,
                validationType: ValidationType.phoneNumber,
                isSelected: provider.selectedOption == 'phone',
                onTap: () => provider.setSelectedOption('phone'),
              ),
              SizedBox(
                height: 70,
              ),
              CustomButton(
                iconColor: colorScheme(context).primary,
                arrowCircleColor: colorScheme(context).surface,
                text: AppLocalizations.of(context)!.continueButton,
                backgroundColor: colorScheme(context).primary,
                onPressed: () async {
                  if (provider.validateInput(context)) {
                    final overlay = context.loaderOverlay;
                    overlay.show();

                    try {
                      final prefs = await SharedPreferences.getInstance();
                      final dataToSave = {
                        'email': provider.emailController.text,
                        'contact_number': provider.phoneController.text,
                      };
                      await prefs.setString('data', json.encode(dataToSave));

                      if (provider.selectedOption == 'email') {
                        await authcontroller.registerUser(
                          countryCode: widget.user.countryCode.toString(),
                          onError: (error) {
                            showSnackbar(message: error, isError: true);
                          },
                          onSuccess: (message) {
                            context.goNamed(
                              AppRoute.otpVerificationEmailPage,
                              extra: {
                                'email': provider.emailController.text,
                                'userProfile': widget.user,
                                'password': widget.password,
                              },
                            );

                            overlay.hide();
                            showSnackbar(message: message, isError: false);
                          },
                          name: widget.user.name,
                          surname: widget.user.surname,
                          email: widget.user.email,
                          password: widget.password,
                          contactNumber: widget.user.phonenumber,
                        );
                        // await authcontroller.sendotp(
                        //   context: context,
                        //   email: provider.emailController.text,
                        //   onSuccess: (message) {
                        //     context.goNamed(
                        //       AppRoute.otpVerificationEmailPage,
                        //       extra: {
                        //         'email': provider.emailController.text,
                        //         'userProfile': widget.user,
                        //         'password': widget.password,
                        //       },
                        //     );
                        //     overlay.hide();
                        //     showSnackbar(message: message, isError: false);
                        //   },
                        //   onError: (error) {
                        //     overlay.hide();
                        //     showSnackbar(message: error, isError: true);
                        //   },
                        // );
                      } else if (provider.selectedOption == 'phone') {
                        registerUser(widget.user.phonenumber);
                        overlay.hide();
                        showSnackbar(
                            message: 'Otp send Successfully', isError: false);
                      }
                    } catch (e) {
                      overlay.hide();
                      showSnackbar(
                        message: 'An unexpected error occurred: $e',
                        isError: true,
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactOption({
    required BuildContext context,
    required String title,
    required TextEditingController controller,
    required String hintText,
    required bool isSelected,
    required VoidCallback onTap,
    required ValidationType validationType,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(29),
          border: Border.all(
            color: isSelected
                ? colorScheme(context).primary
                : colorScheme(context).onSurface.withOpacity(0.15),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 90,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme(context).primary,
                  width: 3,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    height: 17,
                    width: 17,
                    AppIcons.emailIcon,
                    color: colorScheme(context).primary,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: textTheme(context).bodySmall?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  CustomTextFormField(
                    readOnly: true,
                    controller: controller,
                    hint: hintText,
                    validationType: validationType,
                    borderColor: Colors.transparent,
                    focusBorderColor: Colors.transparent,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: validationType == ValidationType.email
                        ? TextInputType.emailAddress
                        : TextInputType.phone,
                    inputAction: TextInputAction.done,
                    cursorColor: colorScheme(context).primary,
                    fillColor: colorScheme(context).surface,
                    textStyle: textTheme(context).bodyLarge?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.9),
                          fontWeight: FontWeight.w400,
                        ),
                    hintColor: colorScheme(context).onSurface.withOpacity(0.7),
                    inputFormatters:
                        validationType == ValidationType.phoneNumber
                            ? [FilteringTextInputFormatter.digitsOnly]
                            : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
