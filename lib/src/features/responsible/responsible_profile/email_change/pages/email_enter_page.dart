import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/professional_qr/professional_qr_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/controller/responsible_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:googleapis/chat/v1.dart';
import 'package:provider/provider.dart';
import '../../../../../common/constants/app_images.dart';

class EmailChangePage extends StatefulWidget {
  const EmailChangePage({
    super.key,
  });

  @override
  State<EmailChangePage> createState() => EmailChangePageState();
}

class EmailChangePageState extends State<EmailChangePage> {
  @override
  Widget build(BuildContext context) {
    final authcontroller = AuthController();
    return Scaffold(
      bottomNavigationBar: ResponsibleBottomBarWidget(),
      body: Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => page[value.currentIndex],
      ),
    );
  }

  List<Widget> page = [
    ResponsibleHomePage(),
    ResponsibleStock(),
    ProfessionalQrScanPage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resChangeEmail
            ? ResponsibleChangeEmailWidget()
            : ResponsibleProfilePage()),
  ];
}

class ResponsibleChangeEmailWidget extends StatelessWidget {
  ResponsibleChangeEmailWidget({super.key});

  @override
  final email = TextEditingController();
  final ResponsibleAuthController responsibleAuthController =
      ResponsibleAuthController();

  Widget build(BuildContext context) {
    final resNavBarProvider = Provider.of<ResponsibleHomeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back)),
              Text(
                AppLocalizations.of(context)!.na_emailChange,
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
            AppLocalizations.of(context)!.na_enterEmailToChange,
            style: textTheme(context).bodyLarge?.copyWith(
                color: colorScheme(context).onSurface.withOpacity(0.8),
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            validationType: ValidationType.email,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            hint: AppLocalizations.of(context)!.emailHint,
            borderRadius: 12,
            hintColor: colorScheme(context).onSurface.withOpacity(.5),
            controller: email,
            filled: true,
            fillColor: colorScheme(context).surface,
            borderColor: colorScheme(context).onSurface.withOpacity(.10),
            height: 60,
            focusBorderColor: colorScheme(context).onSurface.withOpacity(.10),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(
                AppIcons.emailIcon,
                height: 15,
              ),
            ),
            isDense: true,
          ),
          Spacer(),
          CustomButton(
              iconColor: colorScheme(context).primary,
              arrowCircleColor: colorScheme(context).surface,
              text: AppLocalizations.of(context)!.continueButton,
              backgroundColor: colorScheme(context).secondary,
              onPressed: () async {
                await responsibleAuthController.changeEmail(
                    newEmail: email.text,
                    onSuccess: (message) {
                      resNavBarProvider.updateResponsibleBool(true);
                      context.pushNamed(AppRoute.changeEmailOtpVerifyPage);
                    },
                    onError: (error) {
                      showSnackbar(
                          message: AppLocalizations.of(context)!
                              .na_enterVerifiedEmail);
                    },
                    context: context);
              }),
        ],
      ),
    );
  }
}
