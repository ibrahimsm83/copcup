import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/provider/payment_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/widget/appbar.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChangePaymentMethodPage extends StatelessWidget {
  ChangePaymentMethodPage({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: PaymentAppBar(title: 'Change Payment method'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Full Name',
                  style: textTheme(context)
                      .bodyLarge
                      ?.copyWith(color: colorScheme(context).onSurface),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  validationType: ValidationType.name,
                  controller: nameController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  fillColor: colorScheme(context).surface,
                  borderRadius: 5,
                  focusBorderColor: AppColor.textFieldHintColor.withOpacity(
                      .6), //AppColor.appGreyColor.withOpacity(.15),
                  borderColor: AppColor.appGreyColor.withOpacity(.15),
                  isDense: true,
                  hint: 'Placeholders',
                  hintColor: AppColor.textFieldHintColor,
                  hintSize: 13,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Street Address',
                  style: textTheme(context)
                      .bodyLarge
                      ?.copyWith(color: colorScheme(context).onSurface),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  controller: streetController,
                  validationType: ValidationType.address,
                  fillColor: colorScheme(context).surface,
                  borderRadius: 5,
                  focusBorderColor: AppColor.textFieldHintColor.withOpacity(
                      .6), //AppColor.appGreyColor.withOpacity(.15),
                  borderColor: AppColor.appGreyColor.withOpacity(.15),
                  isDense: true,
                  hint: 'Placeholders',
                  hintColor: AppColor.textFieldHintColor,
                  hintSize: 13,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'State',
                  style: textTheme(context)
                      .bodyLarge
                      ?.copyWith(color: colorScheme(context).onSurface),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  autoValidateMode: AutovalidateMode.onUserInteraction,

                  controller: stateController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'please enter your state';
                    } else {
                      return null;
                    }
                  },

                  fillColor: colorScheme(context).surface,
                  borderRadius: 5,
                  focusBorderColor: AppColor.textFieldHintColor.withOpacity(
                      .6), //AppColor.appGreyColor.withOpacity(.15),
                  borderColor: AppColor.appGreyColor.withOpacity(.15),
                  isDense: true,
                  hint: 'Placeholders',
                  hintColor: AppColor.textFieldHintColor,
                  hintSize: 13,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'City',
                  style: textTheme(context)
                      .bodyLarge
                      ?.copyWith(color: colorScheme(context).onSurface),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  // validationType: ValidationType.none,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'please enter your city name';
                    } else {
                      return null;
                    }
                  },

                  controller: cityController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  fillColor: colorScheme(context).surface,
                  borderRadius: 5,
                  focusBorderColor: AppColor.textFieldHintColor.withOpacity(
                      .6), //AppColor.appGreyColor.withOpacity(.15),
                  borderColor: AppColor.appGreyColor.withOpacity(.15),
                  isDense: true,
                  hint: 'Placeholders',
                  hintColor: AppColor.textFieldHintColor,
                  hintSize: 13,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Postal Code',
                  style: textTheme(context)
                      .bodyLarge
                      ?.copyWith(color: colorScheme(context).onSurface),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  // validationType: ValidationType.none,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'please enter your postal code';
                    } else {
                      return null;
                    }
                  },

                  fillColor: colorScheme(context).surface,
                  borderRadius: 5,
                  focusBorderColor: AppColor.textFieldHintColor.withOpacity(
                      .6), //AppColor.appGreyColor.withOpacity(.15),
                  borderColor: AppColor.appGreyColor.withOpacity(.15),
                  isDense: true,
                  hint: 'Placeholders',
                  hintColor: AppColor.textFieldHintColor,
                  hintSize: 13,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Consumer<PaymentProvider>(
                      builder: (context, value, child) => Transform.scale(
                          scaleY: 0.8,
                          scaleX: 0.85,
                          child: Switch(
                            activeTrackColor: colorScheme(context).secondary,
                            trackOutlineColor:
                                WidgetStatePropertyAll(Colors.transparent),
                            inactiveTrackColor:
                                AppColor.appGreyColor.withOpacity(.5),
                            value: value.paymentSwitch,
                            onChanged: (val) {
                              value.paymentSwitchToggle();
                            },
                            thumbIcon: WidgetStatePropertyAll(Icon(
                              Icons.circle,
                              color: value.paymentSwitch == true
                                  ? AppColor.textFieldHintColor
                                  : colorScheme(context).surface,
                              size: 30,
                            )),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'SET AS DEFAULT',
                      style: textTheme(context).bodySmall?.copyWith(
                          color: colorScheme(context).onSurface.withOpacity(.7),
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                          fontSize: 11),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomContainer(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: 140,
                      borderRadius: 100,
                      borderColor: colorScheme(context).secondary,
                      child: Center(
                        child: Text(
                          'Delete',
                          style: textTheme(context).titleSmall?.copyWith(
                              color: colorScheme(context).secondary,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    CustomContainer(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.pushNamed(AppRoute.addPaymentPage);
                        }
                      },
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: 140,
                      borderRadius: 100,
                      color: colorScheme(context).secondary,
                      borderColor: colorScheme(context).secondary,
                      child: Center(
                        child: Text(
                          'Save',
                          style: textTheme(context).titleSmall?.copyWith(
                              color: colorScheme(context).surface,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
