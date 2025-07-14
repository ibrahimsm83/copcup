import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
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
class SellerResetPasswordPage extends StatefulWidget {
  final String email;
  final String token;
  final String role;
  const SellerResetPasswordPage(
      {super.key,
      required this.email,
      required this.token,
      required this.role});

  @override
  State<SellerResetPasswordPage> createState() =>
      _SellerResetPasswordPageState();
}

class _SellerResetPasswordPageState extends State<SellerResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authcontroller = AuthController();
    final Visibility =
        Provider.of<PasswordVisibilityProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Reset Password',
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
              Center(
                child: Image.asset(
                  AppImages.createPasswordImage,
                  height: 210,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Create Your New Password',
                style: textTheme(context)
                    .titleMedium
                    ?.copyWith(fontSize: 16, color: AppColor.naviBlueColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<PasswordVisibilityProvider>(
                builder: (context, visibilityProvider, child) {
                  return CustomTextFormField(
                    obscureText: visibilityProvider.isOldPasswordObscured,
                    hint: AppLocalizations.of(context)!.oldPasswordLabel,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validationType: ValidationType.password,
                    borderRadius: 12,
                    hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                    controller: visibilityProvider.oldPassword,
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
                          visibilityProvider.toggleOldPasswordVisibility();
                        },
                        child: visibilityProvider.isOldPasswordObscured
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
                AppLocalizations.of(context)!.newPasswordLabel,
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
              const SizedBox(height: 100),
              CustomButton(
                iconColor: colorScheme(context).primary,
                arrowCircleColor: colorScheme(context).surface,
                text: 'Reset Password',
                backgroundColor: colorScheme(context).primary,
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (Visibility.newPassword.text !=
                        Visibility.oldPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Passwords do not match')),
                      );
                      return;
                    }

                    final overlay = context.loaderOverlay;
                    overlay.show();
                    context.pushNamed(AppRoute.signInPage,
                        extra: {'role': widget.role});
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
                          context.pushNamed(AppRoute.signInPage,
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
