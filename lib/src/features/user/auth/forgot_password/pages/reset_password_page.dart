import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/password_visibility_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String token;
  final String role;
  const ResetPasswordPage(
      {super.key,
      required this.email,
      required this.token,
      required this.role});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authcontroller = AuthController();
    final Visibility =
        Provider.of<PasswordVisibilityProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.resetPasswordTitle,
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.resetPasswordDescription,
                style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<PasswordVisibilityProvider>(
                builder: (context, visibilityProvider, child) {
                  return CustomTextFormField(
                    obscureText: visibilityProvider.isNewPasswordObscured,
                    hint: AppLocalizations.of(context)!.newPasswordLabel,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validationType: ValidationType.password,
                    borderRadius: 12,
                    hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                    controller: visibilityProvider.newPassword,
                    filled: true,
                    fillColor: colorScheme(context).surface,
                    borderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    height: 60,
                    focusBorderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(
                        AppIcons.lockIcon,
                        height: 19,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          visibilityProvider.toggleNewPasswordVisibility();
                        },
                        child: visibilityProvider.isNewPasswordObscured
                            ? Icon(
                                Icons.visibility_off_outlined,
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.8),
                              )
                            : Icon(
                                Icons.visibility_outlined,
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.8),
                              ),
                      ),
                    ),
                    isDense: true,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                AppLocalizations.of(context)!.confirmPasswordLabel,
                style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<PasswordVisibilityProvider>(
                builder: (context, visibilityProvider, child) {
                  return CustomTextFormField(
                    obscureText: visibilityProvider.isConfirmPasswordObscured,
                    hint: AppLocalizations.of(context)!.confirmPasswordLabel,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validationType: ValidationType.password,
                    borderRadius: 12,
                    hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                    controller: visibilityProvider.reEnterPassword,
                    filled: true,
                    fillColor: colorScheme(context).surface,
                    borderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    height: 60,
                    focusBorderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(
                        AppIcons.lockIcon,
                        height: 19,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          visibilityProvider.toggleConfirmPasswordVisibility();
                        },
                        child: visibilityProvider.isConfirmPasswordObscured
                            ? Icon(
                                Icons.visibility_off_outlined,
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.8),
                              )
                            : Icon(
                                Icons.visibility_outlined,
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.8),
                              ),
                      ),
                    ),
                    isDense: true,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(height: 100),
              CustomButton(
                iconColor: colorScheme(context).primary,
                arrowCircleColor: colorScheme(context).surface,
                text: AppLocalizations.of(context)!.resetPasswordButton,
                backgroundColor: colorScheme(context).primary,
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (Visibility.newPassword.text !=
                        Visibility.reEnterPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Passwords do not match')),
                      );
                      return;
                    }

                    final overlay = context.loaderOverlay;
                    overlay.show();

                    try {
                      await authcontroller.resetPassword(
                        email: widget.email,
                        token: widget.token,
                        newPassword: Visibility.newPassword.text,
                        context: context,
                        onSuccess: (message) {
                          overlay.hide();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message)),
                          );
                          context.pushReplacementNamed(AppRoute.signInPage,
                              extra: {'role': widget.role});
                        },
                        onError: (error) {
                          overlay.hide();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error)),
                          );
                        },
                      );
                    } catch (e) {
                      overlay.hide();
                      log('Unexpected error: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('An error occurred. Please try again.')),
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
}
