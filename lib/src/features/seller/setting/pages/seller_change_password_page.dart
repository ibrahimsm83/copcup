// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_home_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_stock_page.dart';
import 'package:flutter_application_copcup/src/features/seller/qr/seller_qr_scanner.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/pages/seller_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_setting_page.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/password_visibility_provider.dart';
import 'package:flutter_application_copcup/src/features/user_management/controller/user_manage_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import '../../home/provider/seller_home_provider.dart';

class SellerChangePasswordPage extends StatefulWidget {
  const SellerChangePasswordPage({super.key});

  @override
  State<SellerChangePasswordPage> createState() =>
      SellerChangePasswordPageState();
}

class SellerChangePasswordPageState extends State<SellerChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SellerBottomBarWidget(),
      body: Consumer<SellerHomeProvider>(
          builder: (context, value, child) => pages[value.currentIndex]),
    );
  }

  List<Widget> pages = [
    SellerHomePage(),
    SellerStockPage(),
    SellerQrScanPage(),
    SellerAllOrderPage(),
    Consumer<SellerHomeProvider>(
        builder: (context, value, child) => value.sellerNatificationBool
            ? SellerChangePasswordWidget()
            : SellerSettingPage()),
  ];
}

class SellerChangePasswordWidget extends StatefulWidget {
  const SellerChangePasswordWidget({super.key});

  @override
  State<SellerChangePasswordWidget> createState() =>
      _SellerChangePasswordWidgetState();
}

class _SellerChangePasswordWidgetState
    extends State<SellerChangePasswordWidget> {
  final UserManageController userManageController = UserManageController();
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final visibilityProvider =
        Provider.of<PasswordVisibilityProvider>(context, listen: false);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back)),
              Text(
                AppLocalizations.of(context)!.changePasswordTitle,
                style: textTheme(context).headlineSmall?.copyWith(
                      fontSize: 21,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.oldPasswordLabel,
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
                obscureText: visibilityProvider.isOldPasswordObscured,
                hint: AppLocalizations.of(context)!.oldPasswordLabel,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validationType: ValidationType.password,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: visibilityProvider.oldPassword,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 60,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                            color:
                                colorScheme(context).onSurface.withOpacity(0.8),
                          )
                        : Icon(
                            Icons.visibility_outlined,
                            color:
                                colorScheme(context).onSurface.withOpacity(0.8),
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
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 60,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                            color:
                                colorScheme(context).onSurface.withOpacity(0.8),
                          )
                        : Icon(
                            Icons.visibility_outlined,
                            color:
                                colorScheme(context).onSurface.withOpacity(0.8),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  }
                  if (value != visibilityProvider.newPassword.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: visibilityProvider.reEnterPassword,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 60,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                            color:
                                colorScheme(context).onSurface.withOpacity(0.8),
                          )
                        : Icon(
                            Icons.visibility_outlined,
                            color:
                                colorScheme(context).onSurface.withOpacity(0.8),
                          ),
                  ),
                ),
                isDense: true,
              );
            },
          ),
          const SizedBox(height: 100),
          CustomButton(
            iconColor: colorScheme(context).secondary,
            arrowCircleColor: colorScheme(context).surface,
            text: AppLocalizations.of(context)!.changePasswordButton,
            backgroundColor: colorScheme(context).secondary,
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                bool success = await userManageController.changePassword(
                  context: context,
                  current_password: visibilityProvider.oldPassword.text,
                  newPassword: visibilityProvider.newPassword.text,
                  new_password_confirmation:
                      visibilityProvider.reEnterPassword.text,
                );

                if (success) {
                  visibilityProvider.oldPassword.clear();
                  visibilityProvider.newPassword.clear();
                  visibilityProvider.reEnterPassword.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password updated successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update password')),
                  );
                }
              }
            },
          ),
        ]),
      ),
    );
  }
}
