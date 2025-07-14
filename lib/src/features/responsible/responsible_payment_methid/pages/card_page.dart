// ignore_for_file: must_be_immutable, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/provider/payment_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/widget/appbar.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CardPage extends StatelessWidget {
  CardPage({super.key});

  TextEditingController cardNameContrller = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  List<String> years =
      List<String>.generate(51, (index) => (2000 + index).toString());

  @override
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  @override
  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentProvider>(context);

    var m = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: PaymentAppBar(title: 'Add Payment method')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              // Image.asset(
              //   AppImages.cardImage,
              //   fit: BoxFit.cover,
              //   height: 200,
              // ),
              CustomContainer(
                color: colorScheme(context).onSurface,
                borderRadius: 5,
                width: 343,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                AppIcons.chipIcon,
                                height: 25,
                              ),
                              SvgPicture.asset(
                                AppIcons.bankLogo,
                                height: 25,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '* * * *  * * * *  * * * *  3947',
                            style: textTheme(context).bodyLarge?.copyWith(
                                  color: colorScheme(context).surface,
                                  fontSize: 16,
                                ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Card Holder Name',
                                    style:
                                        textTheme(context).bodyLarge?.copyWith(
                                              color: colorScheme(context)
                                                  .surface
                                                  .withOpacity(.6),
                                              fontSize: 11,
                                            ),
                                  ),
                                  Text(
                                    'John Henry',
                                    style: textTheme(context)
                                        .bodyLarge
                                        ?.copyWith(
                                          color: colorScheme(context).surface,
                                          fontSize: 13,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Expiry Date',
                                    style:
                                        textTheme(context).bodyLarge?.copyWith(
                                              color: colorScheme(context)
                                                  .surface
                                                  .withOpacity(.6),
                                              fontSize: 11,
                                            ),
                                  ),
                                  Text(
                                    '05/23',
                                    style: textTheme(context)
                                        .bodyLarge
                                        ?.copyWith(
                                          color: colorScheme(context).surface,
                                          fontSize: 13,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CustomContainer(
                                  height: 45,
                                  width: 45,
                                  borderColor: AppColor.textFieldHintColor,
                                  borderRadius: 4,
                                  color: colorScheme(context).surface,
                                  child: Center(
                                    child: SvgPicture.asset(
                                        AppIcons.masterCardIcon),
                                  )),
                            ],
                          ),
                        ])),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter your payment details',
                  style: textTheme(context).titleSmall?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(.7),
                      fontWeight: FontWeight.w300,
                      fontSize: 13),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'By continuing you agree to our',
                    style: textTheme(context).titleSmall?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(.7),
                        fontWeight: FontWeight.w300,
                        fontSize: 13),
                  ),
                  TextSpan(
                    text: ' Terms',
                    style: textTheme(context).titleSmall?.copyWith(
                        color: colorScheme(context).secondary,
                        fontWeight: FontWeight.w300,
                        fontSize: 13),
                  ),
                ])),
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                validationType: ValidationType.name,
                controller: cardNameContrller,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                fillColor: colorScheme(context).surface,
                borderRadius: 5,
                focusBorderColor: AppColor.textFieldHintColor.withOpacity(.6),
                borderColor: AppColor.appGreyColor.withOpacity(.15),
                isDense: true,
                hint: 'Name on Card',
                hintColor: AppColor.textFieldHintColor,
                hintSize: 13,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                controller: cardNumberController,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Card Number'),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                fillColor: colorScheme(context).surface,
                borderRadius: 5,
                focusBorderColor: AppColor.textFieldHintColor.withOpacity(.6),
                borderColor: AppColor.appGreyColor.withOpacity(.15),
                isDense: true,
                hint: 'Card Number',
                hintColor: AppColor.textFieldHintColor,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                hintSize: 13,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomContainer(
                    width: m.width * .45,
                    color: colorScheme(context).surface,
                    borderRadius: 5,
                    borderColor: provider.cardMonthsText.contains('Months')
                        ? colorScheme(context).error
                        : AppColor.textFieldHintColor,
                    child: Consumer<PaymentProvider>(
                      builder: (context, newValue, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            newValue.cardMonthsText,
                            style: textTheme(context).labelSmall?.copyWith(
                                color: AppColor.appGreyColor.withOpacity(.75),
                                fontSize: 14),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: PopupMenuButton<String>(
                              icon: Center(
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: 25,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.4),
                                ),
                              ),
                              onSelected: (String value) {
                                newValue.cardMonthsTextTextGet(value);
                              },
                              itemBuilder: (BuildContext context) {
                                return months
                                    .map<PopupMenuItem<String>>((String value) {
                                  return PopupMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomContainer(
                    width: m.width * .45,
                    color: colorScheme(context).surface,
                    borderRadius: 5,
                    borderColor: provider.cardYearText.contains('Year')
                        ? colorScheme(context).error
                        : AppColor.textFieldHintColor,
                    child: Consumer<PaymentProvider>(
                      builder: (context, newValue, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(newValue.cardYearText,
                              style: textTheme(context).labelSmall?.copyWith(
                                  color: AppColor.appGreyColor.withOpacity(.75),
                                  fontSize: 14)),
                          Spacer(),
                          SizedBox(
                            height: 50,
                            child: PopupMenuButton<String>(
                              padding: EdgeInsets.all(0),
                              menuPadding: EdgeInsets.all(0),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.4),
                              ),
                              onSelected: (String value) {
                                newValue.cardYearTextTextGet(value);
                              },
                              itemBuilder: (BuildContext context) {
                                return years
                                    .map<PopupMenuItem<String>>((String value) {
                                  return PopupMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    width: m.width * 0.45,
                    child: CustomTextFormField(
                      controller: cvcController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your CVC';
                        } else {
                          return null;
                        }
                      },
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      fillColor: colorScheme(context).surface,
                      borderRadius: 5,
                      focusBorderColor:
                          AppColor.textFieldHintColor.withOpacity(.6),
                      borderColor: AppColor.appGreyColor.withOpacity(.15),
                      isDense: true,
                      hint: 'CVC',
                      hintColor: AppColor.textFieldHintColor,
                      hintSize: 13,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: m.width * 0.4,
                    child: Text(
                      '3 or 4 digits usually found on the signature strip',
                      style: textTheme(context).labelSmall?.copyWith(
                          fontSize: 10,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w400,
                          color: AppColor.appGreyColor.withOpacity(.7)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Consumer<PaymentProvider>(
                builder: (context, value, child) => Align(
                  alignment: Alignment.centerLeft,
                  child: Transform.scale(
                      scaleY: 0.8,
                      scaleX: 0.85,
                      child: Switch(
                        activeTrackColor: colorScheme(context).secondary,
                        inactiveTrackColor:
                            AppColor.appGreyColor.withOpacity(.5),
                        value: value.cardDataSwitch,
                        onChanged: (val) {
                          value.cardDataSwitchToggle();
                        },
                        inactiveThumbColor: colorScheme(context).surface,
                        trackOutlineColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        thumbIcon: WidgetStatePropertyAll(Icon(
                          Icons.circle,
                          color: value.paymentSwitch == true
                              ? AppColor.textFieldHintColor
                              : colorScheme(context).surface,
                          size: 30,
                        )),
                      )),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              CustomButton(
                text: 'Add now',
                onPressed: () {
                  if (_formkey.currentState!.validate() &&
                      provider.cardMonthsText != 'Months' &&
                      provider.cardYearText != 'Year') {
                    context.pushReplacementNamed(AppRoute.responsibleBottomBar);
                  }
                },
                height: 55,
                arrowCircleRadius: 20,
                iconColor: colorScheme(context).secondary,
                backgroundColor: colorScheme(context).secondary,
                arrowCircleColor: colorScheme(context).surface,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
