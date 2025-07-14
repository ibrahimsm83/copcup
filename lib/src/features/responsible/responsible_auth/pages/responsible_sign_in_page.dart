// ignore_for_file: must_be_immutable, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/features/seller/auth/seller_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/auth/repository/auth_repository.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class ResponsibleSignInPage extends StatefulWidget {
  const ResponsibleSignInPage({super.key});

  @override
  State<ResponsibleSignInPage> createState() => _ResponsibleSignInPageState();
}

class _ResponsibleSignInPageState extends State<ResponsibleSignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    final provider = Provider.of<SellerAuthProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        context.goNamed(AppRoute.sigInMethodSelectionPage);
        return true;
      },
      child: Scaffold(
        appBar: ResponsibleAppBar(
          title: '',
          onLeadingPressed: () {
            context.goNamed(AppRoute.sigInMethodSelectionPage);
          },
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  AppLocalizations.of(context)!.na_professionalAccount,
                  style: textTheme(context).headlineMedium!.copyWith(
                      color: AppColor.naviBlueColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.na_professionalAccountInfo,
                  style: textTheme(context).headlineMedium!.copyWith(
                      color: AppColor.appGreyColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
                SizedBox(height: 40),
                CustomTextFormField(
                  validationType: ValidationType.email,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hint: AppLocalizations.of(context)!.emailHint,
                  borderRadius: 12,
                  inputAction: TextInputAction.next,
                  hintColor: colorScheme(context).onSurface.withOpacity(.5),
                  controller: emailController,
                  filled: true,
                  fillColor: colorScheme(context).surface,
                  borderColor: colorScheme(context).onSurface.withOpacity(.10),
                  height: 60,
                  focusBorderColor:
                      colorScheme(context).onSurface.withOpacity(.10),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppIcons.emailIcon,
                      height: 15,
                    ),
                  ),
                  isDense: true,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hint: AppLocalizations.of(context)!.passwordHint,
                  validationType: ValidationType.password,
                  borderRadius: 12,
                  hintColor: colorScheme(context).onSurface.withOpacity(.5),
                  controller: passwordController,
                  filled: true,
                  fillColor: colorScheme(context).surface,
                  borderColor: colorScheme(context).onSurface.withOpacity(.10),
                  height: 60,
                  focusBorderColor:
                      colorScheme(context).onSurface.withOpacity(.10),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppIcons.lockIcon,
                      height: 19,
                    ),
                  ),
                  obscureText: provider.visibility,
                  suffixIcon: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Consumer<SellerAuthProvider>(
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () {
                              value.visibilityChange();
                            },
                            child: Icon(value.visibility == false
                                ? Icons.visibility
                                : Icons.visibility_off),
                          );
                        },
                      )),
                  isDense: true,
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Consumer<SellerAuthProvider>(
                      builder: (context, value, child) => GestureDetector(
                        onTap: () {
                          value.rememberChangeStatus();
                        },
                        child: Container(
                          height: 19,
                          width: 19,
                          child: value.remember == true
                              ? Icon(
                                  Icons.check,
                                  size: 15,
                                )
                              : SizedBox(),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.appGreenColor, width: 1.5)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          provider.rememberChangeStatus();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.rememberMe,
                          style: textTheme(context)
                              .bodyLarge
                              ?.copyWith(color: AppColor.appGreyColor),
                        ),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        context
                            .pushNamed(AppRoute.responsibleforgotPasswordPage);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgotPassword,
                        style: textTheme(context)
                            .bodyLarge
                            ?.copyWith(color: AppColor.appGreyColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                Consumer<AuthController>(
                  builder: (context, authcontroller, child) => CustomButton(
                    text: AppLocalizations.of(context)!.signInButton,
                    height: 55,
                    onPressed: () async {
                      final overlay = context.loaderOverlay;

                      if (_formkey.currentState!.validate()) {
                        overlay.show();
                        try {
                          await authcontroller
                              .responsibleLogin(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context,
                          )
                              .then((onValue) {
                            StaticData.isLoggedIn = true;
                            SharedPrefHelper.saveBool(isLoggedInText, true);
                            overlay.hide();
                          });

                          // await authcontroller.loginUser(
                          //     context: context,
                          //     email: emailController.text,
                          //     password: passwordController.text,
                          //     onError: (val) {
                          //       overlay.hide();
                          //     },
                          //     onSuccess: (val) {
                          //       if (val == 'professional') {
                          //         context
                          //             .goNamed(AppRoute.responsibleBottomBar);

                          //         StaticData.isLoggedIn = true;
                          //         SharedPrefHelper.saveBool(
                          //             isLoggedInText, true);
                          //       } else {
                          //         authcontroller.logout(
                          //             context: context,
                          //             onSuccess: (onSuccess) {},
                          //             onError: (d) {});
                          //         showSnackbar(
                          //             message:
                          //                 'Enter the correct credentials.');
                          //       }

                          //       overlay.hide();
                          //     });
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
                    backgroundColor: colorScheme(context).secondary,
                    iconColor: colorScheme(context).secondary,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.na_dontHaveAccount,
                      style: textTheme(context).labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color:
                              colorScheme(context).onSurface.withOpacity(0.6)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(
                          AppRoute.responsiblesignUpPage,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.na_registerHere,
                        style: textTheme(context).labelLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: colorScheme(context).secondary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
