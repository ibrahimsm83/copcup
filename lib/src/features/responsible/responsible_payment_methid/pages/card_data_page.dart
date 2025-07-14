import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/provider/payment_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/widget/appbar.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CardDataPage extends StatelessWidget {
  CardDataPage({super.key});
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
  bool monthtext = false;
  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size;
    final provider = Provider.of<PaymentProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: PaymentAppBar(title: 'Add Payment method'),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
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
                validator: (value) =>
                    Validation.fieldValidation(value, 'Card Number'),
                controller: cardNumberController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                fillColor: colorScheme(context).surface,
                borderRadius: 5,
                focusBorderColor: AppColor.textFieldHintColor.withOpacity(.6),
                borderColor: AppColor.appGreyColor.withOpacity(.15),
                isDense: true,
                hint: 'Card Number',
                hintColor: AppColor.textFieldHintColor,
                hintSize: 13,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
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
                    // padding: EdgeInsets.symmetric(horizontal: 20),
                    color: colorScheme(context).surface,
                    borderRadius: 5,
                    borderColor: provider.monthsText.contains('Months')
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
                            newValue.monthsText,
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
                                newValue.monthTextGet(value);
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
                    // padding: EdgeInsets.symmetric(horizontal: 20),
                    color: colorScheme(context).surface,
                    borderRadius: 5,
                    borderColor: provider.yearText.contains('Year')
                        ? colorScheme(context).error
                        : AppColor.textFieldHintColor,
                    child: Consumer<PaymentProvider>(
                      builder: (context, newValue, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(newValue.yearText,
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
                                newValue.yearTextGet(value);
                                // Handle year selection here
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
                        value: value.addDataSwitch,
                        onChanged: (val) {
                          value.addDataSwitchSwitchToggle();
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
                height: 100,
              ),
              CustomButton(
                text: 'Add now',
                onPressed: () {
                  if (_formkey.currentState!.validate() &&
                      provider.monthsText != 'Months' &&
                      provider.yearText != 'Year') {
                    context.pushNamed(AppRoute.cardPage);
                  }
                },
                height: 55,
                arrowCircleRadius: 20,
                iconColor: colorScheme(context).secondary,
                backgroundColor: colorScheme(context).secondary,
                arrowCircleColor: colorScheme(context).surface,
              )
            ],
          ),
        ),
      ),
    );
  }
}
