// ignore_for_file: deprecated_member_use
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/forgot_password_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';

import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class SellerForgotPasswordPage extends StatelessWidget {
  final String role;
  final String email;
  const SellerForgotPasswordPage(
      {super.key, required this.email, required this.role});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForgotPasswordProvider>(context);
    final authcontroller = AuthController();
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.forgotPasswordTitle,
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
                'Select which contact details should we use\nto reset your password',
                style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.8),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              _contactOption(
                context: context,
                title: 'Via Email',
                controller: provider.emailController,
                hintText: 'priscilla.frank26@gmail.com',
                validationType: ValidationType.email,
                isSelected: provider.selectedOption == 'email',
                onTap: () => provider.setSelectedOption('email'),
              ),
              const SizedBox(height: 20),
              _contactOption(
                context: context,
                title: 'Via SMS',
                controller: provider.phoneController,
                hintText: '(+1) 480-894-5529',
                validationType: ValidationType.phoneNumber,
                isSelected: provider.selectedOption == 'phone',
                onTap: () => provider.setSelectedOption('phone'),
              ),
              SizedBox(
                height: 70,
              ),
              CustomButton(
                iconColor: colorScheme(context).secondary,
                arrowCircleColor: colorScheme(context).surface,
                text: AppLocalizations.of(context)!.continueButton,
                backgroundColor: colorScheme(context).secondary,
                onPressed: () async {
                  if (provider.validateInput(context)) {
                    if (provider.selectedOption == 'email') {
                      await authcontroller.sendOtptoforgetPassword(
                        email: provider.emailController.text,
                        context: context,
                        onError: (error) {
                          log("Error$error");
                        },
                        onSuccess: (message) {
                          log("Success$message");
                        },
                      );

                      context.pushNamed(
                        AppRoute.sellerSendOtpWithEmail,
                        extra: {
                          'email': provider.emailController.text,
                          'role': role,
                        },
                      );
                    } else {
                      log("Error$errorTextConfiguration");
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
        height: 140,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(29),
          border: Border.all(
            color: isSelected
                ? colorScheme(context).secondary
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
                  color: colorScheme(context).secondary,
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
                    color: colorScheme(context).secondary,
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
