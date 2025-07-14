import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/user/auth/repository/auth_repository.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../common/constants/app_images.dart';

class CreateStripeAccount extends StatefulWidget {
  @override
  _CreateStripeAccountState createState() => _CreateStripeAccountState();
}

class _CreateStripeAccountState extends State<CreateStripeAccount> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController countryCtrl = TextEditingController();

  String? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? businessType = 'individual';
  String? businessName;
  Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    emailCtrl.text = StaticData.email;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Stripe Account',
        onLeadingPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Email',
                style: textTheme(context).bodyMedium?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                validationType: ValidationType.email,
                // isEnabled: false,
                readOnly: true,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                borderRadius: 12,
                inputAction: TextInputAction.next,
                controller: emailCtrl,
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
              SizedBox(height: 16),
              Text(
                'Country',
                style: textTheme(context).bodyMedium?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                validator: (va) {
                  if (va!.isEmpty) {
                    return 'Please select Your Coutry';
                  } else {
                    return null;
                  }
                },
                onTap: () {
                  log('------------');
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    onSelect: (Country country) {
                      setState(() {
                        selectedCountry = country;
                        countryCtrl.text = country.countryCode;
                      });
                    },
                  );
                },
                readOnly: true,
                hint: 'Select Country',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                borderRadius: 12,
                inputAction: TextInputAction.next,
                controller: countryCtrl,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 60,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                prefixIcon: selectedCountry != null
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          selectedCountry!.flagEmoji,
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : null,
                isDense: true,
              ),
              SizedBox(height: 24),
              CustomButton(
                  text: 'Submit',
                  iconColor: colorScheme(context).secondary,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      context.loaderOverlay.show();

                      log('--------${StaticData.userId}');
                      log('--------${StaticData.email}');
                      log('--------${countryCtrl.text}');

                      await AuthRepositary()
                          .createStripeAccount(
                              id: StaticData.userId,
                              email: StaticData.email,
                              country: countryCtrl.text)
                          .then((onValue) {
                        context.loaderOverlay.hide();
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
