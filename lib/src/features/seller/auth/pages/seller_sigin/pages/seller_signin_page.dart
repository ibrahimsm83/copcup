import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/seller/auth/seller_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/auth/widgets/custom_sigi_in_button.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class SellerSigninPage extends StatefulWidget {
  final String role;
  const SellerSigninPage({super.key, required this.role});

  @override
  State<SellerSigninPage> createState() => _SellerSigninPageState();
}

class _SellerSigninPageState extends State<SellerSigninPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final authcontroller = AuthController();

  // @override
  // void initState() {
  //   emailController.text = 'volilijy@azuretechtalk.net';
  //   passwordController.text = 'Zaree@12';
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellerAuthProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        context.goNamed(AppRoute.sigInMethodSelectionPage);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.signInTitle,
                  style: textTheme(context).headlineMedium!.copyWith(
                      color: AppColor.naviBlueColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Fill the information to login account!',
                  style: textTheme(context).headlineMedium!.copyWith(
                      color: AppColor.appGreyColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
                SizedBox(
                  height: 40,
                ),
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
                SizedBox(
                  height: 20,
                ),
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
                            .pushNamed(AppRoute.sellerForgotPassword, extra: {
                          'email': emailController.text,
                          'role': 'seller',
                        });
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
                CustomButton(
                  text: AppLocalizations.of(context)!.signInButton,
                  height: 55,
                  onPressed: () async {
                    final overlay = context.loaderOverlay;

                    if (_formkey.currentState!.validate()) {
                      overlay.show();
                      try {
                        await authcontroller.loginUser(
                          context: context,

                          onError: (val) {
                            overlay.hide();
                          },
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          onSuccess: (val) async {
                            log('--login seller data response -----${val}');
                            if (val == 'seller') {
                              StaticData.isLoggedIn = true;

                              SharedPrefHelper.saveBool(isLoggedInText, true);
                              // SharedPrefHelper.saveInt(sellerEventId, value);

                              StaticData.role = 'seller';
                              SharedPrefHelper.saveString(roleText, 'seller');

                              // showSnackbar(message: 'Sucess$message');
                              Provider.of<SellerAuthController>(context,
                                      listen: false)
                                  .getSellerData();
                              String? fcmToken =
                                  await FirebaseMessaging.instance.getToken();
                              log('FcmToken${fcmToken}');
                              context.goNamed(AppRoute.sellerBottomBar);
                              // MyAppRouter.clearAndNavigate(
                            } else {
                              authcontroller.logout(
                                  context: context,
                                  onSuccess: (va) {},
                                  onError: (v) {});

                              showSnackbar(
                                  message: 'Enter the correct credentials.');
                            }
                            overlay.hide();
                            //     context, AppRoute.sellerBottomBar);
                          },
                          // onError: (error) {
                          //   overlay.hide();
                          //   showSnackbar(message: error, isError: true);
                          // },
                        );
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
                SizedBox(
                  height: 20,
                ),
                // Center(
                //   child: Text(
                //     AppLocalizations.of(context)!.continueButton,
                //     style: textTheme(context)
                //         .labelLarge
                //         ?.copyWith(fontWeight: FontWeight.w400, fontSize: 12),
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                // CustomSigInButton(
                //   svgIconPath: AppIcons.googleIcon,
                //   text: AppLocalizations.of(context)!.continueWithGoogle,
                //   onPressed: () async {
                //     bool isSuccess = await authcontroller.signInWithGoogle(
                //         context, 'seller');

                //     if (isSuccess) {
                //       context.pushNamed(AppRoute.sellerBottomBar);
                //     } else {
                //       print("not logged in");
                //     }
                //   },
                // ),
                const SizedBox(
                  height: 20,
                ),
                // CustomSigInButton(
                //   svgIconPath: AppIcons.appleIcon,
                //   text: AppLocalizations.of(context)!.continueWithApple,
                //   onPressed: () {},
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
