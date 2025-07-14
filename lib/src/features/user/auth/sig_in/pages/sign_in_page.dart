// ignore_for_file: override_on_non_overriding_member, unused_local_variable, unused_field
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/password_visibility_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/auth/widgets/custom_sigi_in_button.dart';

import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import '../../../../../common/widgets/custom_textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final email = TextEditingController();

  final password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final authcontroller = AuthController();

  @override
  void initState() {
    super.initState();
    email.text = '';
    password.text = '';
  }

  bool _rememberMe = false;
  bool _isPasswordVisible = false;
  // Future<void> _loadSavedCredentials() async {
  //   email.text = await SharedPrefHelper.getString(emailText) ?? '';
  //   password.text = await SharedPrefHelper.getString(passwordText) ?? '';
  //   setState(() {});
  // }

  // Future<void> _saveCredentials() async {
  //   if (_rememberMe) {
  //     await SharedPrefHelper.saveBool(isLoggedInText, true);
  //     await SharedPrefHelper.saveString(emailText, email.text);
  //     await SharedPrefHelper.saveString(passwordText, password.text);
  //   } else {
  //     await SharedPrefHelper.remove(emailText);
  //     await SharedPrefHelper.remove(passwordText);
  //   }
  // }

  navigate() async {
    // await SharedPrefHelper.saveBool(isLoggedInText, true);

    Future.delayed(const Duration(seconds: 1), () {
      MyAppRouter.clearAndNavigate(context, AppRoute.userBottomNavBar);
      context.loaderOverlay.hide();
    });
  }

  void _onLoginPressed() async {
    // _loadSavedCredentials();
    var getemail = await SharedPrefHelper.getString(emailText);
    log('---------${getemail}');

    // await _saveCredentials();

    navigate();
  }

  @override
  Widget build(BuildContext context) {
    final visibilityProvider = Provider.of<PasswordVisibilityProvider>(context);
    final checkboxProvider = Provider.of<CheckboxProvider>(context);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.signInTitle,
                style: textTheme(context).headlineSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.signInSubtitle,
                style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.8),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                hint: AppLocalizations.of(context)!.emailHint,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validationType: ValidationType.email,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: email,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(0.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(0.10),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    AppIcons.emailIcon,
                    height: 15,
                  ),
                ),
                isDense: true,
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<PasswordVisibilityProvider>(
                builder: (context, visibilityProvider, child) {
                  return CustomTextFormField(
                    obscureText: visibilityProvider.isPasswordObscured,
                    hint: AppLocalizations.of(context)!.passwordHint,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validationType: ValidationType.password,
                    borderRadius: 12,
                    hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                    controller: password,
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
                          visibilityProvider.togglePasswordVisibility();
                        },
                        child: visibilityProvider.isPasswordObscured
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
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _rememberMe = !_rememberMe;
                          });
                        },
                        child: Container(
                          height: 19,
                          width: 19,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.appGreenColor,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            color: _rememberMe
                                ? AppColor.appGreenColor
                                : Colors.transparent,
                          ),
                          child: _rememberMe
                              ? const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        AppLocalizations.of(context)!.rememberMe,
                        style: textTheme(context)
                            .bodyLarge
                            ?.copyWith(color: AppColor.appGreyColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          context.pushNamed(
                            AppRoute.forgotPasswordPage,
                            extra: {
                              'email': email.text,
                              'role': 'user',
                            },
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forgotPassword,
                          style: textTheme(context)
                              .bodyLarge
                              ?.copyWith(color: AppColor.appGreyColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                iconColor: colorScheme(context).primary,
                arrowCircleColor: colorScheme(context).surface,
                text: AppLocalizations.of(context)!.signInButton,
                backgroundColor: colorScheme(context).primary,
                onPressed: () async {
                  final overlay = context.loaderOverlay;

                  if (_formKey.currentState!.validate()) {
                    overlay.show();
                    try {
                      await authcontroller.loginUser(
                          context: context,
                          email: email.text,
                          password: password.text,
                          onError: (va) {
                            if (va.contains('messages.Unauthorized')) {
                              showSnackbar(
                                  message: 'Enter the correct credentials.',
                                  isError: true);
                            }
                            overlay.hide();
                          },
                          onSuccess: (val) {
                            log('-----login screen log value $val');
                            if (val == 'user') {
                              StaticData.isLoggedIn = true;
                              SharedPrefHelper.saveBool(isLoggedInText, true);

                              context.goNamed(AppRoute.userBottomNavBar);
                            } else {
                              authcontroller.logout(
                                  context: context,
                                  onSuccess: (va) {},
                                  onError: (v) {});

                              showSnackbar(
                                  message: 'Enter the correct credentials.');
                            }

                            // MyAppRouter.clearAndNavigate(
                            //     context, AppRoute.userBottomNavBar);
                            overlay.hide();
                          });
                    } catch (e) {
                      overlay.hide();
                      showSnackbar(
                          message: 'An unexpected error occurred: $e',
                          isError: true);
                    }
                  } else {
                    overlay.hide();
                    showSnackbar(
                        message: 'Please check the login credentials.',
                        isError: true);
                  }
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.continueWithText,
                  style: textTheme(context).bodyLarge?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.7),
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomSigInButton(
                svgIconPath: AppIcons.googleIcon,
                text: AppLocalizations.of(context)!.continueWithGoogle,
                onPressed: () async {
                  bool isSuccess = await authcontroller.mewSignInWithGoogle();
                  log('---------after signin with google ------${isSuccess}');
                  // if (isSuccess) {
                  //   MyAppRouter.clearAndNavigate(
                  //       context, AppRoute.userBottomNavBar);
                  // } else {
                  //   print("not logged in");
                  // }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (Platform.isIOS)
                CustomSigInButton(
                  svgIconPath: AppIcons.appleIcon,
                  text: AppLocalizations.of(context)!.continueWithApple,
                  onPressed: () {},
                ),
            ],
          ),
        ),
      ),
    );
  }
}
