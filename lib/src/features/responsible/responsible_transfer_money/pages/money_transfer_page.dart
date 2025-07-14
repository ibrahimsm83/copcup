import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/resposible_transfer_provider/reposible_transfer_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/money_transfer_appBar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/transfe_money_amount_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/transfer_money_custom_button.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MoneyTransferPage extends StatefulWidget {
  MoneyTransferPage({super.key});

  @override
  State<MoneyTransferPage> createState() => _MoneyTransferPageState();
}

class _MoneyTransferPageState extends State<MoneyTransferPage> {
  TextEditingController accountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? validatePhoneNumber(String? value) {
    // Regular expression pattern for phone number (customize as needed)
    String pattern = r'^(?:[+0]9)?[0-9]{10,12}$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  bool validationStatu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: MoneyTransferAppbar(titil: 'Money Transfer')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransfeMoneyWidget(),
              Consumer<ResponsibleTransferProvider>(
                builder: (context, value, child) => TextFormField(
                  controller: accountController,
                  validator: (validator) {
                    if (validator == null || validator.isEmpty) {
                      return 'Please enter your account number';
                    } else if (!value.accountNumberRegex.hasMatch(validator)) {
                      return 'Account number must be 10 digits';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (val) {
                    value.updateAccountValidation(val);
                  },
                  decoration: InputDecoration(
                      hintText: '0931-5131-5321-6477',
                      hintStyle: textTheme(context).bodyMedium?.copyWith(
                            color: AppColor.appGreyColor.withOpacity(.75),
                          ),
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme(context).secondary),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme(context).secondary),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme(context).secondary),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme(context).secondary),
                      ),
                      suffixIcon: value.validatetrue == true
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: 15,
                                width: 15,
                                child: Icon(
                                  Icons.check,
                                  size: 10,
                                  color: colorScheme(context).surface,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorScheme(context).secondary,
                                ),
                              ),
                            )
                          : SizedBox()),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                  child: TransferMoneyCustomButton(
                text: 'Next',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.pushNamed(AppRoute.selectCardPage);
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
