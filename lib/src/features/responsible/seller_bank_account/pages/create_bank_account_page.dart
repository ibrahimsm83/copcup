import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/seller_bank_account/controller/seller_bank_controller.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class CreateSellerBankAccount extends StatefulWidget {
  const CreateSellerBankAccount({super.key});

  @override
  State<CreateSellerBankAccount> createState() =>
      _CreateSellerBankAccountState();
}

class _CreateSellerBankAccountState extends State<CreateSellerBankAccount> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SellerBankAccountController>(context);
    return Scaffold(
      bottomNavigationBar: ResponsibleBottomBarWidget(),
      // appBar: ResponsibleAppBar(
      //   title: AppLocalizations.of(context)!.add_bank_account,
      //   onLeadingPressed: () {
      //     context.pop();
      //   },
      // ),
      body: Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => page[value.currentIndex],
      ),
    );
  }

  List<Widget> page = [
    ResponsibleHomePage(),
    ResponsibleStock(),
    InboxPage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resBankAccount
            ? ResponsibleAddSellerBankAccountWidget()
            : ResponsibleProfilePage()),
  ];
}

class ResponsibleAddSellerBankAccountWidget extends StatelessWidget {
  ResponsibleAddSellerBankAccountWidget({super.key});
  final email = TextEditingController();
  final bankname = TextEditingController();
  final accountnumber = TextEditingController();
  final accounttype = TextEditingController();
  final accountholdername = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(Icons.arrow_back)),
                  Text(
                    AppLocalizations.of(context)!.add_bank_account,
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
            ),
            Text(
              AppLocalizations.of(context)!.bank_name,
              style: textTheme(context).titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hint: AppLocalizations.of(context)!.bank_name,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  Validation.fieldValidation(value, 'Account Number'),
              borderRadius: 12,
              hintColor: colorScheme(context).onSurface.withOpacity(0.8),
              controller: bankname,
              filled: true,
              fillColor: colorScheme(context).surface,
              borderColor: colorScheme(context).onSurface.withOpacity(.10),
              height: 70,
              focusBorderColor: colorScheme(context).onSurface.withOpacity(.10),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              isDense: true,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.account_number,
              style: textTheme(context).titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hint: AppLocalizations.of(context)!.account_number,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  Validation.fieldValidation(value, 'Account Number'),
              borderRadius: 12,
              hintColor: colorScheme(context).onSurface.withOpacity(0.8),
              controller: accountnumber,
              filled: true,
              fillColor: colorScheme(context).surface,
              borderColor: colorScheme(context).onSurface.withOpacity(.10),
              height: 70,
              focusBorderColor: colorScheme(context).onSurface.withOpacity(.10),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              isDense: true,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.account_type,
              style: textTheme(context).titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hint: AppLocalizations.of(context)!.account_type,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  Validation.fieldValidation(value, 'Account Type'),
              borderRadius: 12,
              hintColor: colorScheme(context).onSurface.withOpacity(0.8),
              controller: accounttype,
              filled: true,
              fillColor: colorScheme(context).surface,
              borderColor: colorScheme(context).onSurface.withOpacity(.10),
              height: 70,
              focusBorderColor: colorScheme(context).onSurface.withOpacity(.10),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              isDense: true,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.account_holder_name,
              style: textTheme(context).titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hint: AppLocalizations.of(context)!.account_holder_name,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  Validation.fieldValidation(value, 'Account Holder Name'),
              borderRadius: 12,
              hintColor: colorScheme(context).onSurface.withOpacity(0.8),
              controller: accountholdername,
              filled: true,
              fillColor: colorScheme(context).surface,
              borderColor: colorScheme(context).onSurface.withOpacity(.10),
              height: 70,
              focusBorderColor: colorScheme(context).onSurface.withOpacity(.10),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              isDense: true,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.email_address,
              style: textTheme(context).titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
                hint: AppLocalizations.of(context)!.email_address,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validationType: ValidationType.email,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: email,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true),
            SizedBox(
              height: 90,
            ),
            CustomButton(
                iconColor: colorScheme(context).secondary,
                arrowCircleColor: colorScheme(context).surface,
                text: AppLocalizations.of(context)!.save,
                backgroundColor: colorScheme(context).secondary,
                onPressed: () {
                  // context.pushNamed(AppRoute.salaryCard);
                  context.pop();
                  // controller.createSellerBankAccount(
                  //   context: context,
                  //   bankName: bankname.text,
                  //   accountNumber: accountnumber.text,
                  //   accountType: accounttype.text,
                  //   accountHolderName: accountholdername.text,
                  //   email: email.text,
                  //   onSuccess: (message) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(content: Text(message)),
                  //     );
                  //   },
                  //   onError: (error) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(content: Text(error)),
                  //     );
                  //   },
                  // );
                }),
          ],
        ),
      ),
    );
  }
}
