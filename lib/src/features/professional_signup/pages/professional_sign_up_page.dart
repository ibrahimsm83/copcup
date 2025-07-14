// ignore_for_file: unused_local_variable, must_be_immutable
import 'dart:developer';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/country_picker_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/password_visibility_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/auth/widgets/custom_sigi_in_button.dart';
import 'package:flutter_application_copcup/src/models/user_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class ProfessionalSignUpPage extends StatefulWidget {
  final String role;
  const ProfessionalSignUpPage({super.key, required this.role});

  @override
  State<ProfessionalSignUpPage> createState() => _ProfessionalSignUpPageState();
}

class _ProfessionalSignUpPageState extends State<ProfessionalSignUpPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final surName = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final visibilityProvider = Provider.of<PasswordVisibilityProvider>(context);
    final checkboxProvider = Provider.of<CheckboxProvider>(context);
    final countryPickerProvider = Provider.of<CountryPickerProvider>(context);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
          key: _formKey,
          child: Consumer<AuthController>(
            builder: (context, authcontroller, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Let’s Sign Up.!',
                    style: textTheme(context).headlineSmall?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Fill the information to Create account!',
                    style: textTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.8),
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hint: 'Name',
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        Validation.fieldValidation(value, 'Name'),
                    borderRadius: 12,
                    hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                    controller: name,
                    filled: true,
                    fillColor: colorScheme(context).surface,
                    borderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    height: 70,
                    focusBorderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    isDense: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hint: 'Sur name',
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        Validation.fieldValidation(value, 'Sur Name'),
                    borderRadius: 12,
                    hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                    controller: surName,
                    filled: true,
                    fillColor: colorScheme(context).surface,
                    borderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    height: 70,
                    focusBorderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    isDense: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hint: 'Email',
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validationType: ValidationType.email,
                    borderRadius: 12,
                    hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                    controller: email,
                    filled: true,
                    fillColor: colorScheme(context).surface,
                    borderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    height: 70,
                    focusBorderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(
                        AppIcons.emailIcon,
                        height: 15,
                      ),
                    ),
                    isDense: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<PasswordVisibilityProvider>(
                    builder: (context, visibilityProvider, child) {
                      return CustomTextFormField(
                        obscureText: visibilityProvider.isPasswordObscured,
                        hint: 'Password',
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validationType: ValidationType.password,
                        borderRadius: 12,
                        hintColor:
                            colorScheme(context).onSurface.withOpacity(0.8),
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
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: _controller,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => Validation.phoneValidation(
                      value,
                    ),
                    textStyle: textTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.w700),
                    borderRadius: 12,
                    hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                    filled: true,
                    fillColor: colorScheme(context).surface,
                    borderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    height: 70,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12),
                    ],
                    focusBorderColor:
                        colorScheme(context).onSurface.withOpacity(.10),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 10.0,
                    ),
                    prefixIcon: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            countryPickerProvider.updateCountry(
                              country.flagEmoji,
                              '+${country.phoneCode}',
                            );
                            // _controller.text = '+${country.phoneCode} ';
                            _controller.selection = TextSelection.fromPosition(
                              TextPosition(offset: _controller.text.length),
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 10),
                          Text(countryPickerProvider.selectedPrefix),
                          const SizedBox(width: 3),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: colorScheme(context).onSurface,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            countryPickerProvider.selectedPrefix,
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(color: colorScheme(context).surface),
                          ),
                        ],
                      ),
                    ),
                    hint: countryPickerProvider.selectedPrefix,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    iconColor: colorScheme(context).primary,
                    arrowCircleColor: colorScheme(context).surface,
                    text: 'Sign up',
                    backgroundColor: colorScheme(context).primary,
                    onPressed: () async {
                      log('the current number is --------------------------\n${_controller.text}');
                      final overlay = context.loaderOverlay;

                      if (_formKey.currentState?.validate() ?? false) {
                        overlay.show();
                        try {
                          final professional = UserProfile(
                            countryCode: countryPickerProvider.selectedPrefix,
                            name: name.text,
                            surname: surName.text,
                            email: email.text,
                            phonenumber: _controller.text,
                            id: 1,
                            profileImage: '',
                            role: 'professional',
                          );
                          context.goNamed(
                            AppRoute.professionalSigInMethodSelectionPage,
                            extra: {
                              'professional': professional,
                              'password': password.text
                            },
                          );
                          // await authcontroller.registerUser(
                          //   onError: (error) {
                          //     showSnackbar(message: error, isError: true);
                          //   },
                          //   onSuccess: (message) {
                          //     context.goNamed(
                          //       AppRoute.professionalSigInMethodSelectionPage,
                          //       extra: {
                          //         'professional': professional,
                          //         'password': password.text
                          //       },
                          //     );
                          //   },
                          //   name: name.text,
                          //   surname: surName.text,
                          //   email: email.text,
                          //   password: password.text,
                          //   contactNumber: _controller.text,
                          //   countryCode: countryPickerProvider.selectedPrefix,
                          // );
                        } finally {
                          overlay.hide();
                        }
                      } else {
                        showSnackbar(
                          message:
                              'Please check the form and fix errors before submitting.',
                          isError: true,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Or Continue With',
                      style: textTheme(context)
                          .bodyLarge
                          ?.copyWith(color: AppColor.appGreyColor),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomSigInButton(
                    svgIconPath: AppIcons.googleIcon,
                    text: 'Continue with Google',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if(Platform.isIOS)
                  CustomSigInButton(
                    svgIconPath: AppIcons.appleIcon,
                    text: 'Continue with Apple',
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
