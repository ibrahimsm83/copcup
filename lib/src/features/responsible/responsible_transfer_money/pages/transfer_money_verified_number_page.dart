import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/resposible_transfer_provider/reposible_transfer_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/money_transfer_appBar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/transfer_money_custom_button.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TransferMoneyVerifiedNumberPage extends StatelessWidget {
  TransferMoneyVerifiedNumberPage({super.key});

  @override
  TextEditingController verifiedNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: MoneyTransferAppbar(titil: 'Verify your Number')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Please verify your\nPhone Number',
                  textAlign: TextAlign.center,
                  style: textTheme(context)
                      .titleSmall
                      ?.copyWith(color: AppColor.appGreyColor.withOpacity(.75)),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter Verification Code (5-digit)',
                    textAlign: TextAlign.center,
                    style: textTheme(context).titleSmall?.copyWith(
                        color: AppColor.appGreyColor.withOpacity(.75),
                        fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<ResponsibleTransferProvider>(
                  builder: (context, value, child) => TextFormField(
                    onChanged: (val) {
                      if (val.length >= 5) {
                        value.updateverifyNumberValidation(true);

                        if (val.length > 5) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Only 5 digits are allowed'),
                              backgroundColor: Colors.red,
                            ),
                          );

                          verifiedNumberController.text = val.substring(0, 5);

                          verifiedNumberController.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                                offset: verifiedNumberController.text.length),
                          );
                        }
                      } else {
                        value.updateverifyNumberValidation(false);
                      }
                    },
                    controller: verifiedNumberController,
                    validator: (validator) {
                      if (validator!.isEmpty) {
                        return 'Please enter a Verification Code';
                      } else if (validator.length < 5) {
                        return 'Enter the correct code';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '56234',
                      hintStyle: textTheme(context).bodyMedium?.copyWith(
                            color: AppColor.appGreyColor.withOpacity(.75),
                          ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.appGreyColor.withOpacity(.75)),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.appGreyColor.withOpacity(.75)),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme(context).error),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.appGreyColor.withOpacity(.75)),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme(context).secondary),
                      ),
                      suffixIcon: value.verifyNumber == false
                          ? SizedBox()
                          : Padding(
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
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TransferMoneyCustomButton(
                  text: 'Verify',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .pushReplacementNamed(AppRoute.responsibleBottomBar);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
